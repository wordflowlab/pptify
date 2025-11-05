#!/usr/bin/env bash
# 生成详细内容

# 加载通用函数库
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# 获取项目路径
PROJECT_DIR=$(get_current_project)
PROJECT_NAME=$(get_project_name)

CONTENT_FILE="$PROJECT_DIR/content.md"
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

# 如果已有内容，读取现有内容
if [ -f "$CONTENT_FILE" ]; then
    existing_content=$(cat "$CONTENT_FILE")
    output_json "{
      \"status\": \"success\",
      \"action\": \"update\",
      \"project_name\": \"$PROJECT_NAME\",
      \"project_path\": \"$PROJECT_DIR\",
      \"content_file\": \"$CONTENT_FILE\",
      \"spec\": $spec_config,
      \"outline\": $(echo "$outline_content" | jq -Rs .),
      \"existing_content\": $(echo "$existing_content" | jq -Rs .),
      \"message\": \"找到现有内容，AI 可引导用户更新\"
    }"
else
    # 创建初始内容模板
    cat > "$CONTENT_FILE" <<'EOF'
# 演示详细内容

## 第一部分

### 主题1

内容待补充

### 主题2

内容待补充

## 第二部分

### 主题1

内容待补充

### 主题2

内容待补充
EOF

    output_json "{
      \"status\": \"success\",
      \"action\": \"create\",
      \"project_name\": \"$PROJECT_NAME\",
      \"project_path\": \"$PROJECT_DIR\",
      \"content_file\": \"$CONTENT_FILE\",
      \"spec\": $spec_config,
      \"outline\": $(echo "$outline_content" | jq -Rs .),
      \"message\": \"已创建内容模板，AI 应根据大纲生成详细内容\"
    }"
fi

