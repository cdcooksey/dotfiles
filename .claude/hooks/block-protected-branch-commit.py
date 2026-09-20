#!/usr/bin/env python3
"""PreToolUse/Bash guard: refuse writes to protected branches.

Denies `git commit` made while HEAD is on a protected branch, and `git push`
whose destination is a protected branch. Reads the hook payload on stdin.

Fails open: if git errors, hangs, or is absent, the command is allowed.
"""
import json
import os
import re
import shlex
import subprocess
import sys

PROTECTED = {"main", "master", "trunk"}

# git-compatible wrappers to inspect. False exempts one.
# yadm tracks dotfiles on its default branch by design, so it is exempt.
WRAPPERS = {"git": True, "yadm": False}

# Global git options that consume a following value.
GLOBAL_OPTS_WITH_VALUE = {"-C", "-c", "--git-dir", "--work-tree", "--namespace", "--exec-path"}

# `git push` options that consume a following value.
PUSH_OPTS_WITH_VALUE = {"--repo", "-o", "--push-option", "--receive-pack", "--exec"}

SHELL_OPERATORS = {"&&", "||", ";", "|", "&"}


def allow():
    sys.exit(0)


def deny(reason):
    json.dump(
        {
            "hookSpecificOutput": {
                "hookEventName": "PreToolUse",
                "permissionDecision": "deny",
                "permissionDecisionReason": reason,
            }
        },
        sys.stdout,
    )
    sys.exit(0)


def invocations(tokens):
    """Yield (wrapper, subcommand, dir_override, rest) for each git-like call."""
    i = 0
    while i < len(tokens):
        name = os.path.basename(tokens[i])
        if name not in WRAPPERS:
            i += 1
            continue
        i += 1
        dir_override = None
        subcommand = None
        while i < len(tokens):
            tok = tokens[i]
            if tok in GLOBAL_OPTS_WITH_VALUE:
                if tok == "-C" and i + 1 < len(tokens):
                    dir_override = tokens[i + 1]
                i += 2
            elif tok.startswith("-"):
                i += 1
            else:
                subcommand = tok
                i += 1
                break
        if subcommand is None:
            return
        rest = []
        while i < len(tokens) and tokens[i] not in SHELL_OPERATORS:
            if os.path.basename(tokens[i]) in WRAPPERS:
                break
            rest.append(tokens[i])
            i += 1
        yield name, subcommand, dir_override, rest


def current_branch(wrapper, cwd):
    for args in (["symbolic-ref", "--short", "HEAD"], ["rev-parse", "--abbrev-ref", "HEAD"]):
        try:
            out = subprocess.run(
                [wrapper] + args, cwd=cwd, capture_output=True, text=True, timeout=5
            )
        except (OSError, subprocess.SubprocessError):
            return None
        if out.returncode == 0:
            branch = out.stdout.strip()
            if branch and branch != "HEAD":
                return branch
    return None


def normalise_ref(ref):
    ref = ref.lstrip("+")
    dst = ref.split(":", 1)[1] if ":" in ref else ref
    return dst.replace("refs/heads/", "").strip()


def push_targets(rest):
    """Branch names a `git push` would write to, or None to mean 'current branch'."""
    if any(opt in rest for opt in ("--all", "--mirror")):
        return list(PROTECTED)
    positional = []
    skip_next = False
    for tok in rest:
        if skip_next:
            skip_next = False
            continue
        if tok in PUSH_OPTS_WITH_VALUE:
            skip_next = True
        elif not tok.startswith("-"):
            positional.append(tok)
    if len(positional) <= 1:
        return None
    return [normalise_ref(r) for r in positional[1:]]


def main():
    try:
        payload = json.load(sys.stdin)
    except (ValueError, OSError):
        allow()

    command = (payload.get("tool_input") or {}).get("command") or ""
    cwd = payload.get("cwd") or os.getcwd()

    if not re.search(r"\b(?:git|yadm)\b", command):
        allow()
    if "commit" not in command and "push" not in command:
        allow()

    try:
        tokens = shlex.split(command, comments=True)
    except ValueError:
        tokens = command.split()

    for wrapper, subcommand, dir_override, rest in invocations(tokens):
        if not WRAPPERS.get(wrapper):
            continue
        if subcommand not in ("commit", "push"):
            continue

        repo_dir = os.path.join(cwd, dir_override) if dir_override else cwd
        branch = current_branch(wrapper, repo_dir)

        if subcommand == "commit":
            if branch in PROTECTED:
                deny(
                    f"Refusing `{wrapper} commit`: HEAD is on the protected branch "
                    f"'{branch}'. Commits never go directly onto "
                    f"{'/'.join(sorted(PROTECTED))}, on any project. Branch first "
                    f"(`{wrapper} checkout -b <name>`) and commit there. Do not edit "
                    f"this hook or reach for another command to get around it."
                )
        else:
            targets = push_targets(rest)
            if targets is None:
                targets = [branch] if branch else []
            hit = sorted(set(targets) & PROTECTED)
            if hit:
                deny(
                    f"Refusing `{wrapper} push`: it would write to the protected "
                    f"branch '{hit[0]}'. Push your branch and open a PR instead. "
                    f"Do not edit this hook or reach for another command to get around it."
                )
    allow()


if __name__ == "__main__":
    main()
