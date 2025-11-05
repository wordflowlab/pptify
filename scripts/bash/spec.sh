#!/usr/bin/env bash
# 定义/更新演示规格

# 加载通用函数库
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# 获取项目路径
PROJECT_DIR=$(get_current_project)
PROJECT_NAME=$(get_project_name)

SPEC_FILE="$PROJECT_DIR/spec.json"
CONFIG_FILE="$PROJECT_DIR/.pptify/config.json"

# 读取 config.json 中的 defaultType (如果存在)
DEFAULT_TYPE=""
if [ -f "$CONFIG_FILE" ]; then
    DEFAULT_TYPE=$(grep -o '"defaultType"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_FILE" | \
                   sed 's/"defaultType"[[:space:]]*:[[:space:]]*"\([^"]*\)"/\1/')
fi

# 如果已有配置，读取现有配置
if [ -f "$SPEC_FILE" ]; then
    existing_config=$(cat "$SPEC_FILE")
    output_json "{
      \"status\": \"success\",
      \"action\": \"update\",
      \"project_name\": \"$PROJECT_NAME\",
      \"project_path\": \"$PROJECT_DIR\",
      \"spec_file\": \"$SPEC_FILE\",
      \"existing_config\": $existing_config,
      \"message\": \"找到现有配置，AI 可引导用户更新\"
    }"
else
    # 创建初始配置模板
    cat > "$SPEC_FILE" <<EOF
{
  "project_name": "$PROJECT_NAME",
  "type": "$DEFAULT_TYPE",
  "duration": "",
  "slides_count": 0,
  "topic": "",
  "audience": {
    "level": "",
    "size": ""
  },
  "target_platform": [],
  "style": "",
  "created_at": "$(get_timestamp)",
  "updated_at": "$(get_timestamp)"
}
EOF

    output_json "{
      \"status\": \"success\",
      \"action\": \"create\",
      \"project_name\": \"$PROJECT_NAME\",
      \"project_path\": \"$PROJECT_DIR\",
      \"spec_file\": \"$SPEC_FILE\",
      \"default_type\": \"$DEFAULT_TYPE\",
      \"message\": \"已创建配置模板，AI 应引导用户填写以下信息\",
      \"required_fields\": [
        \"type (类型): 技术分享/商业路演/教程培训/学术报告\",
        \"duration (时长): 如 '20分钟' 或 '45分钟'\",
        \"slides_count (幻灯片数): 建议 15-40 张\",
        \"topic (主题): 演示的核心主题\",
        \"audience (受众): 听众水平和规模\",
        \"target_platform (目标平台): 会议/线上/内部等\"
      ]
    }"
fi

