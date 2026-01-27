# PRD: Ralph-PRD Plugin Distribution

## Introduction

Convert the existing Ralph PRD skill into a distributable Claude Code plugin so users can install it via `/plugin install github:username/ralph-prd` instead of manually copying files. The plugin will be named `ralph-prd` and include the `/prd` skill, bundled `ralph.sh` script, documentation, and everything needed for a complete installation experience.

## Goals

- Package the existing PRD skill as a proper Claude Code plugin
- Enable one-command installation via GitHub
- Bundle the `ralph.sh` script as a plugin asset
- Provide clear documentation for plugin users
- Follow Claude Code plugin best practices and conventions

## User Stories

### US-001: Create plugin manifest structure
**Description:** As a plugin developer, I need the proper `.claude-plugin/plugin.json` manifest so Claude Code recognizes this as a valid plugin.

**Acceptance Criteria:**
- [x] Create `.claude-plugin/` directory at project root
- [x] Create `plugin.json` with name `ralph-prd`, description, version `1.0.0`, and author
- [x] Include `homepage` and `repository` fields pointing to GitHub
- [x] Typecheck passes (N/A - JSON file)

### US-002: Restructure skill for plugin format
**Description:** As a plugin developer, I need to move the PRD skill to the plugin's `skills/` directory so it's properly namespaced as `/ralph-prd:prd`.

**Acceptance Criteria:**
- [x] Create `skills/prd/` directory at project root (not inside `.claude-plugin/`)
- [x] Move/copy existing SKILL.md to `skills/prd/SKILL.md`
- [x] Verify frontmatter has `name: prd` and proper description
- [x] Skill should be invocable as `/ralph-prd:prd` when plugin is loaded

### US-003: Bundle ralph.sh as plugin asset
**Description:** As a user, I want the ralph.sh script included with the plugin so I don't need to create it manually.

**Acceptance Criteria:**
- [x] Create `scripts/` directory at project root
- [x] Copy `ralph.sh` to `scripts/ralph.sh`
- [x] Update SKILL.md instructions to reference the bundled script location
- [x] Add instruction for users to copy script to their project: `cp ~/.claude/plugins/ralph-prd/scripts/ralph.sh ./`

### US-004: Update README for plugin installation
**Description:** As a user, I want clear installation instructions so I can install the plugin with one command.

**Acceptance Criteria:**
- [x] Update README.md with plugin installation command: `/plugin install github:username/ralph-prd`
- [x] Document the namespaced command: `/ralph-prd:prd`
- [x] Include instructions for copying `ralph.sh` to project
- [x] Remove old manual copy installation instructions
- [x] Keep usage examples updated for new command format

### US-005: Add plugin-specific documentation
**Description:** As a user, I want to understand what the plugin provides before installing it.

**Acceptance Criteria:**
- [x] Add "What's Included" section to README listing plugin contents
- [x] Document plugin structure (`.claude-plugin/`, `skills/`, `scripts/`)
- [x] Add uninstall instructions: `/plugin uninstall ralph-prd`
- [x] Include troubleshooting section for plugin-specific issues

### US-006: Clean up legacy skill locations
**Description:** As a developer, I want to remove the old `.claude/skills/` directory to avoid confusion since the plugin structure is now at the root.

**Acceptance Criteria:**
- [ ] Remove `.claude/skills/prd/` directory (now at `skills/prd/`)
- [ ] Remove `.claude/skills/ralph/` directory if it exists
- [ ] Keep `.claude/settings.local.json` if needed for local development
- [ ] Update AGENTS.md if it references old paths

### US-007: Test plugin with --plugin-dir flag
**Description:** As a developer, I need to verify the plugin works correctly before publishing.

**Acceptance Criteria:**
- [ ] Run `claude --plugin-dir .` from project root
- [ ] Verify `/ralph-prd:prd` command is available
- [ ] Verify the skill generates PRD.md correctly
- [ ] Verify `scripts/ralph.sh` is accessible

## Non-Goals

- No marketplace submission (GitHub-only distribution for now)
- No additional skills beyond `/prd` (keeping it focused)
- No hooks or MCP servers in this plugin
- No automated testing framework for the plugin itself

## Technical Considerations

- Plugin skills are namespaced: `/ralph-prd:prd` instead of just `/prd`
- The `.claude-plugin/` directory should ONLY contain `plugin.json`
- Skills go in `skills/` at plugin root, NOT inside `.claude-plugin/`
- Users need to manually copy `ralph.sh` to their project after installation
- Consider adding a note that users can create an alias: `/prd -> /ralph-prd:prd`
