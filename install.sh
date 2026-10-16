#!/usr/bin/env bash
# ==============================================================================
# Script cài đặt lẻ từng AI Skill từ repository về máy
# Cách dùng:
#   bash install.sh <tên-skill> [thư-mục-đích]
#   curl -fsSL https://raw.githubusercontent.com/<user>/ai-skills/main/install.sh | bash -s <tên-skill>
# ==============================================================================

set -euo pipefail

# Thay đổi REPO_OWNER và REPO_NAME theo repo của bạn khi public lên GitHub
REPO_OWNER="${AI_SKILLS_OWNER:-chiencao}"
REPO_NAME="${AI_SKILLS_REPO:-ai-skills}"
BRANCH="${AI_SKILLS_BRANCH:-main}"

SKILL_NAME="${1:-}"
TARGET_DIR="${2:-$HOME/.agents/skills}"

if [ -z "$SKILL_NAME" ]; then
  echo "❌ Lỗi: Bạn chưa cung cấp tên skill cần cài đặt!"
  echo "👉 Cách dùng: $0 <tên-skill> [thư-mục-đích]"
  echo "Ví dụ: $0 example-skill ~/.agents/skills"
  exit 1
fi

DEST="$TARGET_DIR/$SKILL_NAME"
mkdir -p "$TARGET_DIR"

echo "🚀 Đang tải skill '$SKILL_NAME' từ '$REPO_OWNER/$REPO_NAME'..."

# Cách 1: Sử dụng tarball từ GitHub (nhanh nhất, không cần clone, chỉ giải nén đúng 1 thư mục)
TAR_URL="https://codeload.github.com/$REPO_OWNER/$REPO_NAME/tar.gz/refs/heads/$BRANCH"

TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT

if curl -sSL -f "$TAR_URL" -o "$TEMP_DIR/repo.tar.gz" 2>/dev/null; then
  mkdir -p "$DEST"
  # Giải nén chỉ thư mục skills/<SKILL_NAME> vào DEST
  if tar -xzf "$TEMP_DIR/repo.tar.gz" -C "$DEST" --strip-components=2 "$REPO_NAME-$BRANCH/skills/$SKILL_NAME" 2>/dev/null; then
    echo "✅ Đã cài đặt thành công skill '$SKILL_NAME' vào: $DEST"
    exit 0
  else
    rm -rf "$DEST"
    echo "❌ Không tìm thấy skill '$SKILL_NAME' trong thư mục skills/ của repo."
    exit 1
  fi
fi

# Cách 2: Dự phòng dùng Git Sparse-Checkout nếu không tải được tarball
echo "⚠️  Không tải được tarball, chuyển sang dùng git sparse-checkout..."
GIT_URL="https://github.com/$REPO_OWNER/$REPO_NAME.git"

git clone --depth 1 --filter=blob:none --sparse "$GIT_URL" "$TEMP_DIR/git-sparse"
cd "$TEMP_DIR/git-sparse"
git sparse-checkout set "skills/$SKILL_NAME"

if [ -d "skills/$SKILL_NAME" ]; then
  mkdir -p "$DEST"
  cp -r "skills/$SKILL_NAME"/* "$DEST/"
  echo "✅ Đã cài đặt thành công skill '$SKILL_NAME' vào: $DEST"
else
  echo "❌ Không tìm thấy skill '$SKILL_NAME' trong repo."
  exit 1
fi
