#!/usr/bin/env bash
# ==============================================================================
# AI Skills Installer
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/<owner>/ai-skills/main/install.sh | bash -s <skill-name|all|list> [destination]
#
# Examples:
#   # List available skills:
#   curl -fsSL https://raw.githubusercontent.com/chiencao2288/ai-skills/main/install.sh | bash -s list
#
#   # Install single skill to ~/.agents/skills/<skill-name>:
#   curl -fsSL https://raw.githubusercontent.com/chiencao2288/ai-skills/main/install.sh | bash -s pdf
#
#   # Install all skills:
#   curl -fsSL https://raw.githubusercontent.com/chiencao2288/ai-skills/main/install.sh | bash -s all
#
#   # Install to custom project location:
#   curl -fsSL https://raw.githubusercontent.com/chiencao2288/ai-skills/main/install.sh | bash -s pdf .agents/skills
# ==============================================================================

set -euo pipefail

REPO_OWNER="${AI_SKILLS_OWNER:-chiencao2288}"
REPO_NAME="${AI_SKILLS_REPO:-ai-skills}"
BRANCH="${AI_SKILLS_BRANCH:-main}"

COMMAND="${1:-}"
TARGET_BASE="${2:-$HOME/.agents/skills}"

TARBALL_URL="https://codeload.github.com/$REPO_OWNER/$REPO_NAME/tar.gz/refs/heads/$BRANCH"

# 1. Handle "list" command
if [ "$COMMAND" = "list" ] || [ "$COMMAND" = "--list" ]; then
  echo "📋 Available skills in $REPO_OWNER/$REPO_NAME ($BRANCH):"
  if [ -d "./skills" ]; then
    find ./skills -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort | sed 's/^/  - /'
  else
    curl -sSL "$TARBALL_URL" | tar -ztf - 2>/dev/null | grep -E "^$REPO_NAME-[^/]+/skills/[^/]+/SKILL.md" | awk -F/ '{print "  - " $(NF-1)}' | sort -u || {
      echo "❌ Error: Unable to fetch skill listing from GitHub."
      exit 1
    }
  fi
  exit 0
fi

# 2. Check for missing arguments
if [ -z "$COMMAND" ]; then
  echo "❌ Error: Missing command or skill name."
  echo "Usage:   curl -fsSL <script-url> | bash -s <skill-name|all|list> [target-dir]"
  echo "Example: curl -fsSL https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/$BRANCH/install.sh | bash -s pdf"
  echo "         curl -fsSL https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/$BRANCH/install.sh | bash -s all"
  echo "         curl -fsSL https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/$BRANCH/install.sh | bash -s list"
  exit 1
fi

# 3. Handle "all" command
if [ "$COMMAND" = "all" ] || [ "$COMMAND" = "--all" ]; then
  echo "📦 Installing all skills to: $TARGET_BASE..."
  mkdir -p "$TARGET_BASE"

  if [ -d "./skills" ]; then
    cp -r ./skills/* "$TARGET_BASE/"
    echo "✅ Successfully installed all local skills to: $TARGET_BASE"
  else
    if curl -sSL -f "$TARBALL_URL" | tar -xz -C "$TARGET_BASE" --strip-components=2 "$REPO_NAME-$BRANCH/skills" 2>/dev/null; then
      echo "✅ Successfully installed all skills to: $TARGET_BASE"
    else
      echo "❌ Error: Failed to download and extract skills from GitHub."
      exit 1
    fi
  fi
  exit 0
fi

# 4. Handle single skill installation
SKILL_NAME="$COMMAND"
DEST="$TARGET_BASE/$SKILL_NAME"
mkdir -p "$DEST"

echo "📦 Fetching skill '$SKILL_NAME'..."

# If local repo exists, copy directly
if [ -d "./skills/$SKILL_NAME" ]; then
  cp -r "./skills/$SKILL_NAME/"* "$DEST/"
  echo "✅ Successfully installed '$SKILL_NAME' to: $DEST"
  exit 0
fi

# Otherwise stream from GitHub tarball
if curl -sSL -f "$TARBALL_URL" | tar -xz -C "$DEST" --strip-components=3 "$REPO_NAME-$BRANCH/skills/$SKILL_NAME" 2>/dev/null; then
  if [ -f "$DEST/SKILL.md" ]; then
    echo "✅ Successfully installed '$SKILL_NAME' to: $DEST"
    exit 0
  fi
fi

# Clean up empty directory if skill not found
rmdir "$DEST" 2>/dev/null || rm -rf "$DEST"
echo "❌ Error: Skill '$SKILL_NAME' was not found in $REPO_OWNER/$REPO_NAME/skills/."
exit 1
