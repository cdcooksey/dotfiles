#!/bin/sh
# SessionStart: warn if the protected-branch guard cannot run.
#
# The guard fails open by design: if python3 is missing or the script is not
# executable, git commands are allowed through and nothing is said. On a machine
# where that happens you would believe you are protected when you are not.
# This makes that failure visible at session start instead.
#
# POSIX sh only -- must run under macOS's /bin/sh and Linux dash alike.

HOOK="${CLAUDE_GUARD_HOOK:-$HOME/.claude/hooks/block-protected-branch-commit.py}"
PY="${CLAUDE_GUARD_PYTHON:-python3}"

warn() {
    # Escape nothing fancy; these messages are fixed strings.
    printf '{"systemMessage":"Branch guard INACTIVE: %s. Commits to main are NOT being blocked."}\n' "$1"
    exit 0
}

command -v "$PY" >/dev/null 2>&1 || warn "$PY not found on PATH"
[ -f "$HOOK" ] || warn "hook script missing at $HOOK"
[ -x "$HOOK" ] || warn "hook script not executable at $HOOK"

# Confirm it actually denies, using a payload that needs no repo on disk:
# a bare `git push` in a directory git cannot read resolves to no branch, so
# instead assert the script parses and exits cleanly.
printf '{"tool_input":{"command":"ls"},"cwd":"/"}' | "$PY" "$HOOK" >/dev/null 2>&1 \
    || warn "hook script failed to execute"

exit 0
