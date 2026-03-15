---
name: tweet
description: Auto-generate and post X tweets from commit history
arguments:
  - name: type
    description: "Content type (bip, showcase, insight, tech, all)"
    required: false
  - name: days
    description: "Commit analysis period (default: 2 days)"
    required: false
---

Analyze commit history to auto-generate and post X tweets.

$ARGUMENTS
