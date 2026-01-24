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

### Step 3: Guidelines for Good PRDs

1. **User Stories should be small and atomic** - Each story should be completable in one iteration
2. **Acceptance criteria must be testable** - Use checkboxes that can be verified
3. **Order stories by dependency** - Put foundational work first
4. **Include a "Typecheck passes" criterion** when the project has TypeScript/type checking
5. **Keep the PRD focused** - One feature per PRD, split large projects into phases

### Step 4: After PRD Creation

Tell the user:
1. Review the PRD and adjust as needed
2. Run `./ralph.sh` to start the autonomous implementation loop (if ralph.sh exists)
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
