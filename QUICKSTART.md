# Pptify 快速开始指南

## 5分钟快速体验

### 1. 安装 Pptify

```bash
npm install -g ai-pptify
```

### 2. 创建你的第一个演示

```bash
# 创建项目
pptify init "我的第一个技术分享"

# 进入项目目录
cd "我的第一个技术分享"

# 安装依赖
npm install
```

### 3. 定义演示规格

```bash
pptify /spec
```

在 AI 助手中，按照提示选择：
- **类型**: A (技术分享)
- **配置**: A (技术会议演讲)
- **确认**: A (使用此配置)

### 4. 创建大纲

```bash
pptify /outline
```

选择创作模式：
- **推荐新手**: A (引导模式) - AI 会逐步引导你
- **快速开始**: B (快速模式) - AI 直接生成大纲

### 5. 生成幻灯片

```bash
pptify /slides
```

选择风格：
- A (技术风格) - 推荐

### 6. 预览演示

```bash
npm run dev
```

浏览器会自动打开 `http://localhost:3030`

### 7. 导出 PDF

```bash
npm run export
```

PDF 文件会保存在 `dist/` 目录中。

---

## 常见问题

### Q: 我可以在现有项目中使用吗？

A: 可以！使用 `--here` 参数：

```bash
cd my-existing-project
pptify init --here
```

### Q: 如何更换主题？

A: 编辑 `slides.md` 开头的 frontmatter：

```yaml
---
theme: bricks  # 更换为其他主题
---
```

可用主题：seriph, default, bricks, apple-basic 等

### Q: 如何添加代码高亮？

A: 使用代码块并指定语言：

````markdown
```typescript
function hello() {
  console.log('Hello World')
}
```
````

### Q: 幻灯片太多/太少怎么办？

A: 重新运行 `/spec` 并调整 `slides_count`，然后重新生成。

---

## 下一步

- 📖 阅读完整 [README](./README.md)
- 🎨 查看 [Slidev 文档](https://sli.dev)
- 💡 探索模板文件 `templates/slides/`
- 🚀 开始创作你的演示！

