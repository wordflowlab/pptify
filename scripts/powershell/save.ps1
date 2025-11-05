# 保存项目配置

# 加载通用函数库
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\common.ps1"

# 获取项目路径
$projectDir = Get-CurrentProject
$projectName = Get-ProjectName

$configFile = Join-Path $projectDir ".pptify" "config.json"
$savesDir = Join-Path $projectDir ".pptify" "saves"

# 创建保存目录
if (-not (Test-Path $savesDir)) {
    New-Item -ItemType Directory -Path $savesDir -Force | Out-Null
}

# 生成时间戳
$timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm-ss"
$saveDir = Join-Path $savesDir $timestamp

# 创建快照目录
New-Item -ItemType Directory -Path $saveDir -Force | Out-Null

# 需要保存的文件
$filesToSave = @(
    "spec.json",
    "outline.md",
    "content.md",
    "slides.md",
    ".pptify/config.json"
)

$savedFiles = @()
foreach ($file in $filesToSave) {
    $sourcePath = Join-Path $projectDir $file
    if (Test-Path $sourcePath) {
        $destPath = Join-Path $saveDir (Split-Path $file -Leaf)
        Copy-Item -Path $sourcePath -Destination $destPath -Force
        $savedFiles += $file
    }
}

# 创建保存元数据
$metadata = @{
    timestamp = $timestamp
    project_name = $projectName
    saved_files = $savedFiles
    created_at = Get-Timestamp
}

$metadata | ConvertTo-Json -Depth 10 | Out-File -FilePath (Join-Path $saveDir "metadata.json") -Encoding UTF8

$result = @{
    status = "success"
    project_name = $projectName
    project_path = $projectDir
    save_path = $saveDir
    saved_files = $savedFiles
    message = "项目已保存到快照: $timestamp"
} | ConvertTo-Json -Compress -Depth 10

Output-Json $result

