# 创建演示大纲

# 加载通用函数库
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\common.ps1"

# 获取项目路径
$projectDir = Get-CurrentProject
$projectName = Get-ProjectName

$outlineFile = Join-Path $projectDir "outline.md"
$specFile = Join-Path $projectDir "spec.json"

# 检查是否有 spec.json
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

# 如果已有大纲，读取现有大纲
if (Test-Path $outlineFile) {
    $existingOutline = Get-Content $outlineFile -Raw
    
    $result = @{
        status = "success"
        action = "update"
        project_name = $projectName
        project_path = $projectDir
        outline_file = $outlineFile
        spec = $specConfig
        existing_outline = $existingOutline
        message = "找到现有大纲，AI 可引导用户更新"
    } | ConvertTo-Json -Compress -Depth 10
    
    Output-Json $result
}
else {
    # 创建初始大纲模板
    $outlineTemplate = @"
# 演示大纲

## 开场 (10%)
- 标题页
- 自我介绍
- 议题引入

## 主体内容 (70%)
- 第一部分
  - 要点1
  - 要点2
- 第二部分
  - 要点1
  - 要点2
- 第三部分
  - 要点1
  - 要点2

## 总结 (20%)
- 核心要点回顾
- 行动号召
- Q&A

## 备注
- 待补充的内容
- 参考资料
"@
    
    $outlineTemplate | Out-File -FilePath $outlineFile -Encoding UTF8
    
    $result = @{
        status = "success"
        action = "create"
        project_name = $projectName
        project_path = $projectDir
        outline_file = $outlineFile
        spec = $specConfig
        message = "已创建大纲模板，AI 应引导用户完善"
    } | ConvertTo-Json -Compress -Depth 10
    
    Output-Json $result
}

