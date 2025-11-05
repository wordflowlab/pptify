#!/usr/bin/env bash
# 创建演示大纲

# 加载通用函数库
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# 获取项目路径
PROJECT_DIR=$(get_current_project)
PROJECT_NAME=$(get_project_name)

OUTLINE_FILE="$PROJECT_DIR/outline.md"
SPEC_FILE="$PROJECT_DIR/spec.json"

# 检查是否有 spec.json
if [ ! -f "$SPEC_FILE" ]; then
    output_json "{
      \"status\": \"error\",
      \"message\": \"请先运行 /spec 定义演示规格\"
    }"
    exit 1
fi

# 读取规格
spec_config=$(cat "$SPEC_FILE")

# 如果已有大纲，读取现有大纲
if [ -f "$OUTLINE_FILE" ]; then
    existing_outline=$(cat "$OUTLINE_FILE")
    output_json "{
      \"status\": \"success\",
      \"action\": \"update\",
      \"project_name\": \"$PROJECT_NAME\",
      \"project_path\": \"$PROJECT_DIR\",
      \"outline_file\": \"$OUTLINE_FILE\",
      \"spec\": $spec_config,
      \"existing_outline\": $(echo "$existing_outline" | jq -Rs .),
      \"message\": \"找到现有大纲，AI 可引导用户更新\"
    }"
else
    # 创建初始大纲模板
    cat > "$OUTLINE_FILE" <<'EOF'
# 演示大纲

## 开场 (10%)
- 标题页
- 自我介绍
- 议题引入

## 主体内容 (70%)
- 第一部分
  - 要点1
  - 要点2
- 第二部分
  - 要点1
  - 要点2
- 第三部分
  - 要点1
  - 要点2

## 总结 (20%)
- 核心要点回顾
- 行动号召
- Q&A

## 备注
- 待补充的内容
- 参考资料
EOF

    output_json "{
      \"status\": \"success\",
      \"action\": \"create\",
      \"project_name\": \"$PROJECT_NAME\",
      \"project_path\": \"$PROJECT_DIR\",
      \"outline_file\": \"$OUTLINE_FILE\",
      \"spec\": $spec_config,
      \"message\": \"已创建大纲模板，AI 应引导用户完善\"
    }"
fi

