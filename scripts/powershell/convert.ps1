# 转换现有文档

# 加载通用函数库
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\common.ps1"

# 获取项目路径
$projectDir = Get-CurrentProject
$projectName = Get-ProjectName

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

# 读取规格
$specConfig = Get-Content $specFile -Raw | ConvertFrom-Json

$result = @{
    status = "success"
    project_name = $projectName
    project_path = $projectDir
    spec = $specConfig
    message = "AI 应引导用户提供要转换的文档内容"
} | ConvertTo-Json -Compress -Depth 10

Output-Json $result

