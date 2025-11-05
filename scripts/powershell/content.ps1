# 生成详细内容

# 加载通用函数库
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\common.ps1"

# 获取项目路径
$projectDir = Get-CurrentProject
$projectName = Get-ProjectName

$contentFile = Join-Path $projectDir "content.md"
$outlineFile = Join-Path $projectDir "outline.md"
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

if (-not (Test-Path $outlineFile)) {
    $result = @{
        status = "error"
        message = "请先运行 /outline 创建大纲"
    } | ConvertTo-Json -Compress
    
    Output-Json $result
    exit 1
}

# 读取相关文件
$specConfig = Get-Content $specFile -Raw | ConvertFrom-Json
$outlineContent = Get-Content $outlineFile -Raw

# 如果已有内容，读取现有内容
if (Test-Path $contentFile) {
    $existingContent = Get-Content $contentFile -Raw
    
    $result = @{
        status = "success"
        action = "update"
        project_name = $projectName
        project_path = $projectDir
        content_file = $contentFile
        spec = $specConfig
        outline = $outlineContent
        existing_content = $existingContent
        message = "找到现有内容，AI 可引导用户更新"
    } | ConvertTo-Json -Compress -Depth 10
    
    Output-Json $result
}
else {
    # 创建初始内容模板
    $contentTemplate = @"
# 演示详细内容

## 第一部分

### 主题1

内容待补充

### 主题2

内容待补充

## 第二部分

### 主题1

内容待补充

### 主题2

内容待补充
"@
    
    $contentTemplate | Out-File -FilePath $contentFile -Encoding UTF8
    
    $result = @{
        status = "success"
        action = "create"
        project_name = $projectName
        project_path = $projectDir
        content_file = $contentFile
        spec = $specConfig
        outline = $outlineContent
        message = "已创建内容模板，AI 应根据大纲生成详细内容"
    } | ConvertTo-Json -Compress -Depth 10
    
    Output-Json $result
}

