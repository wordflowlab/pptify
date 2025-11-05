# Changelog

All notable changes to this project will be documented in this file.

## [0.1.5] - 2024-11-05

### Documentation

- 📝 更新 README：
  - 添加 npm 版本和许可证徽章
  - 标注当前版本信息
  - 更新特性列表（多格式导出功能）
  - 更新快速开始示例（PPTX 导出）
  - 更新开发路线图（完成 Phase 4）

## [0.1.4] - 2024-11-05

### Added

- ✨ **PPTX 导出支持**: 现在可以直接导出为 PowerPoint 格式！
  - 使用 `pptify export --pptx` 导出 PPTX 文件
  - 基于 [Slidev 官方导出功能](https://cn.sli.dev/guide/exporting#pptx)
  - 自动包含演讲者备注
  - 幻灯片转为图片格式（保持视觉效果）
  
- 🖼️ **PNG 导出支持**: 导出每张幻灯片为 PNG 图片
  - 使用 `pptify export --png`
  
- 📦 **自动依赖管理**: 
  - 自动检测并安装 `playwright-chromium`
  - 新项目自动包含导出所需依赖
  
- 📝 **改进的导出命令**:
  - 清晰的提示信息
  - 显示输出文件路径
  - 支持多种格式（PDF、PPTX、PNG、HTML）

### Improved

- 🔧 优化导出脚本（bash & PowerShell）
- 📚 更新项目模板的 package.json
- 💡 添加用户友好的提示信息

## [0.1.3] - 2024-11-05

### Fixed

- 🐛 **Slidev 语法错误修复**: 在 slides.md 命令模板中添加了详细的错误避免指南
- 📝 添加常见 Slidev/Vue 编译错误的解决方案（插槽语法、HTML/Markdown 混用等）
- ✅ 提供正确的 Slidev 语法示例，避免 "Extraneous children found" 错误

### Improved

- 📚 改进了 `/slides` 命令的 AI 提示模板
- 🎯 添加了清晰的 "做与不做" 示例
- 💡 包含正确的插槽用法（`::slot-name::` 语法）

## [0.1.2] - 2024-11-05

### Added

- ✨ **完整命令支持**: 新增 5 个命令模板（content, theme, polish, convert, save）
- 💻 **PowerShell 完整支持**: 新增所有 11 个 PowerShell 脚本（.ps1）
- 🔧 **Bash 脚本补全**: 新增缺失的 5 个 bash 脚本（content.sh, theme.sh, polish.sh, convert.sh, save.sh）
- 📝 **统一元数据**: 为所有命令模板添加 frontmatter 声明（描述和脚本路径）

### Improved

- 🎯 所有命令现在都有对应的 AI 提示模板
- 🪟 Windows 用户现在可以完整使用 PowerShell 脚本
- 📚 命令模板结构更加规范统一

### Fixed

- 修复命令模板不全的问题
- 修复 PowerShell 脚本缺失的问题
- 设置所有脚本的正确执行权限

## [0.1.1] - 2024-11-05

### Fixed

- 🐛 **Critical Fix**: Added `files` field to package.json to include `templates/` and `scripts/` directories in npm package
- Fixed "ENOENT: no such file or directory" error when initializing projects
- Ensured all necessary files are included in the published npm package

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

