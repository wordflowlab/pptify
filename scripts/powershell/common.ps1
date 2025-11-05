# 通用函数库

# 输出 JSON 格式
function Output-Json {
    param([string]$JsonString)
    Write-Output $JsonString
}

# 查找项目根目录
function Get-CurrentProject {
    $currentDir = Get-Location
    
    # 向上查找，最多10层
    for ($i = 0; $i -lt 10; $i++) {
        $pptifyDir = Join-Path $currentDir ".pptify"
        if (Test-Path $pptifyDir -PathType Container) {
            return $currentDir.Path
        }
        
        $parentDir = Split-Path $currentDir -Parent
        if ([string]::IsNullOrEmpty($parentDir) -or $parentDir -eq $currentDir) {
            break
        }
        $currentDir = $parentDir
    }
    
    # 未找到项目根目录
    $errorJson = @{
        status = "error"
        message = "未找到 .pptify 目录，请在项目根目录运行"
    } | ConvertTo-Json -Compress
    Output-Json $errorJson
    exit 1
}

# 获取项目名称
function Get-ProjectName {
    $projectDir = Get-CurrentProject
    return Split-Path $projectDir -Leaf
}

# 读取项目配置
function Get-ProjectConfig {
    $projectDir = Get-CurrentProject
    $configFile = Join-Path $projectDir ".pptify" "config.json"
    
    if (Test-Path $configFile) {
        return Get-Content $configFile -Raw
    }
    else {
        return "{}"
    }
}

# 确保文件存在
function Ensure-File {
    param(
        [string]$FilePath,
        [string]$DefaultContent = ""
    )
    
    if (-not (Test-Path $FilePath)) {
        $DefaultContent | Out-File -FilePath $FilePath -Encoding UTF8
    }
}

# 获取当前时间戳（ISO 8601）
function Get-Timestamp {
    return (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
}

