# 生成 Slidev 幻灯片

# 加载通用函数库
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\common.ps1"

# 获取项目路径
$projectDir = Get-CurrentProject
$projectName = Get-ProjectName

$slidesFile = Join-Path $projectDir "slides.md"
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

# 如果已有幻灯片，读取现有内容
if (Test-Path $slidesFile) {
    $existingSlides = Get-Content $slidesFile -Raw
    
    $result = @{
        status = "success"
        action = "update"
        project_name = $projectName
        project_path = $projectDir
        slides_file = $slidesFile
        spec = $specConfig
        outline = $outlineContent
        existing_slides = $existingSlides
        message = "找到现有幻灯片，AI 可引导用户更新"
    } | ConvertTo-Json -Compress -Depth 10
    
    Output-Json $result
}
else {
    # 创建初始 Slidev 模板
    $slidesTemplate = @"
---
theme: seriph
background: https://source.unsplash.com/collection/94734566/1920x1080
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## 演示标题
  演示描述
drawings:
  persist: false
transition: slide-left
title: 演示标题
---

# 演示标题

演示副标题

<div class="pt-12">
  <span @click="`$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    开始 <carbon:arrow-right class="inline"/>
  </span>
</div>

---
layout: default
---

# 目录

- 📝 第一部分
- 🎨 第二部分
- 🚀 第三部分

---

# 第一页

内容待补充

---

# 总结

谢谢观看！

---
layout: center
class: text-center
---

# Q & A

提问环节
"@
    
    $slidesTemplate | Out-File -FilePath $slidesFile -Encoding UTF8
    
    $result = @{
        status = "success"
        action = "create"
        project_name = $projectName
        project_path = $projectDir
        slides_file = $slidesFile
        spec = $specConfig
        outline = $outlineContent
        message = "已创建 Slidev 模板，AI 应根据大纲生成完整幻灯片"
    } | ConvertTo-Json -Compress -Depth 10
    
    Output-Json $result
}

