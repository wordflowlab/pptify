#!/usr/bin/env bash
# 内容润色和优化

# 加载通用函数库
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# 获取项目路径
PROJECT_DIR=$(get_current_project)
PROJECT_NAME=$(get_project_name)

SLIDES_FILE="$PROJECT_DIR/slides.md"
OUTLINE_FILE="$PROJECT_DIR/outline.md"
CONTENT_FILE="$PROJECT_DIR/content.md"
SPEC_FILE="$PROJECT_DIR/spec.json"

# 检查前置文件
if [ ! -f "$SPEC_FILE" ]; then
    output_json "{
      \"status\": \"error\",
      \"message\": \"请先运行 /spec 定义演示规格\"
    }"
    exit 1
fi

# 读取相关文件
spec_config=$(cat "$SPEC_FILE")
outline_content=""
content_content=""
slides_content=""

if [ -f "$OUTLINE_FILE" ]; then
    outline_content=$(cat "$OUTLINE_FILE")
fi

if [ -f "$CONTENT_FILE" ]; then
    content_content=$(cat "$CONTENT_FILE")
fi

if [ -f "$SLIDES_FILE" ]; then
    slides_content=$(cat "$SLIDES_FILE")
fi

output_json "{
  \"status\": \"success\",
  \"project_name\": \"$PROJECT_NAME\",
  \"project_path\": \"$PROJECT_DIR\",
  \"spec\": $spec_config,
  \"outline\": $(echo "$outline_content" | jq -Rs .),
  \"content\": $(echo "$content_content" | jq -Rs .),
  \"slides\": $(echo "$slides_content" | jq -Rs .),
  \"message\": \"AI 应对内容进行润色和优化\"
}"

