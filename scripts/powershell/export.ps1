# 导出演示文稿

# 加载通用函数库
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\common.ps1"

# 获取项目路径
$projectDir = Get-CurrentProject
$projectName = Get-ProjectName

$slidesFile = Join-Path $projectDir "slides.md"

# 检查幻灯片文件
if (-not (Test-Path $slidesFile)) {
    $result = @{
        status = "error"
        message = "请先运行 /slides 生成幻灯片"
    } | ConvertTo-Json -Compress
    
    Output-Json $result
    exit 1
}

# 解析参数
$format = "pdf"
foreach ($arg in $args) {
    switch ($arg) {
        "--pdf" { $format = "pdf" }
        "--pptx" { $format = "pptx" }
        "--html" { $format = "html" }
    }
}

# 导出文件名
$outputFile = Join-Path $projectDir "dist" "$projectName.$format"

$result = @{
    status = "success"
    project_name = $projectName
    project_path = $projectDir
    format = $format
    output_file = $outputFile
    message = "正在导出为 $format 格式..."
    command = "cd $projectDir && npm run export"
} | ConvertTo-Json -Compress

Output-Json $result

# 执行导出
Set-Location $projectDir
npm run export

