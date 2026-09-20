# Working agreements

## Git

- **Never commit or push to `main`, `master` or `trunk`.** Any other branch is fine — `fix/`, `refactor/`, `docs/`, `test/`, whatever suits. A PreToolUse hook enforces this; do not edit it or reach for another command to get around it.
- Trunk-based development with forks. No gitflow, no long-lived release branches.
- Read-only git (`log`, `diff`, `show`, `blame`, `status`) is always fine. Use it to get context instead of guessing.
- `yadm` manages the dotfiles repo and follows the same rule: branch before committing to it, never onto its default branch.

## Verification

- Never claim something works without having run it. Name the command and show its output.
- "Tests pass" means you ran them and read the result. If you did not run them, say so.
- If part of the task is unfinished, blocked or skipped, say which part and why. Do not imply completeness you have not checked.

## Portability

- This config is shared between Arch Linux (personal) and macOS (work). Do not assume a tool exists — check for it.
- Prefer POSIX flags. `sed -i`, `date`, `readlink` and `stat` differ between GNU and BSD.
- macOS ships bash 3.2. Scripts meant for both machines are POSIX `sh`, not bash 4+.
- Commands handed over to run interactively must match the user's shell — fish on Linux. Hook scripts run under `sh`/`bash` regardless of the interactive shell.

## Working style

- Announce which skill is being used and why. It makes the session followable.
- Make routine judgement calls without asking. Ask when different readings lead to materially different work.
- Do not widen scope beyond what was asked.
