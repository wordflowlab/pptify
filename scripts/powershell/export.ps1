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
$exportArgs = ""

foreach ($arg in $args) {
    switch ($arg) {
        "--pdf" { 
            $format = "pdf"
            $exportArgs = ""
        }
        "--pptx" { 
            $format = "pptx"
            $exportArgs = "--format pptx"
        }
        "--png" { 
            $format = "png"
            $exportArgs = "--format png"
        }
        "--html" { 
            $format = "html"
            $exportArgs = "--format html"
        }
    }
}

# 导出文件名
if ($format -eq "html") {
    $outputFile = Join-Path $projectDir "dist" "index.html"
} else {
    $outputFile = Join-Path $projectDir "slides-export.$format"
}

$result = @{
    status = "success"
    project_name = $projectName
    project_path = $projectDir
    format = $format
    output_file = $outputFile
    message = "正在导出为 $format 格式..."
    command = "cd $projectDir && npx slidev export $exportArgs"
} | ConvertTo-Json -Compress

Output-Json $result

# 执行导出
Set-Location $projectDir

# 确保已安装 playwright-chromium（PDF/PPTX/PNG 需要）
if ($format -ne "html") {
    $hasPlaywright = npm list playwright-chromium 2>$null
    if (-not $hasPlaywright) {
        Write-Host "正在安装 playwright-chromium..."
        npm install -D playwright-chromium
    }
}

# 执行 Slidev 导出
if ($exportArgs) {
    npx slidev export $exportArgs
} else {
    npx slidev export
}

