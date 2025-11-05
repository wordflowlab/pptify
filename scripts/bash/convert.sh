#!/usr/bin/env bash
# 转换现有文档

# 加载通用函数库
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# 获取项目路径
PROJECT_DIR=$(get_current_project)
PROJECT_NAME=$(get_project_name)

SPEC_FILE="$PROJECT_DIR/spec.json"

# 检查前置文件
if [ ! -f "$SPEC_FILE" ]; then
    output_json "{
      \"status\": \"error\",
      \"message\": \"请先运行 /spec 定义演示规格\"
    }"
    exit 1
fi

# 读取规格
spec_config=$(cat "$SPEC_FILE")

output_json "{
  \"status\": \"success\",
  \"project_name\": \"$PROJECT_NAME\",
  \"project_path\": \"$PROJECT_DIR\",
  \"spec\": $spec_config,
  \"message\": \"AI 应引导用户提供要转换的文档内容\"
}"

