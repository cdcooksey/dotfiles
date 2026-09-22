---
name: draft-comment
description: Use when the user invokes /draft-comment, or asks to draft, write, or word a PR/code review comment for a finding just discussed in this conversation. Produces a friendly, confidence-calibrated draft with code references and repro steps — never posts it.
---

# Draft Comment

Turns a finding already discussed in this conversation into a PR/review comment that's friendly, hedges when it isn't sure, and doesn't throw an unverified claim over the fence as if it were fact. This is a drafting skill only — it never posts anything (see the hard rule below).

## Hard rule

**This skill only produces a draft in chat. It never runs `gh pr comment`, `gh pr review`, or posts anything anywhere on its own initiative, regardless of how confident the finding is.**

- **On the user's own PRs:** once the draft is written, if confidence in it is high, it's fine to ask the user directly whether to post it ("want me to post this?"). Posting still requires an explicit yes for that specific comment — a past yes on a different comment doesn't carry over.
- **On anyone else's PR:** never post, and never treat a general "sounds good" as permission to post — this is categorical, no exceptions, regardless of confidence. Only proceed if the user gives clear, specific permission to post *this* comment on *that* PR. Producing the draft and asking "want me to post this?" is still fine; posting without an explicit per-instance yes is not.
- **If and only if the user says yes to posting:** add it as part of a PENDING review, never a published/submitted one. Use the GitHub review API (e.g. `gh api repos/{owner}/{repo}/pulls/{pr}/reviews` to create a review with no `event` field, then add comments to it) so it lands in "Files changed" as a draft only the user can see — do not use `gh pr comment` (posts immediately and publicly) and do not submit/publish the review (no `event: "COMMENT"` / `"APPROVE"` / `"REQUEST_CHANGES"`). The user submits the review themselves in the browser when they're ready.

## Posting mechanics — a PR takes exactly one pending review, with many comments on it

GitHub allows **one pending review per user per PR** — but that one review holds as many inline comments as you want. Multiple findings on the same PR are multiple comments on the *same* pending review, never multiple pending reviews. Do not try to create a second pending review for a second comment — it will fail, and that failure does not mean GitHub disallows multiple comments; it means you're using the wrong call for anything after the first.

**First comment on a PR (no pending review yet):**
```
gh api repos/{owner}/{repo}/pulls/{pr}/reviews --input payload.json
```
where `payload.json` is `{"commit_id": "...", "comments": [{"path": "...", "line": N, "side": "RIGHT", "body": "..."}]}` with **no `event` field** (that's what keeps it pending). This can include multiple comments in one `comments` array if several findings are ready at once — do that when possible, it's simpler than the next step.

**Adding another comment once a pending review already exists:** the REST `pulls/{pr}/reviews` call now fails with `"User can only have one pending review per pull request"` — that's GitHub confirming the review already exists, not refusing more comments. The REST single-comment endpoint (`pulls/{pr}/comments`) doesn't work either — it tries to implicitly wrap a new review around the comment and hits the same collision. The correct path is the GraphQL mutation, aimed at the *existing* review:

1. Find the pending review's GraphQL node id (its REST id is `databaseId` here, not `id`):
   ```graphql
   query { repository(owner: "...", name: "...") { pullRequest(number: N) {
     reviews(last: 5) { nodes { id databaseId state } }
   } } }
   ```
2. Add the comment to it — `AddPullRequestReviewCommentInput` takes `pullRequestReviewId`, `path`, `body`, and **`position`**, not `line`/`side` (introspect `AddPullRequestReviewCommentInput` if unsure rather than guessing the field names — they differ from the REST payload's shape):
   ```graphql
   mutation($reviewId: ID!, $path: String!, $body: String!, $position: Int!) {
     addPullRequestReviewComment(input: {pullRequestReviewId: $reviewId, path: $path, body: $body, position: $position}) {
       comment { id url }
     }
   }
   ```
   `position` is the legacy unified-diff position, **not the file's line number**: count 1 for the first line right after the hunk's `@@ ... @@` header, add 1 for every line shown in that hunk (context, `+`, or `-` all count), continuing across multiple hunks in the same file without resetting. Compute it by actually counting the diff hunk (`gh pr diff` piped through `cat -n`), not by estimating.
3. After adding, verify with a `reviews(last: 5) { nodes { databaseId state comments(first: 10) { nodes { path line body } } } }` query that both comments now sit on the *same* `databaseId`.

**`gh api`'s `-f` vs `-F` — this one fails silently:** `-f/--raw-field` is *always* a literal string, even if the value starts with `@` — it never reads a file, no error either way. Only `-F/--field` supports `@<path>`/`@-` to read the value from a file or stdin. Passing a comment body via `-f body=@comment.md` posts the literal 9-character string `@comment.md` as the whole comment, and the mutation reports success because from GitHub's side that string is a perfectly valid body — nothing about the response signals the mistake. Use `-F` whenever a value is coming from a file. After posting via any `@file` flag, fetch the comment back and check its actual length/content (e.g. `.body | length` and a prefix) rather than trusting a 200 response — success means the string you gave was accepted, not that it was the string you meant.

## When to use

- User invokes `/draft-comment` — the target is the most recent finding/theory discussed in the conversation, ideally one that's already been through `/prove-bug` or otherwise investigated.
- User asks to "draft a comment for this" / "word this for the PR" / "write this up for review."

If it's ambiguous which finding is the target, ask which.

## Confidence calibration — the core of this skill

Before drafting, assess how certain the finding actually is, using whatever's already been established in the conversation (a `/prove-bug` verdict, how much code was actually read vs. assumed, whether a repro was confirmed or just theorized):

- **High confidence** (verified — read the actual code path, confirmed the repro, or got a REAL verdict from `/prove-bug`): state the finding plainly, with the concrete evidence. It's fine to be direct here — hedging a verified finding is its own kind of unhelpful.
- **Moderate confidence** (plausible but not fully traced, or a `/prove-bug` verdict wasn't sought): frame it as a question or an observation, not an accusation — "I noticed X — could this happen if Y?" rather than "this is broken." Say explicitly what you didn't verify.
- **Low confidence** (a hunch, a pattern-match, something that looked off but wasn't traced through): either don't draft a comment for it (say so, and suggest investigating or running `/prove-bug` first), or draft it as a clearly-labeled open question with no implied verdict.

Never let a low- or moderate-confidence finding read as a confident bug report. The tone should openly account for the possibility the reviewer (Charlie) is wrong, not just perform politeness while asserting certainty underneath.

## Structure of the draft

1. **Friendly opener** — plain, human, no throat-clearing praise-sandwich filler. Get to the point without being curt or cold.
2. **The observation** — worded per the confidence level above. Reference the exact file/line/method.
3. **Code reference** — a fenced code block with the language tag (`` ```ruby ``, `` ```haml ``, etc.) showing the relevant snippet, not just a file:line pointer. Inline identifiers, method names, and options use backticks.
4. **Repro steps** — when the finding is a bug, give concrete steps or a concrete scenario (real inputs/state) that trigger it. If confidence is moderate/low, phrase the repro as "here's the scenario I'm picturing — does this match?" rather than asserting it happens.
5. **Suggested fix** — only include this section if confidence is fairly high in the suggestion itself (the fix being correct is a separate confidence judgment from the finding being real — a real bug can still have an uncertain fix). If the fix is uncertain, ask a question instead of prescribing one ("would doing X here work, or is there a reason it's built this way?").

## Notes

- Every code reference uses backticks for identifiers and language-tagged fenced blocks for snippets — never bare text for code.
- If the finding came from `/prove-bug` with an UNLIKELY or IMPOSSIBLE verdict, don't draft a comment at all — say so, since there's nothing to report.
- This produces one draft for one finding. For multiple findings, run it once per finding, or ask whether the user wants them combined into one comment.
- After drafting, stop — do not offer to post it as part of the same turn beyond a plain "want me to post this?" ask, and never proceed to posting without an explicit yes.
