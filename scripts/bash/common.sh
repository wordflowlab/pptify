#!/usr/bin/env bash
# 通用函数库

# 输出 JSON 格式
output_json() {
    echo "$1"
}

# 查找项目根目录
get_current_project() {
    local current_dir="$PWD"
    
    # 向上查找，最多10层
    for i in {1..10}; do
        if [ -d "$current_dir/.pptify" ]; then
            echo "$current_dir"
            return 0
        fi
        
        local parent_dir=$(dirname "$current_dir")
        if [ "$parent_dir" = "$current_dir" ]; then
            break
        fi
        current_dir="$parent_dir"
    done
    
    # 未找到项目根目录
    output_json "{\"status\": \"error\", \"message\": \"未找到 .pptify 目录，请在项目根目录运行\"}"
    exit 1
}

# 获取项目名称
get_project_name() {
    local project_dir=$(get_current_project)
    basename "$project_dir"
}

# 读取项目配置
get_project_config() {
    local project_dir=$(get_current_project)
    local config_file="$project_dir/.pptify/config.json"
    
    if [ -f "$config_file" ]; then
        cat "$config_file"
    else
        echo "{}"
    fi
}

# 确保文件存在
ensure_file() {
    local file_path="$1"
    local default_content="${2:-}"
    
    if [ ! -f "$file_path" ]; then
        echo "$default_content" > "$file_path"
    fi
}

# 获取当前时间戳（ISO 8601）
get_timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

