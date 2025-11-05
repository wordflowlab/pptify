# 定义/更新演示规格

# 加载通用函数库
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\common.ps1"

# 获取项目路径
$projectDir = Get-CurrentProject
$projectName = Get-ProjectName

$specFile = Join-Path $projectDir "spec.json"
$configFile = Join-Path $projectDir ".pptify" "config.json"

# 读取 config.json 中的 defaultType (如果存在)
$defaultType = ""
if (Test-Path $configFile) {
    $config = Get-Content $configFile -Raw | ConvertFrom-Json
    if ($config.PSObject.Properties.Name -contains 'defaultType') {
        $defaultType = $config.defaultType
    }
}

# 如果已有配置，读取现有配置
if (Test-Path $specFile) {
    $existingConfig = Get-Content $specFile -Raw | ConvertFrom-Json
    
    $result = @{
        status = "success"
        action = "update"
        project_name = $projectName
        project_path = $projectDir
        spec_file = $specFile
        existing_config = $existingConfig
        message = "找到现有配置，AI 可引导用户更新"
    } | ConvertTo-Json -Compress -Depth 10
    
    Output-Json $result
}
else {
    # 创建初始配置模板
    $timestamp = Get-Timestamp
    $initialSpec = @{
        project_name = $projectName
        type = $defaultType
        duration = ""
        slides_count = 0
        topic = ""
        audience = @{
            level = ""
            size = ""
        }
        target_platform = @()
        style = ""
        created_at = $timestamp
        updated_at = $timestamp
    }
    
    $initialSpec | ConvertTo-Json -Depth 10 | Out-File -FilePath $specFile -Encoding UTF8
    
    $result = @{
        status = "success"
        action = "create"
        project_name = $projectName
        project_path = $projectDir
        spec_file = $specFile
        default_type = $defaultType
        message = "已创建配置模板，AI 应引导用户填写以下信息"
        required_fields = @(
            "type (类型): 技术分享/商业路演/教程培训/学术报告",
            "duration (时长): 如 '20分钟' 或 '45分钟'",
            "slides_count (幻灯片数): 建议 15-40 张",
            "topic (主题): 演示的核心主题",
            "audience (受众): 听众水平和规模",
            "target_platform (目标平台): 会议/线上/内部等"
        )
    } | ConvertTo-Json -Compress -Depth 10
    
    Output-Json $result
}

