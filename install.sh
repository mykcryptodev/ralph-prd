#!/bin/bash
set -e

PLUGIN_NAME="ralph-prd"
PLUGIN_DIR="$HOME/.claude/plugins/$PLUGIN_NAME"
REPO_URL="https://github.com/mykcryptodev/ralph-prd.git"

echo "Installing $PLUGIN_NAME plugin for Claude Code..."

# Create plugins directory if it doesn't exist
mkdir -p "$HOME/.claude/plugins"

# Check if already installed
if [ -d "$PLUGIN_DIR" ]; then
    echo "Plugin already installed at $PLUGIN_DIR"
    echo "Updating..."
    cd "$PLUGIN_DIR"
    git pull origin master
    echo "✓ Plugin updated successfully!"
else
    echo "Cloning $PLUGIN_NAME..."
    git clone "$REPO_URL" "$PLUGIN_DIR"
    echo "✓ Plugin installed successfully!"
fi

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Restart Claude Code"
echo "  2. Use /ralph-prd:prd to create a PRD"
echo "  3. Copy ralph.sh to your project: cp $PLUGIN_DIR/scripts/ralph.sh ./"
echo ""
