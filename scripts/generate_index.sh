#!/bin/bash
set -e

BUILD_DIR="public"
NOTES_DIR="$BUILD_DIR/notes"

echo "🧩 Generating Markdown-style index page..."
mkdir -p "$BUILD_DIR"

INDEX_MD="$BUILD_DIR/index.md"
INDEX_HTML="$BUILD_DIR/index.html"

# 生成 Markdown 文件头
{
  echo "# 📚 My LaTeX Notes"
  echo ""
  echo "_Auto-generated on $(date)_"
  echo ""
  echo "## 🗂️ Notes List (Newest First)"
  echo ""
} > "$INDEX_MD"


# 查找所有 PDF 并按修改时间排序（最新在前）
find "$NOTES_DIR" -type f -name "*.pdf" -printf "%T@ %p\n" \
  | sort -nr \
  | cut -d' ' -f2- \
  | while read -r pdf; do
      base=$(basename "$pdf" .pdf) # base 现在是 DecisionMakingModelling_main 或 DecisionMakingModelling_colloquioumPresentation
      relpath="notes/${base}.pdf"

      # --- 新增：创建友好显示名称 ---
      display_name="${base}"

      # 1. 将文件名中的下划线替换为空格
      display_name="${display_name//_/ }"
      
      # 2. (可选) 为特定文件添加后缀，例如 (Report) 或 (Presentation)
      if [[ "$base" == *"_main"* ]]; then
        # 替换 _main 并添加 (Report)
        display_name=$(echo "$display_name" | sed 's/ main$/ (Report)/')
      elif [[ "$base" == *"_colloquioumPresentation"* ]]; then
        # 替换 _colloquioumPresentation 并添加 (Presentation)
        display_name=$(echo "$display_name" | sed 's/ colloquioumPresentation$/ (Colloquium Presentation)/')
      fi

      # 3. 对文件名进行适当的首字母大写或美化（可选）
      # 由于 bash 字符串操作复杂，我们仅依赖于之前的替换，假设您的文件夹名和文件名是合理的。
      # 最终生成的链接文本是 ${display_name}

      # 4. 生成 Markdown 列表项
      echo "- [${display_name}](${relpath})" >> "$INDEX_MD"
    done

# 添加页脚
{
  echo ""
  echo "---"
  echo "_Last updated: $(date)_"
} >> "$INDEX_MD"

# 转换 Markdown -> HTML
{
cat <<EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>My LaTeX Notes</title>
  <style>
    body { font-family: 'Segoe UI', sans-serif; margin: 40px; line-height: 1.6; color: #333; }
    h1, h2 { color: #2c3e50; }
    a { color: #007acc; text-decoration: none; }
    a:hover { text-decoration: underline; }
    code { background-color: #f4f4f4; padding: 2px 4px; border-radius: 3px; }
    hr { border: 0; border-top: 1px solid #ddd; margin: 30px 0; }
  </style>
</head>
<body>
<article>
EOF

# 简单 Markdown 转 HTML（保留基本格式）
sed -E '
  s/^# (.*)$/<h1>\1<\/h1>/;
  s/^## (.*)$/<h2>\1<\/h2>/;
  s/^---$/<hr>/;
  s/^_([^_]+)_$/<em>\1<\/em>/;
  s/^- \[(.*)\]\((.*)\)$/<li><a href="\2" target="_blank">\1<\/a><\/li>/;
' "$INDEX_MD"

cat <<EOF
</article>
</body>
</html>
EOF
} > "$INDEX_HTML"

echo "✅ Generated:"
echo " - $INDEX_MD"
echo " - $INDEX_HTML"
