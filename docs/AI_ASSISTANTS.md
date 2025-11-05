# 支持的 AI 编程助手配置

Pptify 支持 13 种主流 AI 编程助手，在项目初始化时选择你使用的助手，系统会自动配置相应的命令文件。

## 支持列表

### 1. Claude Code

- **配置目录**: `.claude/`
- **命令文件夹**: `commands/`
- **特点**: Anthropic Claude 驱动，适合复杂推理
- **推荐场景**: 技术深度内容、复杂结构设计

### 2. Cursor

- **配置目录**: `.cursor/`
- **命令文件夹**: `commands/`
- **特点**: VS Code 集成，快速响应
- **推荐场景**: 快速迭代、代码示例丰富的演示

### 3. Gemini CLI

- **配置目录**: `.gemini/`
- **命令文件夹**: `commands/`
- **特点**: Google Gemini，多模态支持
- **推荐场景**: 需要图像理解的演示

### 4. Windsurf

- **配置目录**: `.windsurf/`
- **命令文件夹**: `workflows/`
- **特点**: 工作流导向
- **推荐场景**: 流程化创作

### 5. Roo Code

- **配置目录**: `.roo/`
- **命令文件夹**: `commands/`
- **特点**: 轻量级，快速
- **推荐场景**: 简单快速的演示

### 6. GitHub Copilot

- **配置目录**: `.github/`
- **命令文件夹**: `prompts/`
- **特点**: GitHub 集成，代码补全强大
- **推荐场景**: 代码密集型技术演示

### 7. Qwen Code

- **配置目录**: `.qwen/`
- **命令文件夹**: `commands/`
- **特点**: 阿里通义千问，中文友好
- **推荐场景**: 中文演示、国内场景

### 8. OpenCode

- **配置目录**: `.opencode/`
- **命令文件夹**: `command/` (注意是单数)
- **特点**: 开源友好
- **推荐场景**: 开源项目介绍

### 9. Codex CLI

- **配置目录**: `.codex/`
- **命令文件夹**: `prompts/`
- **特点**: OpenAI Codex
- **推荐场景**: 通用技术演示

### 10. Kilo Code

- **配置目录**: `.kilocode/`
- **命令文件夹**: `workflows/`
- **特点**: 工作流设计
- **推荐场景**: 复杂流程的演示

### 11. Auggie CLI

- **配置目录**: `.augment/`
- **命令文件夹**: `commands/`
- **特点**: 增强型 AI
- **推荐场景**: 需要深度定制的演示

### 12. CodeBuddy

- **配置目录**: `.codebuddy/`
- **命令文件夹**: `commands/`
- **特点**: 友好交互
- **推荐场景**: 教学类演示

### 13. Amazon Q Developer

- **配置目录**: `.amazonq/`
- **命令文件夹**: `prompts/`
- **特点**: AWS 集成
- **推荐场景**: 云服务相关演示

---

## 配置文件结构

选择 AI 助手后，会在项目中生成相应的配置目录：

```
my-presentation/
├── .{ai-dir}/              # 如 .claude/
│   └── {commands-dir}/     # 如 commands/
│       ├── spec.md         # 规格定义命令
│       ├── outline.md      # 大纲创建命令
│       ├── slides.md       # 幻灯片生成命令
│       └── ...            # 其他命令
```

---

## 命令文件说明

每个命令文件（如 `spec.md`）包含：

1. **YAML Frontmatter**: 命令元数据
   ```yaml
   ---
   description: 命令描述
   scripts:
     sh: 对应的 bash 脚本
     ps1: 对应的 PowerShell 脚本
   ---
   ```

2. **AI 提示词**: Markdown 格式的详细指导
   - AI 角色定义
   - 工作流程
   - 交互规则
   - 最佳实践

---

## 如何选择 AI 助手？

### 按使用场景选择

| 场景 | 推荐 AI | 理由 |
|------|---------|------|
| 技术深度内容 | Claude Code | 推理能力强 |
| 快速迭代 | Cursor | 响应快速 |
| 中文演示 | Qwen Code | 中文理解好 |
| 代码示例多 | GitHub Copilot | 代码补全强 |
| 教学培训 | CodeBuddy | 交互友好 |
| 商业路演 | Claude Code | 逻辑严谨 |

### 按你已有的工具选择

如果你已经在使用某个 AI 编程助手，直接选择它即可。Pptify 会自动配置相应的命令文件。

---

## 切换 AI 助手

如果需要更换 AI 助手：

1. 编辑 `.pptify/config.json`，修改 `ai` 字段
2. 重新运行 `pptify init --here` 生成新的配置文件
3. 删除旧的 AI 配置目录（可选）

---

## 自定义命令

所有命令模板都在 `templates/commands/` 目录中，你可以：

1. 直接编辑生成的命令文件（在 `.{ai-dir}/{commands-dir}/` 中）
2. 或修改模板文件，然后重新初始化项目

---

## 更多信息

- 各 AI 助手的详细文档，请参考其官方网站
- Pptify 的命令设计，请参考 [README.md](../README.md)

