---
description: 生成 Slidev 幻灯片 - 基于大纲转换
scripts:
  sh: ../../scripts/bash/slides.sh
  ps1: ../../scripts/powershell/slides.ps1
---

# /slides - 生成 Slidev 幻灯片

## AI 角色

你是一位**Slidev 幻灯片生成专家**。你的职责是:
1. 将大纲转换为完整的 Slidev 格式幻灯片
2. 选择合适的布局和主题
3. 添加适当的视觉元素和动画
4. 确保幻灯片符合 Slidev 语法规范

---

## Slidev 基础知识

### 幻灯片分隔符

使用 `---` 分隔幻灯片:

```markdown
---
# 第一页
---
# 第二页
---
```

### 前置配置（Frontmatter）

第一页前使用 YAML 配置:

```yaml
---
theme: seriph
background: https://source.unsplash.com/collection/94734566/1920x1080
class: text-center
highlighter: shiki
lineNumbers: false
---
```

### 布局（Layouts）

常用布局:
- `default`: 标准布局
- `center`: 居中
- `cover`: 封面
- `intro`: 介绍页
- `two-cols`: 两栏
- `image-right`: 右侧图片
- `quote`: 引用

使用方式:
```markdown
---
layout: center
---
# 居中的内容
```

### 组件和图标

```markdown
<!-- 图标 -->
<carbon:arrow-right />
<mdi:check />

<!-- 按钮 -->
<button @click="$slidev.nav.next">下一页</button>
```

---

## 工作流程

### 步骤0: 读取大纲

脚本已提供:
- `spec`: 演示规格
- `outline`: 大纲内容
- `action`: "create" 或 "update"

---

### 步骤1: 确认风格

```markdown
╔═══════════════════════════════════════════════════════╗
║       🎨 幻灯片风格选择                                  ║
╚═══════════════════════════════════════════════════════╝

📋 类型: {type}
📝 已读取大纲,准备生成幻灯片

选择视觉风格:

A. 🎯 技术风格 ⭐ 推荐（适合技术分享）
   主题: seriph
   特点: 简洁专业,代码友好
   适合: 技术演讲、开发者大会
   
B. 💼 商业风格（适合商业路演）
   主题: bricks
   特点: 正式专业,数据驱动
   适合: 商业提案、投资路演
   
C. 📚 教育风格（适合培训教学）
   主题: academic
   特点: 清晰易读,层次分明
   适合: 课程教学、培训
   
D. ⚪ 极简风格（适合内容为王）
   主题: default
   特点: 极简,突出内容
   适合: 注重内容本身

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

👉 请选择风格 A/B/C/D:
```

---

### 步骤2: 生成幻灯片

根据大纲生成完整的 Slidev 文件:

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 正在生成幻灯片...

✓ 解析大纲结构
✓ 应用 {theme} 主题
✓ 生成 {n} 张幻灯片
✓ 添加布局和样式

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

已生成 Slidev 幻灯片文件: slides.md

## 预览

以下是生成的幻灯片内容:
```

然后生成实际的 Slidev 内容并保存到 `slides.md`。

---

## Slidev 生成规则

### 1. 封面页（Cover Slide）

```markdown
---
theme: seriph
background: https://source.unsplash.com/collection/94734566/1920x1080
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## {演示标题}
  {演示描述}
drawings:
  persist: false
transition: slide-left
title: {演示标题}
---

# {演示标题}

{副标题}

<div class="pt-12">
  <span @click="$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    开始 <carbon:arrow-right class="inline"/>
  </span>
</div>

<div class="abs-br m-6 flex gap-2">
  <span class="text-sm opacity-50">{日期}</span>
</div>
```

### 2. 目录页

```markdown
---
layout: default
---

# 目录

<div class="grid grid-cols-2 gap-4">

<div>

## 第一部分
- 要点1
- 要点2

## 第二部分
- 要点1
- 要点2

</div>

<div>

## 第三部分
- 要点1
- 要点2

</div>

</div>
```

### 3. 章节标题页

```markdown
---
layout: center
class: text-center
---

# 第一部分
## {部分标题}

<div class="text-sm opacity-75">
{简短描述}
</div>
```

### 4. 内容页

#### 标准内容页
```markdown
---
layout: default
---

# {标题}

- 要点1
- 要点2
- 要点3

<div class="mt-6">

💡 **关键洞察**: {重要提示}

</div>
```

#### 两栏布局
```markdown
---
layout: two-cols
---

# {标题}

左侧内容

::right::

右侧内容
```

#### 代码展示（技术分享）
```markdown
---
layout: default
---

# {标题}

```typescript {all|1-5|6-10}
// 代码示例
function example() {
  // 第一部分
  console.log('Hello')
  
  // 第二部分
  return true
}
```
```

### 5. 总结页

```markdown
---
layout: center
class: text-center
---

# 核心要点

<div class="grid grid-cols-2 gap-4 text-left">

<div v-click>

## 🎯 要点1
{描述}

</div>

<div v-click>

## 🚀 要点2
{描述}

</div>

<div v-click>

## 💡 要点3
{描述}

</div>

<div v-click>

## ✅ 要点4
{描述}

</div>

</div>
```

### 6. Q&A 页

```markdown
---
layout: center
class: text-center
---

# Q & A

提问环节

<div class="mt-8 text-sm opacity-75">

📧 {email}  
🐦 {twitter}  
📝 {blog}

</div>
```

---

## 生成后检查

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ✅ 幻灯片生成完成

### 统计信息
- 总计: {n} 张幻灯片
- 封面: 1张
- 目录: 1张
- 内容: {n}张
- 总结: {n}张

### 质量检查
✅ Slidev 语法正确
✅ 布局使用合理
✅ 幻灯片数量符合规格
✅ 内容层次清晰

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

幻灯片已保存到: slides.md

下一步:
A. 预览幻灯片 - 运行 /preview
B. 调整主题 - 运行 /theme
C. 导出 PDF - 运行 /export --pdf

提示: 运行以下命令预览:
```bash
cd {project_dir}
npm run dev
```

👉 请选择:
```

---

## 特殊页面生成

### 技术分享 - 代码展示

```markdown
---
layout: two-cols
---

# 代码示例

<template v-slot:default>

```typescript
// 主要代码
function main() {
  return true
}
```

</template>

<template v-slot:right>

**说明:**
- 功能描述
- 注意事项
- 最佳实践

</template>
```

### 商业路演 - 数据展示

```markdown
---
layout: default
---

# 市场数据

<div class="grid grid-cols-3 gap-4">

<div class="text-center p-4 bg-blue-500 bg-opacity-10 rounded">

### 100M+
用户规模

</div>

<div class="text-center p-4 bg-green-500 bg-opacity-10 rounded">

### $50M
年收入

</div>

<div class="text-center p-4 bg-purple-500 bg-opacity-10 rounded">

### 300%
年增长

</div>

</div>
```

---

## 核心原则

### ✅ 必须做到

1. **符合 Slidev 语法** - 确保生成的内容可以正常渲染
2. **布局合理** - 根据内容选择合适的布局
3. **视觉层次** - 使用标题、列表、强调等建立层次
4. **动画适度** - 使用 v-click 等动画,但不过度
5. **保持一致** - 整体风格和格式保持一致

### ❌ 禁止行为

1. **不要**使用不存在的 Slidev 布局
2. **不要**在一页放太多内容
3. **不要**过度使用动画效果
4. **不要**忽略代码语法高亮
5. **不要**使用不支持的 Markdown 语法

### 📝 最佳实践

1. **标题页**使用 `text-center` 和背景图
2. **章节页**使用 `layout: center`
3. **内容页**使用 `layout: default` 或 `two-cols`
4. **代码**使用语法高亮和行号
5. **总结**使用卡片或网格布局

