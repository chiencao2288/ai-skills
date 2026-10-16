# AI Skills Collection 🚀

Kho lưu trữ các Agent Skills tùy chỉnh phục vụ cho AI coding assistants (Claude Code, Cline, Roo Code, Cursor, OpenCode, omp, ...).

Mỗi skill được đóng gói độc lập theo chuẩn Agent Skill (`SKILL.md`), có thể tải và sử dụng riêng lẻ từng skill mà không cần tải toàn bộ repository.

---

## 📦 Danh sách Skills

| Tên Skill | Mô tả | Lệnh cài nhanh |
| :--- | :--- | :--- |
| [`example-skill`](skills/example-skill/) | Skill mẫu hướng dẫn cấu trúc chuẩn | `npx degit <username>/ai-skills/skills/example-skill ~/.agents/skills/example-skill` |

---

## ⚡ Cách tải lẻ 1 Skill về máy (Không clone cả repo)

Bạn **không cần clone toàn bộ repo**. Chọn 1 trong các cách sau tùy theo công cụ có sẵn:

### Cách 1: Dùng `npx degit` (Nhanh & nhẹ nhất - Khuyên dùng)
Không tải lịch sử Git, chỉ tải đúng thư mục của skill:
```bash
# Cài đặt vào thư mục global của agent (~/.agents/skills)
npx degit <username>/ai-skills/skills/<ten-skill> ~/.agents/skills/<ten-skill>

# Hoặc cài đặt vào thư mục project hiện tại
npx degit <username>/ai-skills/skills/<ten-skill> .agents/skills/<ten-skill>
```

### Cách 2: Dùng Git Sparse-Checkout (Không cần cài thêm gì)
Chỉ tải metadata và đúng thư mục skill bạn muốn:
```bash
# 1. Clone không tải nội dung file (blobless)
git clone --depth 1 --filter=blob:none --sparse https://github.com/<username>/ai-skills.git /tmp/ai-skills-temp

# 2. Chỉ chọn thư mục skill cần lấy
cd /tmp/ai-skills-temp
git sparse-checkout set skills/<ten-skill>

# 3. Di chuyển skill vào thư mục mong muốn và dọn dẹp
mv skills/<ten-skill> ~/.agents/skills/
cd ~ && rm -rf /tmp/ai-skills-temp
```

### Cách 3: Dùng Script `install.sh` đi kèm
Chạy trực tiếp từ terminal qua `curl`:
```bash
curl -fsSL https://raw.githubusercontent.com/<username>/ai-skills/main/install.sh | bash -s <ten-skill>
```

---

## 📁 Cấu trúc thư mục Repo

```text
ai-skills/
├── README.md               # Catalog danh sách các skills & hướng dẫn
├── install.sh              # Script hỗ trợ tải lẻ 1 skill
├── .gitignore
└── skills/                 # Chứa tất cả các skills
    ├── <ten-skill-1>/
    │   ├── SKILL.md        # File bắt buộc: YAML metadata + Prompt hướng dẫn
    │   ├── scripts/        # (Tùy chọn) Scripts thực thi deterministic
    │   └── references/     # (Tùy chọn) Tài liệu tham khảo tra cứu
    └── <ten-skill-2>/
        └── SKILL.md
```

---

## 🛠️ Quy chuẩn viết một Skill (`SKILL.md`)

Mỗi skill nằm trong một thư mục riêng dưới `skills/` và bắt buộc có file `SKILL.md`:
```markdown
---
name: my-awesome-skill
description: Mô tả rõ ràng skill này làm gì và KHI NÀO agent nên tự động kích hoạt skill này.
---

# Tên Skill

Hướng dẫn chi tiết từng bước cho AI Agent...
```
