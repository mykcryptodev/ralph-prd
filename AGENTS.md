# AGENTS.md - Ralph Skill Patterns

This document captures patterns and conventions for maintaining the Ralph skill.

## Project Structure

```
ralph-skill/
├── .claude/
│   └── skills/
│       └── ralph/
│           └── prd.md    # The main skill definition file
├── AGENTS.md             # This file - patterns for contributors
├── PRD.md                # Product requirements for THIS repo
├── progress.txt          # Progress log for THIS repo's development
└── README.md             # Installation/usage instructions for users
```

## Skill File Structure Conventions

### Location
- Distributable skills live in `.claude/skills/[skill-name]/` directory
- The main skill file is a markdown file (e.g., `prd.md`)
- Users install by copying to `~/.claude/skills/` (global) or `.claude/skills/` (project)

### Frontmatter Format
Skills use YAML frontmatter for metadata:

```yaml
---
name: skill-name
description: Description with trigger phrases like "create a prd" or "plan feature"
---
```

Key fields:
- `name`: The skill identifier (used in `/skill-name` command)
- `description`: Include trigger phrases that invoke the skill automatically

### Skill Body
The markdown body contains instructions for Claude to follow when the skill is invoked. Structure tips:
- Use numbered steps for sequential operations
- Include example outputs so Claude knows the expected format
- Specify file creation with exact content when needed

## ralph.sh Script

### Purpose
`ralph.sh` is the autonomous implementation loop that:
1. Invokes Claude Code with the Ralph agent prompt
2. Runs until PRD.md shows all tasks complete
3. Each iteration: reads PRD, implements one task, tests, commits if passing

### Key Parameters
- `MAX_ITERATIONS`: Prevents infinite loops (default: 50)
- `--allowedTools`: Restricts Claude to safe tools (Edit, Write, Bash, Read, etc.)
- `--continue`: Continues conversation instead of starting fresh each iteration

### Script Location
- Created in user's project root by the `/prd` skill
- Needs executable permission (`chmod +x ralph.sh`)

## How Skills Are Loaded by Claude Code

1. Claude Code scans `~/.claude/skills/` and `.claude/skills/` directories
2. Each subdirectory is a skill; markdown files define skill behavior
3. Skills are matched by:
   - Explicit command: `/skill-name`
   - Trigger phrases in the `description` frontmatter field
4. When triggered, Claude receives the skill's markdown content as instructions

## Common Patterns

### File Creation in Skills
When a skill needs to create files:
- Check if file exists first
- If exists, prompt user before overwriting
- Use exact content blocks so Claude creates consistent output
- For scripts, remind about executable permissions

### Progress Tracking
The Ralph workflow uses `progress.txt` to:
- Record learnings from each iteration
- Pass context to future iterations
- Track what was implemented and what failed

Always read the Learnings section at the start of each iteration.

### Committing Changes
- Only commit if tests pass
- Use conventional commit format: `feat: [description]`
- Never commit broken code

## Contributing

When modifying this skill:
1. Test the skill by running `/prd` in a test project
2. Verify ralph.sh gets created correctly
3. Ensure progress.txt template is generated
4. Update this AGENTS.md if new patterns emerge
