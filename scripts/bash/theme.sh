#!/usr/bin/env bash
# 选择和配置主题

# 加载通用函数库
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# 获取项目路径
PROJECT_DIR=$(get_current_project)
PROJECT_NAME=$(get_project_name)

SLIDES_FILE="$PROJECT_DIR/slides.md"
SPEC_FILE="$PROJECT_DIR/spec.json"

# 检查前置文件
if [ ! -f "$SPEC_FILE" ]; then
    output_json "{
      \"status\": \"error\",
      \"message\": \"请先运行 /spec 定义演示规格\"
    }"
    exit 1
fi

# 读取规格和幻灯片
spec_config=$(cat "$SPEC_FILE")
slides_content=""
if [ -f "$SLIDES_FILE" ]; then
    slides_content=$(cat "$SLIDES_FILE")
fi

output_json "{
  \"status\": \"success\",
  \"project_name\": \"$PROJECT_NAME\",
  \"project_path\": \"$PROJECT_DIR\",
  \"slides_file\": \"$SLIDES_FILE\",
  \"spec\": $spec_config,
  \"current_slides\": $(echo "$slides_content" | jq -Rs .),
  \"message\": \"AI 应引导用户选择和配置主题\"
}"

