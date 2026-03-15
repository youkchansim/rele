---
name: tweet
description: >
  Analyze Scheduler app commit history to auto-generate and post X (Twitter) tweets.
  Categorizes commits into Build in Public, product showcase, ADHD insights, or tech decisions,
  generates tweets accordingly, and can post directly via X API.
  Invoked via /tweet command.
---

# X Auto-Posting Skill

Analyze Scheduler app commit history to auto-generate X tweets, confirm with user, and post.

## Argument Parsing

Extract from `$ARGUMENTS`:
- **type**: Content type (`bip`, `showcase`, `insight`, `tech`, `all`) — auto-recommend if omitted
- **days**: Commit analysis period (default: 2 days)

## Content Guidelines

**IMPORTANT: User-centric product content only.**
- Focus on changes that directly impact end users (new features, UX improvements)
- Skip internal implementation details (refactoring, code cleanup, bug fixes with no visible impact)
- Write for a global audience — avoid US-specific references or cultural idioms
- Write in English

## Workflow

### Step 1: Commit Analysis

```bash
# Fetch recent commit history
git log --oneline --since="{days} days ago" --no-merges
```

Analyze commit messages to:
1. Classify each commit by category (see content-strategy.md mapping rules)
   - feat/implement/add → showcase
   - fix/resolve → bip (struggle story)
   - improve/optimize/refactor → tech
   - UI/design/View → showcase (before/after)
   - AI/parsing/prompt → insight (Apple Intelligence)
   - HealthKit/health/energy → insight (ADHD)
   - Multiple commits → bip (dev log)
2. Assess change scope (commit count, files changed)
3. **Filter: only keep changes visible to end users**
4. Summarize key changes in human-readable language

### Step 2: Category Selection

**If type argument provided:** Proceed with that category directly.

**If type argument omitted:** Use AskUserQuestion to suggest a category.

Show commit analysis results and recommend the most suitable category based on user-facing impact:

```
Commit analysis:
- New features: 2 (voice input, quick action bar)
- UX improvements: 1 (calendar default view change)

Recommended: showcase (voice input has highest user impact)

1. bip — Build in Public dev log
2. showcase — Product showcase
3. insight — ADHD/productivity insight
4. tech — Tech decision sharing
5. all — Batch generate multiple categories
```

### Step 3: Tweet Generation

Write the tweet based on selected category and commit data.

**Rules:**

1. **Write in English** — global audience
2. **X algorithm optimization** (see content-strategy.md)
   - Single tweet: 71-280 characters
   - End with a reply-inducing question
   - 1-2 hashtags max
   - Minimize external links
3. **Apply viral hooks** (select from viral-hooks.md)
4. **Include specific numbers and facts** — extracted from commit data
5. **No hard-sell tone** — attract interest only
6. **User perspective only** — frame everything as user benefit, not developer achievement

**Output format:**

```
## Tweet Preview

---
[Tweet content — English]
---

Analytics:
- Characters: {N}
- Hook type: {hook template used}
- Category: {category}
- Engagement element: {reply-inducing question etc.}
- Optimal posting time: Wed 11 PM KST (matches US East morning, EU afternoon)
```

**For `all` type:** Generate one tweet per category, numbered for selection.

### Step 4: User Confirmation

Use AskUserQuestion:

```
What would you like to do with this tweet?

1. Post — Post to X now
2. Edit — Tell me what to change
3. Regenerate — Try a different style
4. Cancel
```

- **Edit request:** Apply feedback and re-confirm
- **Regenerate request:** Generate with different hook/structure

### Step 4.5: Media Attachment

When user selects "Post", use AskUserQuestion to check for media:

```
Attach media?

1. Post text only
2. Attach image/video — provide file path(s) (max 4, comma-separated)
```

- **"Text only":** Proceed to Step 5 without media
- **"Attach":** Use AskUserQuestion for file paths:
  ```
  Enter media file path(s), comma-separated (max 4):

  Example: /path/to/image.png, /path/to/screenshot.jpg
  ```
  Store paths in `MEDIA_PATH` and proceed to Step 5.

### Step 5: Post via X API

When user selects "Post":

**Without media:**
```bash
bash ~/.claude/plugins/x-poster/scripts/x-post.sh "tweet content"
```

**With media:**
```bash
bash ~/.claude/plugins/x-poster/scripts/x-post.sh "tweet content" "media_path1,media_path2"
```

**Result display:**
- Success: Show posted tweet URL
- Failure: Show error message + ask retry

**If API not configured:**
```
X API is not configured.

Setup instructions:
1. Get API keys at https://developer.x.com/en/portal/dashboard
2. Create ~/.x-poster.env (see ~/.claude/plugins/x-poster/.env.example)
3. Required vars: X_API_KEY, X_API_SECRET, X_ACCESS_TOKEN, X_ACCESS_TOKEN_SECRET

Copy tweet text to clipboard instead?
```

Show generated tweet text regardless and offer clipboard copy for manual posting.

## Thread Rules

For rich commit content or `bip` (dev log) category, generate a thread (4-8 tweets).

**Thread structure:**
1. **Hook tweet** — Most impactful one-liner + "🧵"
2. **Context** — Why you're building this
3. **Key content** — Core highlights (2-4 tweets)
4. **Closing** — End with question + CTA

For threads, call x-post.sh sequentially with `reply_to` parameter chaining.

## Reference Files

This skill references:
- `references/content-strategy.md` — Content strategy, commit→content mapping, algorithm optimization
- `references/viral-hooks.md` — 50 viral hook templates
- `references/tweet-examples.md` — Category-specific tweet examples
