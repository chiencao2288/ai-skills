#!/usr/bin/env bash
# ==============================================================================
# AI Skills One-Liner Installer
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/<owner>/ai-skills/main/install.sh | bash -s <skill-name> [destination]
#
# Examples:
#   # Install to global agent skills directory (~/.agents/skills/pdf):
#   curl -fsSL https://raw.githubusercontent.com/chiencao/ai-skills/main/install.sh | bash -s pdf
#
#   # Install into current project repository (.agents/skills/pdf):
#   curl -fsSL https://raw.githubusercontent.com/chiencao/ai-skills/main/install.sh | bash -s pdf .agents/skills
# ==============================================================================

set -euo pipefail

REPO_OWNER="${AI_SKILLS_OWNER:-chiencao}"
REPO_NAME="${AI_SKILLS_REPO:-ai-skills}"
BRANCH="${AI_SKILLS_BRANCH:-main}"

SKILL_NAME="${1:-}"
TARGET_BASE="${2:-$HOME/.agents/skills}"

if [ -z "$SKILL_NAME" ]; then
  echo "❌ Error: Missing skill name."
  echo "Usage:   curl -fsSL <script-url> | bash -s <skill-name> [target-dir]"
  echo "Example: curl -fsSL https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/$BRANCH/install.sh | bash -s pdf"
  exit 1
fi

DEST="$TARGET_BASE/$SKILL_NAME"
mkdir -p "$DEST"

echo "📦 Fetching skill '$SKILL_NAME' from $REPO_OWNER/$REPO_NAME ($BRANCH)..."

TARBALL_URL="https://codeload.github.com/$REPO_OWNER/$REPO_NAME/tar.gz/refs/heads/$BRANCH"

# Stream tarball directly from GitHub CDN without saving full repo to disk
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
