# Slidev 语法常见错误和解决方案

## 🐛 你遇到的错误

### 错误信息
```
[plugin:vite:vue] Extraneous children found when component already has 
explicitly named default slot. These children will be ignored.
```

### ❌ 错误原因

你的 slides.md 中使用了类似这样的代码：

```markdown
---
layout: default
---

<h1>实际案例演示</h1>
<template v-slot:default>
<h2>真实项目案例</h2>
</template>
```

**问题**：不要在 Slidev 中使用 `<template v-slot:default>`！

### ✅ 正确做法

**方式 1：使用 Markdown**（推荐）
```markdown
---
layout: default
---

# 实际案例演示

## 真实项目案例

内容正文...
```

**方式 2：使用 Slidev 插槽语法**
```markdown
---
layout: two-cols
---

# 左侧内容

这是左侧的内容

::right::

# 右侧内容

这是右侧的内容
```

**方式 3：纯 HTML**
```markdown
---
layout: center
---

<div class="text-center">
  <h1>实际案例演示</h1>
  <h2>真实项目案例</h2>
  <p>详细内容...</p>
</div>
```

## 📋 快速修复步骤

1. 打开你的 `slides.md` 文件
2. 找到所有 `<template v-slot:` 的地方
3. 删除 `<template>` 标签
4. 改用 Markdown 或 `::slot-name::` 语法

## 🎯 Slidev 正确语法示例

### 双栏布局
```markdown
---
layout: two-cols
---

# 左栏标题

左侧内容

::right::

# 右栏标题

右侧内容
```

### 图片+文字
```markdown
---
layout: image-right
image: /path/to/image.jpg
---

# 标题

文字内容在左侧
图片自动在右侧
```

### 动画效果
```markdown
# 标题

<v-clicks>

- 第一个要点
- 第二个要点
- 第三个要点

</v-clicks>
```

### 代码高亮
````markdown
# 代码示例

```javascript {2,4}
function hello() {
  console.log('Hello!');  // 这行会高亮
  const name = 'World';
  return name;            // 这行也会高亮
}
```
````

## 🚫 不要做的事情

1. ❌ 不要使用 `<template v-slot:default>`
2. ❌ 不要混用 HTML 和 Markdown
3. ❌ 不要在 HTML 标签内使用 Markdown

## ✅ 应该做的事情

1. ✅ 优先使用 Markdown 语法
2. ✅ 使用 `::slot-name::` 定义插槽
3. ✅ 使用 `<v-click>` 和 `<v-clicks>` 实现动画

## 📚 更多资源

- [Slidev 官方文档](https://sli.dev)
- [Slidev 布局](https://sli.dev/builtin/layouts.html)
- [Slidev 动画](https://sli.dev/guide/animations.html)

---

**版本**: v0.1.3  
**更新时间**: 2024-11-05
