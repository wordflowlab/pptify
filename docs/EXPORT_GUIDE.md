# Pptify 导出指南

## 📦 支持的导出格式

Pptify 基于 [Slidev](https://cn.sli.dev/guide/exporting) 提供多种导出格式：

| 格式 | 命令 | 说明 | 用途 |
|------|------|------|------|
| **PDF** | `pptify export` 或 `pptify export --pdf` | 默认格式 | 打印、分享 |
| **PPTX** | `pptify export --pptx` | PowerPoint 格式 | 编辑、演讲 |
| **PNG** | `pptify export --png` | 图片格式 | 社交媒体、网站 |
| **HTML** | `pptify export --html` | 网页应用 | 在线托管 |

## 🚀 快速开始

### 准备工作

首次使用 PPTX/PNG/PDF 导出时，需要安装 `playwright-chromium`：

```bash
# 会在首次导出时自动安装
# 或手动安装
npm install -D playwright-chromium
```

### 基本用法

```bash
# 进入项目目录
cd my-presentation

# 导出 PDF（默认）
pptify export

# 导出 PowerPoint
pptify export --pptx

# 导出 PNG 图片
pptify export --png

# 导出 HTML（SPA）
pptify export --html
```

## 📖 详细说明

### 1. PDF 导出

**特点**：
- ✅ 文本可选择、可复制
- ✅ 文件小，易分享
- ✅ 跨平台兼容性好
- ✅ 适合打印

**命令**：
```bash
pptify export
# 或
pptify export --pdf
```

**输出文件**：`slides-export.pdf`

**适用场景**：
- 会议资料分享
- 文档存档
- 打印讲义

---

### 2. PPTX 导出 ⭐ 新功能

**特点**：
- ✅ PowerPoint 兼容
- ✅ 保持完整视觉效果
- ✅ 包含演讲者备注
- ⚠️ 幻灯片转为图片（文本不可选）
- ⚠️ 需要 playwright-chromium

**命令**：
```bash
pptify export --pptx
```

**输出文件**：`slides-export.pptx`

**重要说明**：
根据 [Slidev 官方文档](https://cn.sli.dev/guide/exporting#pptx)：
> PPTX 文件中的所有幻灯片都会被导出为图片，因此文本不可选择。演讲者备注将以每张幻灯片为单位传递到 PPTX 文件中。

这意味着：
- 幻灯片是图片格式，无法直接编辑文字
- 但保持了所有视觉效果（动画、特效、自定义样式）
- 演讲者备注可以在 PowerPoint 中查看和编辑

**适用场景**：
- 需要在 PowerPoint 中演示
- 公司要求使用 PPTX 格式
- 需要添加/编辑演讲者备注
- 分享给不熟悉 PDF 的用户

**演讲者备注**：

在 Slidev 中添加演讲者备注：

```markdown
---
# 幻灯片内容
---

# 标题

内容...

<!--
这里是演讲者备注
- 重点1
- 重点2
- 演讲提示
-->
```

导出为 PPTX 后，这些备注会出现在 PowerPoint 的备注栏中。

---

### 3. PNG 导出

**特点**：
- ✅ 每张幻灯片一个 PNG 文件
- ✅ 高质量图片
- ✅ 适合网络分享
- ⚠️ 文件较大

**命令**：
```bash
pptify export --png
```

**输出文件**：`slides-export-*.png`（多个文件）

**适用场景**：
- 社交媒体分享
- 网站/博客插图
- 制作动图
- 视频制作素材

---

### 4. HTML 导出

**特点**：
- ✅ 完整的 SPA 应用
- ✅ 保持交互性
- ✅ 可在线托管
- ✅ 支持演讲者模式

**命令**：
```bash
pptify export --html
```

**输出目录**：`dist/`

**部署**：
```bash
# 导出后
pptify export --html

# 部署到 GitHub Pages
cd dist
git init
git add .
git commit -m "deploy"
git push -f git@github.com:username/repo.git master:gh-pages

# 或使用 Vercel/Netlify 直接部署 dist 目录
```

**适用场景**：
- 在线演示
- 远程会议
- 永久在线访问
- 需要保持交互性

## 🎯 对比选择

| 需求 | 推荐格式 | 原因 |
|------|---------|------|
| 打印讲义 | PDF | 文本清晰，可选择 |
| 公司分享 | PPTX | 通用格式，兼容性好 |
| 在线演示 | HTML | 保持交互性 |
| 社交分享 | PNG | 图片格式，易分享 |
| 邮件发送 | PDF | 文件小，兼容性好 |
| 需要编辑备注 | PPTX | 支持备注编辑 |
| 高质量存档 | PDF | 标准格式，长期保存 |

## 💡 高级选项

### 项目中的快捷命令

创建项目后，`package.json` 会包含快捷脚本：

```json
{
  "scripts": {
    "export": "slidev export",
    "export:pdf": "slidev export",
    "export:pptx": "slidev export --format pptx",
    "export:png": "slidev export --format png"
  }
}
```

使用方式：
```bash
npm run export        # PDF
npm run export:pptx   # PPTX
npm run export:png    # PNG
```

### Slidev 高级导出选项

直接使用 Slidev 命令获得更多控制：

```bash
cd my-presentation

# 带点击动画
npx slidev export --with-clicks

# 暗色模式
npx slidev export --dark

# 指定范围（导出第 1-5 张）
npx slidev export --range 1-5

# PPTX 特定选项
npx slidev export --format pptx --with-clicks

# 更多选项见
npx slidev export --help
```

详见 [Slidev 导出文档](https://cn.sli.dev/guide/exporting)。

## 🐛 常见问题

### Q: 导出时提示缺少 playwright-chromium？

**A**: 自动安装即可：
```bash
cd my-presentation
npm install -D playwright-chromium
```

### Q: PPTX 中的文字无法编辑？

**A**: 这是正常的。PPTX 导出会将幻灯片转为图片以保持视觉效果。如果需要可编辑文字，使用 PDF 格式或直接在 Slidev 中编辑源文件。

### Q: 导出的 PPTX 文件很大？

**A**: 因为包含了高质量图片。可以：
- 压缩源文件中的图片
- 使用较小的背景图
- 减少复杂动画

### Q: 演讲者备注没有出现在 PPTX 中？

**A**: 确保在 `slides.md` 中正确添加了备注：
```markdown
# 幻灯片内容

<!--
演讲者备注写在这里
-->
```

### Q: 如何批量导出多个项目？

**A**: 使用脚本：
```bash
#!/bin/bash
for project in project1 project2 project3; do
  cd $project
  pptify export --pptx
  cd ..
done
```

### Q: 导出卡住或超时？

**A**: 尝试：
```bash
# 增加超时时间
npx slidev export --timeout 60000

# 或等待选项
npx slidev export --wait 10000
```

## 📚 参考资源

- [Slidev 官方导出文档](https://cn.sli.dev/guide/exporting)
- [Pptify GitHub](https://github.com/wordflowlab/pptify)
- [Playwright 文档](https://playwright.dev)

---

**版本**: v0.1.4  
**更新时间**: 2024-11-05

