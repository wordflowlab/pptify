# Pptify 使用示例

## 示例 1: 创建技术会议演讲

### 场景
准备在开发者大会上分享"React Server Components 实践"

### 步骤

```bash
# 1. 初始化项目
pptify init "React Server Components 实践"
cd "React Server Components 实践"
npm install

# 2. 定义演示规格
pptify /spec
```

**在 AI 对话中**:
- 选择类型: A (技术分享)
- 选择配置: A (技术会议演讲 - 20-40分钟, 25-40张)
- 确认配置: A

```bash
# 3. 创建大纲（引导模式）
pptify /outline
```

**AI 会引导你回答**:
1. 核心主题: "React Server Components 如何改变前端架构"
2. 听众特点: "中高级 React 开发者，了解基础但没实践过 RSC"
3. 关键要点:
   - RSC 的核心概念和优势
   - 与传统 SSR 的区别
   - 实际项目迁移经验
   - 性能对比数据
   - 最佳实践和踩坑经验

```bash
# 4. 生成幻灯片
pptify /slides
```

选择: A (技术风格)

```bash
# 5. 预览
npm run dev
```

### 生成的结构

```markdown
# React Server Components 实践

## 开场 (4张)
- 标题页
- 自我介绍
- 问题引入: 为什么需要 RSC?

## 主体 (30张)
### 第一部分: 核心概念 (8张)
- RSC 是什么
- 工作原理
- 与 SSR 的区别

### 第二部分: 实践经验 (12张)
- 项目背景
- 迁移过程
- 遇到的问题
- 解决方案

### 第三部分: 性能对比 (10张)
- 测试数据
- 优化效果
- 最佳实践

## 总结 (6张)
- 核心要点回顾
- 建议和资源
- Q&A
```

---

## 示例 2: 商业路演

### 场景
准备 15 分钟的融资路演

### 步骤

```bash
pptify init "智能客服SaaS平台"
cd "智能客服SaaS平台"
npm install

pptify /spec
```

选择: B (商业路演) → A (标准路演)

```bash
pptify /outline
```

选择: B (快速模式)

AI 会生成标准商业路演大纲：
- 问题（2张）
- 解决方案（3张）
- 市场机会（2张）
- 产品演示（3张）
- 商业模式（2张）
- 竞争分析（1张）
- 团队介绍（1张）
- 财务预测（2张）
- 融资需求（1张）

```bash
pptify /slides
```

选择: B (商业风格)

生成的幻灯片会使用商业风格主题（bricks），包含：
- 专业的数据展示
- 清晰的价值主张
- 视觉化的商业模式

---

## 示例 3: 教学课程

### 场景
录制"Python 入门"系列课程

### 步骤

```bash
pptify init "Python入门第一课"
cd "Python入门第一课"
npm install

pptify /spec
```

选择: C (教程培训) → A (快速教程 - 15-30分钟)

```bash
pptify /outline
```

选择: C (模板模式) → C (教学型模板)

AI 会提供教学模板并引导填充：
```
[1/6] 课程标题
→ Python 基础入门：变量和数据类型

[2/6] 学习目标
→ 1. 理解变量的概念
   2. 掌握基本数据类型
   3. 能够编写简单程序

[3/6] 前置知识
→ 无需编程基础

[4/6] 核心内容（分步骤）
→ 步骤1: 什么是变量
   步骤2: 数据类型介绍
   步骤3: 实践练习
...
```

```bash
pptify /slides
```

选择: C (教育风格)

---

## 示例 4: Lightning Talk (5分钟快速分享)

### 场景
Meetup 上 5 分钟技术分享

### 步骤

```bash
pptify init "Deno 2.0 新特性速览"
cd "Deno 2.0 新特性速览"
npm install

pptify /spec
```

选择: A (技术分享) → B (Lightning Talk - 5-10分钟, 10-15张)

**重点**: Lightning Talk 需要极度聚焦

```bash
pptify /outline
```

AI 建议的 Lightning Talk 结构：
```markdown
# Deno 2.0 新特性速览

## 开场 (1张, 30秒)
- 标题 + 一句话总结

## 核心内容 (10张, 4分钟)
- 新特性1: 原生 npm 支持 (1分钟)
- 新特性2: 性能提升 (1分钟)
- 新特性3: 新 API (1分钟)
- 代码示例 (1分钟)

## 总结 (2张, 30秒)
- 一句话总结 + 资源链接
```

---

## 示例 5: 从现有 Markdown 转换

### 场景
已经有一篇技术博客，想转换成演示

### 步骤

```bash
# 假设你有 blog-post.md
pptify init "我的演示"
cd "我的演示"
npm install

# 转换文档
pptify /convert --from markdown --input ../blog-post.md
```

AI 会：
1. 分析 Markdown 结构
2. 识别标题层级
3. 提取关键要点
4. 生成 Slidev 格式

```bash
# 预览生成的幻灯片
npm run dev

# 如需调整，编辑 slides.md
# 然后刷新浏览器
```

---

## 示例 6: 自定义主题和样式

### 调整主题

编辑 `slides.md` 开头：

```yaml
---
theme: bricks  # 更换主题
background: https://your-image.jpg  # 自定义背景
class: text-center
---
```

可用主题：
- `seriph` - 技术风格（默认）
- `default` - 极简风格
- `bricks` - 商业风格
- `apple-basic` - Apple 风格
- `shibainu` - 可爱风格

### 自定义颜色

```yaml
---
theme: seriph
themeConfig:
  primary: '#5d8392'
---
```

### 添加自定义 CSS

创建 `style.css`:
```css
.slidev-layout {
  background: linear-gradient(to bottom, #667eea 0%, #764ba2 100%);
}
```

在 `slides.md` 中引用:
```yaml
---
theme: seriph
css: ./style.css
---
```

---

## 最佳实践

### 1. 控制幻灯片数量

| 时长 | 建议张数 | 每张时间 |
|------|---------|----------|
| 5分钟 | 10-15张 | 20-30秒 |
| 15分钟 | 15-25张 | 30-60秒 |
| 30分钟 | 25-40张 | 45-75秒 |
| 60分钟 | 40-80张 | 45-90秒 |

### 2. 内容密度

- **标题页**: 简洁，只放标题和必要信息
- **内容页**: 每页 3-5 个要点
- **代码页**: 不超过 15 行，使用高亮
- **总结页**: 3-5 个核心要点

### 3. 视觉设计

- 使用一致的颜色方案
- 图片质量要高
- 避免过多动画
- 代码要有语法高亮

### 4. 演讲技巧

- 10-70-20 原则：开场 10%，主体 70%，总结 20%
- 每 5-7 分钟一个互动点
- 关键数据要视觉化
- 留出 Q&A 时间

---

## 更多资源

- [Slidev 官方文档](https://sli.dev)
- [Slidev 主题 Gallery](https://sli.dev/themes/gallery)
- [Slidev 示例展示](https://sli.dev/showcases)
- [Pptify GitHub](https://github.com/wordflowlab/pptify)

