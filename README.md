# Pptify - AI 驱动的 Slidev 演示创作工具

> 基于 Slidev 的智能演示文稿创作系统

**核心价值**: 帮助创作者快速创建专业演示文稿，支持技术分享、商业路演、教程培训、学术报告等多种类型。

## ⚡ 特性

✅ **13种AI助手支持** - Claude/Cursor/Gemini/Windsurf/Roo Code等全平台支持  
✅ **多种演示类型** - 技术分享/商业路演/教程培训/学术报告  
✅ **AI辅助创作** - 从规格定义到幻灯片生成的全流程AI辅助  
✅ **Slidev驱动** - 基于强大的 Slidev 演示引擎  
✅ **模板丰富** - 内置多种专业模板和快速配置包  
✅ **跨平台脚本** - 支持 Bash (macOS/Linux) 和 PowerShell (Windows)

---

## 📦 安装

```bash
# 全局安装
npm install -g ai-pptify

# 或本地开发
git clone https://github.com/wordflowlab/pptify.git
cd pptify
npm install
npm run build
```

---

## 🚀 快速开始

### 1. 初始化演示项目

```bash
# 交互式创建项目，会引导选择 AI 助手、演示类型等
pptify init "我的技术分享"
cd "我的技术分享"
npm install
```

### 2. 开始创作

#### 完整创作流程

```bash
pptify /spec        # 1. 定义演示规格（类型、时长、受众）
pptify /outline     # 2. 创建演示大纲
pptify /slides      # 3. 生成 Slidev 幻灯片
pptify /preview     # 4. 预览演示
pptify /export --pdf # 5. 导出 PDF
```

---

## 🎯 核心功能

### 1. 演示规格定义 (`/spec`)

**快速配置包选择** - 不用逐项填写，通过ABCDE选择快速配置

演示类型：
- **技术分享**: 技术会议演讲 / Lightning Talk / 技术培训
- **商业路演**: 电梯演讲 / 标准路演 / 详细方案
- **教程培训**: 快速教程 / 深度培训 / 系列课程
- **学术报告**: 会议论文 / 论文答辩 / 海报展示

### 2. 大纲创建 (`/outline`)

**三种创作模式**:
- **引导模式**: AI 提问，引导思考，100%原创
- **快速模式**: AI 生成初稿，快速迭代
- **模板模式**: 选择标准模板，填充内容

### 3. 幻灯片生成 (`/slides`)

**功能**:
- 将大纲转换为完整 Slidev 幻灯片
- 智能选择布局和主题
- 支持代码高亮、动画、图表
- 遵循 Slidev 最佳实践

**支持的主题**:
- **技术风格**: seriph, default, apple-basic
- **商业风格**: bricks, mokia
- **教育风格**: academic, shibainu
- **极简风格**: default, none

### 4. 预览和导出

```bash
pptify /preview          # 启动预览服务器
pptify /export           # 导出 PDF（默认）
pptify /export --pptx    # 导出 PowerPoint
pptify /export --png     # 导出 PNG 图片
pptify /export --html    # 导出 HTML
```

**注意**：
- PPTX 导出会将幻灯片转为图片，文本不可选择，但保持完整视觉效果
- 首次使用 PPTX/PNG 导出时会自动安装 `playwright-chromium`
- 演讲者备注会包含在 PPTX 文件中
- 详见 [Slidev 导出文档](https://cn.sli.dev/guide/exporting)

---

## 📚 完整命令列表

### 项目管理
- `/init` - 初始化项目（支持13种AI助手）
- `/save` - 保存项目
- `/list` - 列出项目

### 创作流程
- `/spec` - 定义演示规格
- `/outline` - 创建大纲
- `/content` - 生成详细内容（可选）
- `/slides` - 生成 Slidev 幻灯片

### 增强功能
- `/theme` - 选择/配置主题
- `/convert` - 转换现有文档
- `/polish` - 内容润色
- `/review` - 质量检查

### 预览导出
- `/preview` - 预览演示
- `/export` - 导出多种格式

---

## 🎨 支持的 13 种 AI 编程工具

| AI 工具 | 配置目录 | 命令文件夹 | 显示名称 |
|---------|---------|-----------|----------|
| claude | `.claude` | `commands` | Claude Code |
| cursor | `.cursor` | `commands` | Cursor |
| gemini | `.gemini` | `commands` | Gemini CLI |
| windsurf | `.windsurf` | `workflows` | Windsurf |
| roocode | `.roo` | `commands` | Roo Code |
| copilot | `.github` | `prompts` | GitHub Copilot |
| qwen | `.qwen` | `commands` | Qwen Code |
| opencode | `.opencode` | `command` | OpenCode |
| codex | `.codex` | `prompts` | Codex CLI |
| kilocode | `.kilocode` | `workflows` | Kilo Code |
| auggie | `.augment` | `commands` | Auggie CLI |
| codebuddy | `.codebuddy` | `commands` | CodeBuddy |
| q | `.amazonq` | `prompts` | Amazon Q Developer |

初始化时选择你使用的 AI 助手，Pptify 会自动生成对应的配置文件。

---

## 🏗 项目结构

```
my-presentation/
├── .pptify/
│   └── config.json          # 项目配置
├── .claude/                 # AI配置（根据选择变化）
│   └── commands/
│       ├── spec.md
│       ├── outline.md
│       └── slides.md
├── scripts/
│   └── bash/               # 或 powershell/
│       ├── common.sh
│       ├── spec.sh
│       ├── outline.sh
│       └── slides.sh
├── templates/
│   ├── commands/           # AI 提示词模板
│   ├── slides/             # Slidev 模板
│   └── option-templates/   # 配置选项
├── slides.md               # Slidev 主文件
├── outline.md              # 演示大纲
├── spec.json               # 演示规格
├── package.json            # 包含 Slidev 依赖
└── README.md
```

---

## 💡 使用示例

### 示例 1: 技术会议演讲

```bash
# 1. 初始化项目
pptify init "React Hooks 最佳实践"
cd "React Hooks 最佳实践"
npm install

# 2. 定义规格（选择：技术分享 → 技术会议演讲）
pptify /spec

# 3. 创建大纲（选择：引导模式）
pptify /outline

# 4. 生成幻灯片（选择：技术风格）
pptify /slides

# 5. 预览
npm run dev
```

### 示例 2: 商业路演

```bash
# 1. 初始化
pptify init "创业项目路演"
cd "创业项目路演"
npm install

# 2. 定义规格（选择：商业路演 → 标准路演）
pptify /spec

# 3. 快速生成大纲
pptify /outline  # 选择：快速模式

# 4. 生成商业风格幻灯片
pptify /slides  # 选择：商业风格

# 5. 导出 PDF
npm run export
```

---

## 🎓 Slidev 基础

Pptify 基于 [Slidev](https://sli.dev) - 为开发者设计的演示工具。

### 为什么选择 Slidev？

✅ **Markdown 驱动** - 用熟悉的 Markdown 编写  
✅ **代码高亮** - 完美支持各种编程语言  
✅ **主题丰富** - 多种专业主题可选  
✅ **交互式** - 支持 Vue 组件和动画  
✅ **导出灵活** - PDF/PNG/PPTX 多种格式

### Slidev 基本语法

```markdown
---
theme: seriph
---

# 标题页

内容

---

# 第二页

- 列表项 1
- 列表项 2

---
layout: two-cols
---

# 两栏布局

左侧内容

::right::

右侧内容
```

更多 Slidev 文档: https://sli.dev

---

## 🔧 高级功能

### 文档转换

```bash
# 将现有 Markdown 转换为 Slidev
pptify /convert --from markdown

# 将 Word 文档转换为 Slidev
pptify /convert --from word
```

### 主题定制

```bash
# 选择主题
pptify /theme

# 自定义配色
pptify /theme --customize
```

### 内容优化

```bash
# AI 润色内容
pptify /polish

# 质量检查
pptify /review
```

---

## 🛣 开发路线图

- ✅ Phase 1: 基础架构和核心命令
- ✅ Phase 2: 13种AI助手支持
- ✅ Phase 3: 多种演示类型模板
- 📋 Phase 4: Web UI 版本
- 📋 Phase 5: 协作和分享功能
- 📋 Phase 6: 更多主题和插件

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request!

### 开发

```bash
# 克隆仓库
git clone https://github.com/wordflowlab/pptify.git
cd pptify

# 安装依赖
npm install

# 开发模式
npm run dev

# 构建
npm run build
```

---

## 📄 License

MIT License

---

## 🔗 相关链接

- **Slidev 官网**: https://sli.dev
- **Slidev 文档**: https://sli.dev/guide/
- **主题Gallery**: https://sli.dev/themes/gallery
- **示例展示**: https://sli.dev/showcases

---

## 💬 社区和支持

- **GitHub Issues**: [提交问题](https://github.com/wordflowlab/pptify/issues)
- **讨论区**: [参与讨论](https://github.com/wordflowlab/pptify/discussions)
- **文档**: [查看文档](https://github.com/wordflowlab/pptify#readme)

---

## 🌟 致谢

- 感谢 [Slidev](https://sli.dev) 提供强大的演示引擎
- 感谢 [Scriptify](https://github.com/wordflowlab/scriptify) 提供架构灵感
- 感谢所有贡献者和使用者

---

**让演示创作更简单、更专业、更高效！** 🚀

