# Changelog

All notable changes to this project will be documented in this file.

## [0.1.0] - 2024-11-05

### Added

- 🎉 初始版本发布
- ✨ 支持 13 种 AI 编程工具（Claude, Cursor, Gemini, Windsurf, Roo Code, GitHub Copilot, Qwen, OpenCode, Codex, Kilo Code, Auggie, CodeBuddy, Amazon Q）
- 📊 支持 4 种演示类型（技术分享、商业路演、教程培训、学术报告）
- 🎨 内置多种 Slidev 主题和模板
- 🤖 AI 辅助创作工作流
- 📝 三种大纲创作模式（引导/快速/模板）
- 🎯 快速配置包系统
- 💻 跨平台脚本支持（Bash + PowerShell）
- 📦 基于 Slidev 的演示生成
- 🔄 文档转换功能
- 📤 多格式导出（PDF/PPTX/HTML）

### Project Structure

```
pptify/
├── src/              # TypeScript 源代码
├── scripts/          # Bash/PowerShell 脚本
├── templates/        # AI 模板和 Slidev 模板
├── dist/            # 编译输出
└── package.json     # 项目配置
```

### Commands

- `/init` - 初始化项目
- `/spec` - 定义演示规格
- `/outline` - 创建大纲
- `/slides` - 生成 Slidev 幻灯片
- `/preview` - 预览演示
- `/export` - 导出多种格式

### Dependencies

- @slidev/cli: ^0.49.0
- @commander-js/extra-typings: ^12.0.0
- chalk: ^5.3.0
- inquirer: ^9.2.12
- fs-extra: ^11.2.0
- js-yaml: ^4.1.0

---

## [Unreleased]

### Planned

- [ ] Web UI 版本
- [ ] 更多 Slidev 主题
- [ ] 协作功能
- [ ] 云端同步
- [ ] 模板市场
- [ ] 插件系统

