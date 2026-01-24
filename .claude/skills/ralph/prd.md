---
name: prd
description: Generate a Product Requirements Document (PRD) for a new feature. Use when planning a feature, starting a new project, or when asked to create a PRD. Triggers on: create a prd, write prd for, plan this feature, requirements for, spec out.
---

# PRD Generation Skill

You are a product requirements expert. When this skill is invoked, generate a comprehensive Product Requirements Document (PRD) for the user's feature or project.

## PRD Generation Process

### Step 1: Gather Context

Before writing the PRD, ask clarifying questions if the user's request is vague:
- What problem does this solve?
- Who are the target users?
- Are there any technical constraints?
- What is the scope (MVP vs full feature)?

If the user has provided sufficient context, proceed directly to PRD creation.

### Step 2: Generate the PRD

Create a file named `PRD.md` in the project root with the following structure:

```markdown
# PRD: [Feature/Project Name]

## Introduction

[2-3 sentences explaining what this feature/project does and why it matters]

## Goals

- [Primary goal]
- [Secondary goals as bullet points]

## User Stories

### US-001: [Story Title]
**Description:** As a [user type], I want [capability] so that [benefit].

**Acceptance Criteria:**
- [ ] [Specific, testable criterion]
- [ ] [Another criterion]
- [ ] Typecheck passes (if applicable)

### US-002: [Next Story]
[Continue pattern...]

## Non-Goals

- [Explicit things NOT in scope]
- [Helps prevent scope creep]

## Technical Considerations

- [Architecture decisions]
- [Dependencies or constraints]
- [Security considerations if relevant]
```

### Step 3: Create progress.txt Template

After creating the PRD.md, create a `progress.txt` file in the project root with the following template:

```markdown
# Progress Log

## Learnings
(Patterns discovered during implementation)

---

```

This file serves two purposes:
1. **Learnings section** - Ralph reads this first to check for patterns from previous iterations
2. **Iteration logs** - Each Ralph iteration appends its progress notes here

If `progress.txt` already exists, do NOT overwrite it - the existing learnings are valuable.

### Step 4: Guidelines for Good PRDs

1. **User Stories should be small and atomic** - Each story should be completable in one iteration
2. **Acceptance criteria must be testable** - Use checkboxes that can be verified
3. **Order stories by dependency** - Put foundational work first
4. **Include a "Typecheck passes" criterion** when the project has TypeScript/type checking
5. **Keep the PRD focused** - One feature per PRD, split large projects into phases

### Step 5: Setup ralph.sh

Before telling the user the PRD is ready, ensure `ralph.sh` exists in the project root:

1. **Check if ralph.sh exists** in the project root directory
2. **If ralph.sh does NOT exist:**
   - Create `ralph.sh` in the project root with this content:
   ```bash
   #!/bin/bash
   # Ralph - Autonomous implementation loop
   # Runs Claude Code iteratively until PRD is complete

   MAX_ITERATIONS=${1:-50}
   ITERATION=0

   echo "Starting Ralph autonomous loop (max $MAX_ITERATIONS iterations)..."

   while [ $ITERATION -lt $MAX_ITERATIONS ]; do
       ITERATION=$((ITERATION + 1))
       echo ""
       echo "=== Iteration $ITERATION ==="

       # Run Claude Code with the Ralph agent prompt
       OUTPUT=$(claude -p "You are Ralph, an autonomous coding agent. Do exactly ONE task per iteration.

   ## Steps

   1. Read PRD.md and find the first task that is NOT complete (marked [ ]).
   2. Read progress.txt - check the Learnings section first for patterns from previous iterations.
   3. Implement that ONE task only.
   4. Run tests/typecheck to verify it works.

   ## Critical: Only Complete If Tests Pass

   - If tests PASS:
     - Update PRD.md to mark the task complete (change [ ] to [x])
     - Commit your changes with message: feat: [task description]
     - Append what worked to progress.txt

   - If tests FAIL:
     - Do NOT mark the task complete
     - Do NOT commit broken code
     - Append what went wrong to progress.txt (so next iteration can learn)

   ## Progress Notes Format

   Append to progress.txt using this format:

   ## Iteration [N] - [Task Name]
   - What was implemented
   - Files changed
   - Learnings for future iterations:
     - Patterns discovered
     - Gotchas encountered
     - Useful context
   ---

   ## Update AGENTS.md (If Applicable)

   If you discover a reusable pattern that future work should know about:
   - Check if AGENTS.md exists in the project root
   - Add patterns like: 'This codebase uses X for Y' or 'Always do Z when changing W'
   - Only add genuinely reusable knowledge, not task-specific details

   ## End Condition

   After completing your task, check PRD.md:
   - If ALL tasks are [x], output exactly: <promise>COMPLETE</promise>
   - If tasks remain [ ], just end your response (next iteration will continue)
   " 2>&1)

       echo "$OUTPUT"

       # Check if Ralph signaled completion
       if echo "$OUTPUT" | grep -q "<promise>COMPLETE</promise>"; then
           echo ""
           echo "=== PRD Complete! ==="
           echo "All tasks finished in $ITERATION iterations."
           exit 0
       fi
   done

   echo ""
   echo "=== Max iterations reached ==="
   echo "Stopped after $MAX_ITERATIONS iterations. Check PRD.md for remaining tasks."
   exit 1
   ```
   - Make the file executable with `chmod +x ralph.sh`
   - Tell the user: "Created ralph.sh - run ./ralph.sh to start autonomous implementation"

3. **If ralph.sh ALREADY exists:**
   - Ask the user: "ralph.sh already exists. Would you like to overwrite it with the latest version? (y/n)"
   - Only overwrite if the user confirms with 'y' or 'yes'
   - If user declines, keep the existing file and proceed

### Step 6: After PRD Creation

Tell the user:
1. Review the PRD and adjust as needed
2. Run `./ralph.sh` to start the autonomous implementation loop
3. Each iteration will complete one user story until the PRD is done

## Example Output

When invoked with `/prd add user authentication`, create a PRD.md like:

```markdown
# PRD: User Authentication

## Introduction

Add secure user authentication to allow users to create accounts, log in, and maintain sessions. This enables personalized features and protects user data.

## Goals

- Enable secure user registration and login
- Support session management with proper security
- Provide password reset functionality

## User Stories

### US-001: Create user registration endpoint
**Description:** As a new user, I want to create an account so that I can access personalized features.

**Acceptance Criteria:**
- [ ] POST /api/auth/register accepts email and password
- [ ] Passwords are hashed before storage
- [ ] Duplicate emails return appropriate error
- [ ] Typecheck passes

### US-002: Create login endpoint
**Description:** As a registered user, I want to log in so that I can access my account.

**Acceptance Criteria:**
- [ ] POST /api/auth/login validates credentials
- [ ] Returns JWT token on success
- [ ] Rate limiting prevents brute force
- [ ] Typecheck passes

## Non-Goals

- Social OAuth login (future phase)
- Two-factor authentication (future phase)
- Admin user management interface

## Technical Considerations

- Use bcrypt for password hashing
- JWT tokens with 24h expiry
- Store refresh tokens in httpOnly cookies
```
