#!/bin/sh
# Stop: warn when the turn ends with uncommitted work sitting on a protected branch.
#
# Does not block. The PreToolUse guard already refuses commits there; this only
# makes the situation visible, since work done on main is easy to miss until
# you try to commit it.
#
# POSIX sh only -- runs under macOS /bin/sh and Linux dash alike.

command -v git >/dev/null 2>&1 || exit 0
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

branch=$(git symbolic-ref --short HEAD 2>/dev/null) || exit 0

case "$branch" in
    main|master|trunk) ;;
    *) exit 0 ;;
esac

[ -n "$(git status --porcelain 2>/dev/null)" ] || exit 0

printf '{"systemMessage":"Uncommitted changes on protected branch %s. Move them to a branch: git switch -c <name>"}\n' "$branch"
exit 0
