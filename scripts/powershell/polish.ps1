# 内容润色和优化

# 加载通用函数库
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\common.ps1"

# 获取项目路径
$projectDir = Get-CurrentProject
$projectName = Get-ProjectName

$slidesFile = Join-Path $projectDir "slides.md"
$outlineFile = Join-Path $projectDir "outline.md"
$contentFile = Join-Path $projectDir "content.md"
$specFile = Join-Path $projectDir "spec.json"

# 检查前置文件
if (-not (Test-Path $specFile)) {
    $result = @{
        status = "error"
        message = "请先运行 /spec 定义演示规格"
    } | ConvertTo-Json -Compress
    
    Output-Json $result
    exit 1
}

# 读取相关文件
$specConfig = Get-Content $specFile -Raw | ConvertFrom-Json
$outlineContent = if (Test-Path $outlineFile) { Get-Content $outlineFile -Raw } else { "" }
$contentContent = if (Test-Path $contentFile) { Get-Content $contentFile -Raw } else { "" }
$slidesContent = if (Test-Path $slidesFile) { Get-Content $slidesFile -Raw } else { "" }

$result = @{
    status = "success"
    project_name = $projectName
    project_path = $projectDir
    spec = $specConfig
    outline = $outlineContent
    content = $contentContent
    slides = $slidesContent
    message = "AI 应对内容进行润色和优化"
} | ConvertTo-Json -Compress -Depth 10

Output-Json $result

