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
EXPORT_ARGS=""

for arg in "$@"; do
    case $arg in
        --pdf)
            FORMAT="pdf"
            EXPORT_ARGS=""
            ;;
        --pptx)
            FORMAT="pptx"
            EXPORT_ARGS="--format pptx"
            ;;
        --png)
            FORMAT="png"
            EXPORT_ARGS="--format png"
            ;;
        --html)
            FORMAT="html"
            EXPORT_ARGS="--format html"
            ;;
    esac
done

# 导出文件名
if [ "$FORMAT" = "html" ]; then
    OUTPUT_FILE="$PROJECT_DIR/dist/index.html"
else
    OUTPUT_FILE="$PROJECT_DIR/slides-export.$FORMAT"
fi

output_json "{
  \"status\": \"success\",
  \"project_name\": \"$PROJECT_NAME\",
  \"project_path\": \"$PROJECT_DIR\",
  \"format\": \"$FORMAT\",
  \"output_file\": \"$OUTPUT_FILE\",
  \"message\": \"正在导出为 $FORMAT 格式...\",
  \"command\": \"cd $PROJECT_DIR && npx slidev export $EXPORT_ARGS\"
}"

# 执行导出
cd "$PROJECT_DIR"

# 确保已安装 playwright-chromium（PDF/PPTX/PNG 需要）
if [ "$FORMAT" != "html" ]; then
    if ! npm list playwright-chromium > /dev/null 2>&1; then
        echo "正在安装 playwright-chromium..."
        npm install -D playwright-chromium
    fi
fi

# 执行 Slidev 导出
if [ -n "$EXPORT_ARGS" ]; then
    npx slidev export $EXPORT_ARGS
else
    npx slidev export
fi

