#!/bin/bash
set -e

SKILL_URL="https://raw.githubusercontent.com/mykcryptodev/ralph-prd/master/skills/prd/SKILL.md"
RALPH_URL="https://raw.githubusercontent.com/mykcryptodev/ralph-prd/master/scripts/ralph.sh"
SKILL_DIR=".claude/skills/prd"
SKILL_FILE="$SKILL_DIR/SKILL.md"

echo "Installing Ralph PRD skill..."

# Create the skills directory
mkdir -p "$SKILL_DIR"

# Download the skill file
echo "Downloading SKILL.md..."
curl -fsSL "$SKILL_URL" -o "$SKILL_FILE"
echo "✓ Skill installed to $SKILL_FILE"

# Download ralph.sh to current directory
echo "Downloading ralph.sh..."
curl -fsSL "$RALPH_URL" -o "ralph.sh"
chmod +x ralph.sh
echo "✓ ralph.sh installed and made executable"

echo ""
echo "Installation complete!"
echo ""
echo "Usage:"
echo "  1. Run 'claude' in this directory"
echo "  2. Use /prd or ask Claude to 'create a prd' to generate a PRD"
echo "  3. Run ./ralph.sh to start the autonomous implementation loop"
echo ""
