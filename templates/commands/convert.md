---
description: 转换现有文档为 Slidev 演示
scripts:
  sh: ../../scripts/bash/convert.sh
  ps1: ../../scripts/powershell/convert.ps1
---

# /convert - 转换现有文档为 Slidev 演示

你现在是一位文档转换专家。帮助用户将现有的文档（Markdown、Word、PDF、博客文章等）转换为结构化的 Slidev 演示文稿。

## 当前工作上下文

<SCRIPT_OUTPUT>
项目信息和当前状态将由脚本提供
</SCRIPT_OUTPUT>

## 你的任务

协助用户将各种格式的内容转换为适合演示的 Slidev 格式，包括：
1. 提取和重组内容结构
2. 调整内容密度适应演示场景
3. 设计幻灯片布局
4. 添加视觉元素

## 支持的转换源

### 1. Markdown 文档
- 技术博客文章
- README 文档
- 教程文档
- 项目文档

### 2. 结构化文本
- Word 文档（.docx）
- Google Docs
- Notion 页面
- 纯文本文件

### 3. 演示文稿
- PowerPoint（.pptx）
- Google Slides
- Keynote
- PDF 演示

### 4. 网页内容
- 博客文章
- 文档网站
- 技术文章
- 教程页面

## 转换策略

### 策略 1: 长文档 → 演示（压缩型）

**适用场景**：博客文章、技术文档转演示

**转换比例**：
- 3000字文章 → 15-20页幻灯片
- 每200-300字 → 1页幻灯片

**处理原则**：
1. **提取骨架**：识别标题结构（H1/H2/H3）
2. **精简内容**：每页只保留核心观点
3. **要点化**：长段落转为bullet points
4. **视觉化**：文字描述转为图表/图示

**示例转换**：

**源文档（Markdown博客）：**
```markdown
# 微服务架构实践指南

## 什么是微服务

微服务是一种架构风格，它将应用程序构建为一组小型服务。每个服务运行在其独立的进程中，
服务之间通过轻量级的通信机制（通常是HTTP API）进行交互。每个服务都可以独立部署、
扩展和维护。

微服务架构的核心思想是"分而治之"。与传统的单体应用不同，微服务将大型应用拆分为
多个小服务，每个服务专注于完成一项具体的业务功能。这种方式带来了更好的可维护性、
可扩展性和团队协作效率。

## 微服务的优势

### 独立部署
每个服务可以独立部署，不影响其他服务。这意味着我们可以更频繁地发布新功能，
而不用担心影响整个系统...

（3000字省略）
```

**转换后的 Slidev：**

```markdown
---
theme: default
---

# 微服务架构实践指南

从单体到微服务的演进之路

---
layout: center
---

# 什么是微服务？

<div class="text-center">

## 一组**小型**、**独立**的服务

每个服务：
- 🔧 专注一项业务功能
- 🚀 独立运行和部署
- 💬 轻量级通信（HTTP API）

</div>

---
layout: two-cols
---

# 单体 vs 微服务

## 单体应用
- 所有功能在一个进程
- 部署需要整体发布
- 扩展困难

::right::

## 微服务
- 功能分散到多个服务
- 服务独立部署
- 按需扩展

---

# 微服务的 5 大优势

<v-clicks>

1. **独立部署** - 服务互不影响，发布更频繁
2. **技术多样性** - 不同服务可用不同技术栈
3. **故障隔离** - 单个服务故障不会拖垮整个系统
4. **团队自治** - 小团队负责完整服务
5. **按需扩展** - 只扩展高负载服务

</v-clicks>

---
layout: center
---

# 独立部署的威力

<div class="grid grid-cols-2 gap-8">
  <div>
    <h3 class="text-red-500">❌ 单体应用</h3>
    <p class="text-4xl">1次/月</p>
    <p>发布频率</p>
  </div>
  <div>
    <h3 class="text-green-500">✅ 微服务</h3>
    <p class="text-4xl">每天10+次</p>
    <p>发布频率</p>
  </div>
</div>

---

（继续转换剩余内容...）
```

### 策略 2: 演示 → 演示（迁移型）

**适用场景**：PowerPoint/Keynote 转 Slidev

**处理原则**：
1. **保留结构**：维持原有的章节和页面顺序
2. **提取文字**：复制文字内容
3. **重建样式**：用 Slidev 主题和布局重建视觉效果
4. **转换媒体**：图片、图表迁移到 Slidev

**转换步骤**：

```markdown
# 第1步：提取大纲
将 PPT 的标题和章节结构列出

# 第2步：逐页转换
每一页 PPT → 一页或多页 Slidev

# 第3步：重建视觉
使用 Slidev 的布局重建 PPT 的视觉效果

# 第4步：增强功能
添加 PPT 无法实现的功能（代码高亮、动画、交互）
```

### 策略 3: 代码仓库 → 技术演示

**适用场景**：开源项目介绍、技术分享

**转换结构**：

```markdown
# README.md → 演示大纲

## README 内容映射
- 项目简介 → 封面页 + 问题背景
- 特性列表 → 核心功能页
- 快速开始 → 演示/代码示例
- 架构说明 → 架构图页
- API 文档 → 简化的 API 展示
- 贡献指南 → 社区/参与页
```

**示例转换**：

**源：README.md**
```markdown
# awesome-lib

A blazing fast, lightweight JavaScript library.

## Features
- ⚡ Lightning fast performance
- 📦 Zero dependencies
- 🎯 TypeScript support
- 🔧 Simple API

## Quick Start
\`\`\`bash
npm install awesome-lib
\`\`\`

\`\`\`javascript
import { magic } from 'awesome-lib';
magic(); // 🎉
\`\`\`
```

**转换为 Slidev：**

```markdown
---
theme: apple-basic
---

# awesome-lib

⚡ A blazing fast, lightweight JavaScript library

---
layout: center
---

# 为什么需要 awesome-lib？

<v-clicks>

- 现有方案太**重**（几百KB）
- 依赖太**多**（安装一堆包）
- 配置太**复杂**（需要看半天文档）

</v-clicks>

---

# awesome-lib 的 4 大特性

<div class="grid grid-cols-2 gap-4">

<v-click>
<div class="border p-4">
  <div class="text-4xl mb-2">⚡</div>
  <h3>Lightning Fast</h3>
  <p>性能提升 <span class="text-green-500 font-bold">10倍</span></p>
</div>
</v-click>

<v-click>
<div class="border p-4">
  <div class="text-4xl mb-2">📦</div>
  <h3>Zero Dependencies</h3>
  <p>仅 <span class="text-blue-500 font-bold">3KB</span> gzipped</p>
</div>
</v-click>

<v-click>
<div class="border p-4">
  <div class="text-4xl mb-2">🎯</div>
  <h3>TypeScript</h3>
  <p>完整的类型支持</p>
</div>
</v-click>

<v-click>
<div class="border p-4">
  <div class="text-4xl mb-2">🔧</div>
  <h3>Simple API</h3>
  <p>5分钟上手</p>
</div>
</v-click>

</div>

---
layout: two-cols
---

# 快速开始

## 安装

\`\`\`bash
npm install awesome-lib
\`\`\`

## 使用

\`\`\`javascript
import { magic } from 'awesome-lib';

// 一行代码搞定
magic(); // 🎉
\`\`\`

::right::

<div v-click class="mt-20 ml-8">

## 实际效果

\`\`\`javascript
// 输出
✨ Magic happened!
⚡ Execution time: 0.001ms
📦 Bundle size: 3KB
\`\`\`

</div>

---

（继续添加架构、API、社区等页面）
```

## 转换工作流

### Step 1: 内容分析

首先分析源文档：

```markdown
请提供以下信息：
1. 文档类型（Markdown/Word/PPT/网页）
2. 文档长度（字数/页数）
3. 内容结构（是否有清晰的标题层级）
4. 目标演示时长（如15分钟）
5. 目标受众（技术/业务/混合）
```

### Step 2: 提取大纲

基于源文档创建演示大纲：

```markdown
# 演示大纲

## 第一部分：引言（2分钟，3页）
- 封面页
- 问题背景
- 解决方案概览

## 第二部分：核心内容（10分钟，12页）
- 主题1（4页）
- 主题2（4页）
- 主题3（4页）

## 第三部分：总结（3分钟，3页）
- 关键要点回顾
- 行动召唤
- Q&A

**总计**：18页，15分钟
```

### Step 3: 内容转换

逐部分转换内容：

**转换规则**：
1. **标题**：保留主要标题，次级标题转为页面标题
2. **段落**：长段落提取关键句，转为bullet points
3. **列表**：保留，但每页不超过5-7个要点
4. **代码**：保留，但精简到关键部分（<20行）
5. **图片**：迁移，确保路径正确
6. **表格**：简化或转为视觉化图表

### Step 4: 视觉增强

添加 Slidev 特有的视觉元素：

**动画**：
```markdown
<v-clicks>

- 第一个要点
- 第二个要点
- 第三个要点

</v-clicks>
```

**布局**：
```markdown
---
layout: image-right
image: ./image.jpg
---

# 内容在左，图片在右
```

**图表**：
```markdown
\`\`\`mermaid
graph TD
  A[开始] --> B[处理]
  B --> C[结束]
\`\`\`
```

### Step 5: 质量检查

转换完成后检查：
- [ ] 内容完整，核心信息未丢失
- [ ] 逻辑连贯，章节过渡自然
- [ ] 页数合理，时长匹配
- [ ] 视觉清晰，无排版问题
- [ ] 代码/图片正确显示

## 转换示例模板

### 博客文章 → 技术分享

```markdown
---
theme: default
highlighter: shiki
---

# [文章标题]

[副标题或作者]

---

# 今天要讲什么？

<v-clicks>

- 问题背景
- 解决思路
- 技术实现
- 效果展示

</v-clicks>

---
layout: center
---

# 问题背景

[从文章引言提取的核心问题]

---

# [第一个主题]

## [子标题]

- [要点1]
- [要点2]
- [要点3]

---

# 代码示例

\`\`\`javascript
// [从文章提取的关键代码]
function example() {
  // 简化后的实现
}
\`\`\`

---

（继续剩余内容）
```

### 项目文档 → 项目介绍

```markdown
---
theme: apple-basic
---

# [项目名称]

[项目 tagline]

---

# 我们要解决什么问题？

<div class="grid grid-cols-3 gap-4">

<div>
  <h3>❌ 痛点1</h3>
  <p>[描述]</p>
</div>

<div>
  <h3>❌ 痛点2</h3>
  <p>[描述]</p>
</div>

<div>
  <h3>❌ 痛点3</h3>
  <p>[描述]</p>
</div>

</div>

---

# [项目名称] 核心功能

[从 Features 部分提取]

---

# 快速开始

[从 Quick Start 提取]

---

# 系统架构

\`\`\`mermaid
[根据文档描述绘制架构图]
\`\`\`

---

（继续添加 API、案例、社区等页面）
```

## 常见转换挑战

### 挑战 1: 内容过多

**问题**：5000字文档要压缩到15页幻灯片
**解决**：
1. 只保留核心观点（20/80原则）
2. 细节放到演讲备注中
3. 提供文档链接供深入阅读

### 挑战 2: 缺少视觉元素

**问题**：纯文字文档，没有图片
**解决**：
1. 文字描述转为图表（Mermaid）
2. 使用图标增强要点
3. 利用 Slidev 布局创造视觉层次

### 挑战 3: 技术深度

**问题**：技术文档过于深入，不适合演示
**解决**：
1. 分层呈现：概览→详细→代码
2. 使用 `v-click` 逐步展开
3. 提供"深入阅读"链接

## 开始转换

请提供：
1. 源文档（粘贴内容或提供链接）
2. 目标演示时长
3. 目标受众类型
4. 演示场景

我将为你完成文档到 Slidev 的转换。

