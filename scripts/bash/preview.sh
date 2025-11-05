#!/usr/bin/env bash
# 启动 Slidev 预览服务器

# 加载通用函数库
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# 获取项目路径
PROJECT_DIR=$(get_current_project)
PROJECT_NAME=$(get_project_name)

SLIDES_FILE="$PROJECT_DIR/slides.md"

# 检查幻灯片文件
if [ ! -f "$SLIDES_FILE" ]; then
    output_json "{
      \"status\": \"error\",
      \"message\": \"请先运行 /slides 生成幻灯片\"
    }"
    exit 1
fi

# 检查是否安装了 Slidev
if ! command -v npx &> /dev/null && ! [ -f "$PROJECT_DIR/node_modules/.bin/slidev" ]; then
    output_json "{
      \"status\": \"error\",
      \"message\": \"请先运行 npm install 安装依赖\"
    }"
    exit 1
fi

output_json "{
  \"status\": \"success\",
  \"project_name\": \"$PROJECT_NAME\",
  \"project_path\": \"$PROJECT_DIR\",
  \"message\": \"正在启动预览服务器...\",
  \"command\": \"cd $PROJECT_DIR && npm run dev\"
}"

# 启动 Slidev
cd "$PROJECT_DIR"
npm run dev

