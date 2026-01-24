# PRD: Distributable Ralph Skill for Claude Code

## Introduction

Create a shareable Claude Code skill that provides the `/prd` command for generating Product Requirements Documents. When users install this skill from GitHub, it automatically sets up `ralph.sh` (the autonomous implementation loop) and provides `progress.txt` template creation. This enables any developer to use the Ralph workflow in their own projects.

## Goals

- Provide a GitHub-installable skill that adds `/prd` command to Claude Code
- Automatically create `ralph.sh` in user's project root on first skill invocation
- Handle existing `ralph.sh` gracefully by prompting before overwrite
- Create `progress.txt` template alongside PRD generation
- Include clear installation instructions for developers of any skill level

## User Stories

### US-001: Create skill directory structure
**Description:** As a skill author, I need the proper directory structure so the skill can be installed by copying to `.claude/skills/`.

**Acceptance Criteria:**
- [x] Create `.claude/skills/ralph/` directory in project root (the distributable skill)
- [x] Skill directory contains `prd.md` (the main skill definition)
- [x] Directory structure follows Claude Code skill conventions
- [x] Typecheck passes (if applicable)

### US-002: Create the /prd skill definition file
**Description:** As a skill user, I want the `/prd` command to generate PRDs using the methodology defined in this project.

**Acceptance Criteria:**
- [x] Create `prd.md` skill file with proper frontmatter (name, description, triggers)
- [x] Include full PRD generation instructions from existing skill
- [x] Skill is invocable via `/prd` command
- [x] Typecheck passes (if applicable)

### US-003: Add ralph.sh setup logic to skill
**Description:** As a skill user, I want `ralph.sh` created automatically in my project root when I first use the skill.

**Acceptance Criteria:**
- [x] Skill checks if `ralph.sh` exists in project root on invocation
- [x] If missing, creates `ralph.sh` with correct content and executable permissions
- [x] If exists, prompts user: "ralph.sh already exists. Overwrite? (y/n)"
- [x] Only overwrites if user confirms
- [x] Typecheck passes (if applicable)

### US-004: Include progress.txt template in skill
**Description:** As a skill user, I want `progress.txt` created with proper structure when generating a PRD.

**Acceptance Criteria:**
- [x] Skill creates `progress.txt` with Learnings section header
- [x] Template matches format expected by ralph.sh loop
- [x] Created alongside `PRD.md` during PRD generation
- [x] Typecheck passes (if applicable)

### US-005: Create installation README
**Description:** As a potential user, I want clear instructions so I can install and use this skill in my project.

**Acceptance Criteria:**
- [x] Create `README.md` in repository root with installation steps
- [x] Include: Prerequisites (Claude Code installed)
- [x] Include: Installation command/steps (copy to `.claude/skills/`)
- [x] Include: Usage examples (`/prd` command)
- [x] Include: What gets created (`ralph.sh`, `PRD.md`, `progress.txt`)
- [x] Instructions are clear for developers unfamiliar with Claude skills
- [x] Typecheck passes (if applicable)

### US-006: Add AGENTS.md with skill patterns
**Description:** As a skill maintainer, I want documented patterns so future contributors understand the codebase.

**Acceptance Criteria:**
- [ ] Create `AGENTS.md` in repository root
- [ ] Document skill file structure conventions
- [ ] Document ralph.sh script purpose and parameters
- [ ] Include notes on how skills are loaded by Claude Code
- [ ] Typecheck passes (if applicable)

## Non-Goals

- No npm/package manager distribution (GitHub copy only)
- No automatic updates mechanism
- No `/ralph` command to run the loop (users run `./ralph.sh` directly)
- No web UI or configuration interface
- No support for non-bash environments (Windows without WSL)

## Technical Considerations

- Skills are Markdown files in `.claude/skills/` directory
- Skills use frontmatter for metadata (name, triggers, description)
- `ralph.sh` needs `chmod +x` for executable permission
- The skill should be self-contained (no external dependencies)
- Installation is manual file copy since Claude Code doesn't have a package manager
