#!/bin/bash

# Script to symlink all skills from the marketplace to the local Hermes/Gemini CLI directory.
# Usage: ./sync-skills.sh

SKILLS_SRC_DIR="$(pwd)/skills"
HERMES_SKILLS_DIR="$HOME/.hermes/skills/local"

# Create destination directory if it doesn't exist
mkdir -p "$HERMES_SKILLS_DIR"

echo "Syncing skills to $HERMES_SKILLS_DIR..."

# Iterate through each skill directory
for skill_path in "$SKILLS_SRC_DIR"/*; do
    if [ -d "$skill_path" ]; then
        skill_name=$(basename "$skill_path")
        
        # Skip hidden directories
        if [[ "$skill_name" == .* ]]; then
            continue
        fi

        target_dir="$HERMES_SKILLS_DIR/$skill_name"

        # Remove existing target if it exists (directory or symlink)
        if [ -e "$target_dir" ] || [ -L "$target_dir" ]; then
            rm -rf "$target_dir"
            echo "[-] Removed existing $skill_name"
        fi

        # Copy the skill directory
        cp -r "$skill_path" "$target_dir"
        echo "[+] Copied $skill_name"
    fi
done

echo "Done."
