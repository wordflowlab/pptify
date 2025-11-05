#!/usr/bin/env bash
# 导出演示文稿

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

# 解析参数
FORMAT="pdf"
for arg in "$@"; do
    case $arg in
        --pdf)
            FORMAT="pdf"
            ;;
        --pptx)
            FORMAT="pptx"
            ;;
        --html)
            FORMAT="html"
            ;;
    esac
done

# 导出文件名
OUTPUT_FILE="$PROJECT_DIR/dist/$PROJECT_NAME.$FORMAT"

output_json "{
  \"status\": \"success\",
  \"project_name\": \"$PROJECT_NAME\",
  \"project_path\": \"$PROJECT_DIR\",
  \"format\": \"$FORMAT\",
  \"output_file\": \"$OUTPUT_FILE\",
  \"message\": \"正在导出为 $FORMAT 格式...\",
  \"command\": \"cd $PROJECT_DIR && npm run export\"
}"

# 执行导出
cd "$PROJECT_DIR"
npm run export

