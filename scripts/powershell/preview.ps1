# 启动 Slidev 预览服务器

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

# 检查是否安装了 Slidev
$npxExists = Get-Command npx -ErrorAction SilentlyContinue
$slidevLocal = Join-Path $projectDir "node_modules" ".bin" "slidev.cmd"

if (-not $npxExists -and -not (Test-Path $slidevLocal)) {
    $result = @{
        status = "error"
        message = "请先运行 npm install 安装依赖"
    } | ConvertTo-Json -Compress
    
    Output-Json $result
    exit 1
}

$result = @{
    status = "success"
    project_name = $projectName
    project_path = $projectDir
    message = "正在启动预览服务器..."
    command = "cd $projectDir && npm run dev"
} | ConvertTo-Json -Compress

Output-Json $result

# 启动 Slidev
Set-Location $projectDir
npm run dev

