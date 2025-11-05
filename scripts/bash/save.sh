#!/usr/bin/env bash
# 保存项目配置

# 加载通用函数库
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# 获取项目路径
PROJECT_DIR=$(get_current_project)
PROJECT_NAME=$(get_project_name)

CONFIG_FILE="$PROJECT_DIR/.pptify/config.json"
SAVES_DIR="$PROJECT_DIR/.pptify/saves"

# 创建保存目录
mkdir -p "$SAVES_DIR"

# 生成时间戳
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")
SAVE_DIR="$SAVES_DIR/$TIMESTAMP"

# 创建快照目录
mkdir -p "$SAVE_DIR"

# 需要保存的文件
FILES_TO_SAVE=(
    "spec.json"
    "outline.md"
    "content.md"
    "slides.md"
    ".pptify/config.json"
)

SAVED_FILES=()
for file in "${FILES_TO_SAVE[@]}"; do
    SOURCE_PATH="$PROJECT_DIR/$file"
    if [ -f "$SOURCE_PATH" ]; then
        DEST_PATH="$SAVE_DIR/$(basename "$file")"
        cp "$SOURCE_PATH" "$DEST_PATH"
        SAVED_FILES+=("$file")
    fi
done

# 创建保存元数据
cat > "$SAVE_DIR/metadata.json" <<EOF
{
  "timestamp": "$TIMESTAMP",
  "project_name": "$PROJECT_NAME",
  "saved_files": $(printf '%s\n' "${SAVED_FILES[@]}" | jq -R . | jq -s .),
  "created_at": "$(get_timestamp)"
}
EOF

# 构建 saved_files JSON 数组
SAVED_FILES_JSON=$(printf '%s\n' "${SAVED_FILES[@]}" | jq -R . | jq -s .)

output_json "{
  \"status\": \"success\",
  \"project_name\": \"$PROJECT_NAME\",
  \"project_path\": \"$PROJECT_DIR\",
  \"save_path\": \"$SAVE_DIR\",
  \"saved_files\": $SAVED_FILES_JSON,
  \"message\": \"项目已保存到快照: $TIMESTAMP\"
}"

