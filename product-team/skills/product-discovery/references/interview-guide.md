# User Interview Guide

A Mom Test-based framework for conducting user interviews that reveal real behavior and uncover genuine opportunities. The core principle: ask about what people actually do, not what they think they would do.

## Mom Test Principles

From Rob Fitzpatrick's "The Mom Test" — three rules for useful conversations:

### Rule 1: Ask About Past Behavior, Not Future Intentions

| Bad (Opinion/Future) | Good (Behavior/Past) |
|---------------------|---------------------|
| "Would you use a feature that...?" | "Tell me about the last time you tried to..." |
| "Do you think this is a good idea?" | "What did you do when that happened?" |
| "How much would you pay for...?" | "What do you currently pay for solutions to this?" |

**Why:** People are terrible at predicting their own future behavior. They'll say "yes" to be polite. Past behavior is factual.

### Rule 2: Ask About Specifics, Not Generalities

| Bad (General) | Good (Specific) |
|--------------|----------------|
| "How often do you exercise?" | "Walk me through yesterday. Did you exercise? When, where, for how long?" |
| "Is this a big problem for you?" | "Last time this happened, what did you do? How much time did it take?" |

**Why:** Generalities invite idealized answers. Specifics force people to recall real events with real details.

### Rule 3: Talk Less, Listen More

- Aim for **80% listening, 20% talking**
- Let silence do the work — people fill pauses with valuable information
- Follow unexpected tangents — they often reveal the real insights
- Don't pitch your solution during the interview

## 5 Core Question Types

### 1. Context Questions

Understand the person's world before diving into problems.

- "Tell me about your role. What does a typical day/week look like?"
- "What tools do you currently use for [activity]?"
- "How long have you been doing [activity] this way?"
- "Who else is involved in [process]?"

### 2. Problem Questions

Uncover pain points through past experiences.

- "What's the hardest part about [activity]?"
- "Tell me about the last time [problem] happened. Walk me through it."
- "When was the last time you were frustrated with [process]?"
- "What takes more time than it should in your [workflow]?"
- "If you could wave a magic wand and fix one thing about [area], what would it be?"

### 3. Behavior Questions

Understand what people actually do (vs. what they say).

- "What did you do to solve that problem?"
- "Show me how you currently handle [task]." (screen share or demo)
- "Have you tried any other solutions? Which ones? What happened?"
- "How often does this actually come up? When was the last time?"
- "Did you end up doing anything about it, or did you just live with it?"

### 4. Workflow Questions

Map the full journey around a problem or task.

- "Walk me through [process] from start to finish."
- "What happens before you start [task]? After you finish?"
- "Where does this fit in your bigger workflow?"
- "Who do you hand this off to? What do they need from you?"
- "Where in the process do things usually go wrong?"

### 5. Emotional Questions

Reveal motivation, urgency, and willingness to change.

- "How did that make you feel when [problem] happened?"
- "On a scale of annoying to hair-on-fire, where does this sit?"
- "How important is solving this compared to other challenges you face?"
- "What would it mean for you/your team if this was solved?"
- "Have you actively looked for a solution? What did you search for?"

## Anti-Patterns

### Leading Questions

| Leading (Bad) | Neutral (Good) |
|--------------|---------------|
| "Don't you think it would be better if...?" | "How do you currently handle...?" |
| "Wouldn't it save time to...?" | "How much time does this take today?" |
| "You'd want a faster way to do this, right?" | "What matters most to you about this process?" |

### Hypothetical Questions

| Hypothetical (Bad) | Behavioral (Good) |
|-------------------|------------------|
| "If we built X, would you use it?" | "Tell me about the last time you needed something like X." |
| "Imagine you had a tool that..." | "What do you use today to handle this?" |
| "How would you feel if...?" | "How did you feel when that happened last time?" |

### Compliment-Seeking

| Fishing (Bad) | Neutral (Good) |
|--------------|---------------|
| "We're building something really cool..." | Start with questions, not pitches |
| "What do you think of this idea?" | "Tell me about your experience with [domain]" |
| Showing mockups first, then asking | Ask about problems first, show mockups only at the end (if at all) |

### Feature Pitching

| Pitching (Bad) | Discovering (Good) |
|---------------|-------------------|
| "Our solution does X, Y, and Z" | "What have you tried so far?" |
| Spending 15 min explaining your product | Spending 25 min listening to their reality |
| "This feature will solve your problem" | "What would a good solution look like to you?" |

## Interview Script Template (~30 minutes)

### Intro (2-3 min)

> "Thanks for taking the time today. I'm trying to understand how people [domain area]. There are no right or wrong answers — I'm genuinely curious about your experience. I might take some notes. Is that okay?"
>
> "Before we start, a quick note: I'm here to learn, not to sell anything. If something I ask doesn't make sense, just let me know."

**Key points:**
- Set expectations: learning mode, not selling mode
- Get permission to take notes or record
- Make them comfortable — this isn't a test

### Warm-up (3-5 min)

- "Tell me about your role. What do you spend most of your time on?"
- "How does [domain area] fit into your day-to-day?"
- [Follow up on anything interesting they mention]

**Goal:** Build rapport, understand their context, find natural segues to core topics.

### Core Questions (15-20 min)

Pick 3-5 questions from the types above, tailored to your opportunity area. Structure:

**Start broad, then drill into specifics:**

1. "What's the hardest part about [area]?" (Problem)
2. "Tell me about the last time that happened." (Behavior — specific instance)
3. "Walk me through what you did." (Workflow)
4. "Have you tried anything to solve this?" (Behavior)
5. "How important is fixing this to you?" (Emotional / Priority)

**Key follow-ups to always have ready:**
- "Can you tell me more about that?"
- "Why?"
- "What happened next?"
- "How did that work out?"
- "Can you give me a specific example?"

### Wrap-up (3-5 min)

- "Is there anything else about [domain area] that we haven't covered that you think is important?"
- "Who else do you think I should talk to about this?"
- "Would it be okay if I follow up with you later?"

**Thank them sincerely. Don't pitch your product at the end.**

## Post-Interview Synthesis

### Immediately After (< 30 min)

Capture while fresh. For each interview, document:

```markdown
## Interview Notes

**Date:** [YYYY-MM-DD]
**Participant:** [Anonymous ID, e.g., P-07]
**Segment:** [User type/persona]
**Duration:** [Minutes]

### Key Quotes
- "[Exact quote]" — context: [what they were describing]
- "[Exact quote]" — context: [what prompted this]

### Behavioral Patterns Observed
- [What they actually do, not what they say they do]
- [Workarounds they've built]
- [Tools/processes they use]

### Pain Points (evidenced)
- [Pain point + severity + frequency]
- [Pain point + severity + frequency]

### Surprises / Unexpected Insights
- [Anything you didn't expect to hear]

### Opportunity Statements
- "[Segment] needs a way to [desired outcome] because [reason]."
- "[Segment] needs a way to [desired outcome] because [reason]."
```

### Synthesis Framework: Affinity Diagram

After conducting 5+ interviews, synthesize findings into opportunities:

#### Step 1: Extract Atomic Insights

Pull individual observations from each interview. One insight per sticky note (physical or digital).

Examples:
- "P-03 spends 20 min every morning copying tasks from email to their task app"
- "P-05 stopped using the calendar integration because sync was unreliable"
- "P-07 uses a spreadsheet as a workaround for the missing reporting feature"

#### Step 2: Group by Theme

Cluster related insights into groups. Let patterns emerge — don't force categories.

Example groups:
- "Manual data entry is a daily burden" (P-01, P-03, P-06, P-09)
- "Users don't trust automated features" (P-02, P-05, P-08)
- "Reporting needs vary wildly by role" (P-04, P-07, P-10)

#### Step 3: Write Opportunity Statements

For each theme, write an opportunity statement:

> "[User segment] needs a way to [desired outcome] because [underlying reason discovered in research]."

#### Step 4: Feed into OST

These opportunity statements become the opportunity nodes in your Opportunity Solution Tree, connecting research directly to product decisions.

### Interview Cadence

For continuous discovery, maintain a steady rhythm:

| Stage | Cadence | Purpose |
|-------|---------|---------|
| Initial discovery | 8-12 interviews in 2-3 weeks | Build foundational understanding |
| Ongoing discovery | 1-2 interviews per week | Continuous learning, validate/invalidate |
| Pre-launch validation | 5-8 interviews in 1-2 weeks | Test specific solutions/prototypes |

**Recruiting tip:** Build a participant pool of 20-30 people. Rotate through them. Offer incentives ($25-50 gift cards are standard for 30-min sessions).
