#!/usr/bin/env bash
# 生成 Slidev 幻灯片

# 加载通用函数库
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# 获取项目路径
PROJECT_DIR=$(get_current_project)
PROJECT_NAME=$(get_project_name)

SLIDES_FILE="$PROJECT_DIR/slides.md"
OUTLINE_FILE="$PROJECT_DIR/outline.md"
SPEC_FILE="$PROJECT_DIR/spec.json"

# 检查前置文件
if [ ! -f "$SPEC_FILE" ]; then
    output_json "{
      \"status\": \"error\",
      \"message\": \"请先运行 /spec 定义演示规格\"
    }"
    exit 1
fi

if [ ! -f "$OUTLINE_FILE" ]; then
    output_json "{
      \"status\": \"error\",
      \"message\": \"请先运行 /outline 创建大纲\"
    }"
    exit 1
fi

# 读取相关文件
spec_config=$(cat "$SPEC_FILE")
outline_content=$(cat "$OUTLINE_FILE")

# 如果已有幻灯片，读取现有内容
if [ -f "$SLIDES_FILE" ]; then
    existing_slides=$(cat "$SLIDES_FILE")
    output_json "{
      \"status\": \"success\",
      \"action\": \"update\",
      \"project_name\": \"$PROJECT_NAME\",
      \"project_path\": \"$PROJECT_DIR\",
      \"slides_file\": \"$SLIDES_FILE\",
      \"spec\": $spec_config,
      \"outline\": $(echo "$outline_content" | jq -Rs .),
      \"existing_slides\": $(echo "$existing_slides" | jq -Rs .),
      \"message\": \"找到现有幻灯片，AI 可引导用户更新\"
    }"
else
    # 创建初始 Slidev 模板
    cat > "$SLIDES_FILE" <<'EOF'
---
theme: seriph
background: https://source.unsplash.com/collection/94734566/1920x1080
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## 演示标题
  演示描述
drawings:
  persist: false
transition: slide-left
title: 演示标题
---

# 演示标题

演示副标题

<div class="pt-12">
  <span @click="$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    开始 <carbon:arrow-right class="inline"/>
  </span>
</div>

---
layout: default
---

# 目录

- 📝 第一部分
- 🎨 第二部分
- 🚀 第三部分

---

# 第一页

内容待补充

---

# 总结

谢谢观看！

---
layout: center
class: text-center
---

# Q & A

提问环节
EOF

    output_json "{
      \"status\": \"success\",
      \"action\": \"create\",
      \"project_name\": \"$PROJECT_NAME\",
      \"project_path\": \"$PROJECT_DIR\",
      \"slides_file\": \"$SLIDES_FILE\",
      \"spec\": $spec_config,
      \"outline\": $(echo "$outline_content" | jq -Rs .),
      \"message\": \"已创建 Slidev 模板，AI 应根据大纲生成完整幻灯片\"
    }"
fi

