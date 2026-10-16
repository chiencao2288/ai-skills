---
name: example-skill
description: Skill mẫu hướng dẫn cấu trúc chuẩn và quy tắc viết một AI skill. Sử dụng khi cần tham khảo cách viết prompt, metadata frontmatter, hoặc cấu trúc thư mục cho một skill mới.
---

# Example Skill

Đây là một skill mẫu chuẩn theo định dạng Agent Skills.

## Khi nào sử dụng (When to use)
- Dùng làm khuôn mẫu khi bắt đầu viết một skill mới.
- Tham khảo cách phân tách hướng dẫn và tài nguyên đi kèm (scripts/references).

## Cấu trúc chuẩn của một skill
```text
example-skill/
├── SKILL.md            (Bắt buộc: frontmatter + nội dung hướng dẫn)
├── scripts/            (Tùy chọn: code python/bash hỗ trợ thao tác lặp lại)
└── references/         (Tùy chọn: tài liệu tham khảo dài, cheat sheet)
```

## Các nguyên tắc vàng khi viết Skill
1. **Description đẩy đủ & rõ ràng**: `description` trong YAML frontmatter là thứ quyết định AI agent có chọn gọi skill này hay không. Hãy mô tả cả **làm gì** và **ngữ cảnh cụ thể khi nào nên dùng**.
2. **Ngắn gọn, súc tích**: Phần thân `SKILL.md` nên dưới 500 dòng. Nếu có tài liệu hướng dẫn dài, hãy tách vào thư mục `references/` và chỉ dẫn AI đọc khi cần.
3. **Độc lập (Self-contained)**: Mỗi skill không nên phụ thuộc vào các file nằm ngoài thư mục của chính nó.
