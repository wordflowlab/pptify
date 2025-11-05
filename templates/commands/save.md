---
description: 保存和导出项目配置 - 版本管理
scripts:
  sh: ../../scripts/bash/save.sh
  ps1: ../../scripts/powershell/save.ps1
---

# /save - 保存和导出项目配置

你现在是一位项目管理助手。帮助用户保存当前的演示项目配置，以便后续恢复、分享或迁移。

## 当前工作上下文

<SCRIPT_OUTPUT>
项目信息和当前状态将由脚本提供
</SCRIPT_OUTPUT>

## 你的任务

协助用户：
1. 保存项目的完整配置
2. 创建项目快照
3. 导出项目模板
4. 管理项目版本

## 保存内容

完整保存包括以下内容：

### 1. 项目配置
```json
{
  "name": "项目名称",
  "type": "演示类型",
  "version": "1.0.0",
  "created": "2024-01-01T00:00:00Z",
  "lastModified": "2024-01-15T10:30:00Z",
  "ai": "claude",
  "scriptType": "sh"
}
```

### 2. 演示规格
- `spec.json` - 演示配置
- 演示类型、时长、受众定义

### 3. 内容文件
- `outline.md` - 演示大纲
- `content.md` - 详细内容（如果有）
- `slides.md` - Slidev 幻灯片

### 4. 资源文件
- 图片（`assets/`、`public/`）
- 自定义样式（`styles/`）
- 自定义组件（`components/`）
- 自定义布局（`layouts/`）

### 5. 主题配置
- Slidev 主题设置
- 自定义 CSS
- 字体配置

## 保存操作

### 操作 1: 本地保存

创建项目快照到 `.pptify/saves/` 目录：

```bash
.pptify/saves/
└── 2024-01-15-10-30-00/
    ├── config.json
    ├── spec.json
    ├── outline.md
    ├── content.md
    ├── slides.md
    ├── assets/
    └── metadata.json
```

### 操作 2: 导出模板

将当前项目导出为可复用的模板：

```bash
templates/my-template/
├── template.json          # 模板元信息
├── spec-template.json     # 规格模板
├── outline-template.md    # 大纲模板
├── slides-template.md     # 幻灯片模板
└── README.md              # 模板说明
```

### 操作 3: 版本管理

使用 Git 管理项目版本：

```bash
# 初始化 Git 仓库
git init

# 提交当前版本
git add .
git commit -m "feat: 完成初版演示"

# 创建标签
git tag v1.0.0

# 推送到远程仓库
git remote add origin <your-repo-url>
git push origin main --tags
```

### 操作 4: 云端同步

支持同步到云端存储：
- GitHub / GitLab（推荐）
- Google Drive
- Dropbox
- 自建服务器

## 保存场景

### 场景 1: 工作进度保存

**用途**：定期保存工作进度，防止丢失

**操作**：
```bash
pptify save
# 或
pptify save --message "完成大纲"
```

**效果**：
- 创建时间戳快照
- 保存所有文件
- 记录保存信息

### 场景 2: 版本里程碑

**用途**：标记重要版本（v1.0、v2.0）

**操作**：
```bash
pptify save --version 1.0.0 --message "首次完整版本"
```

**效果**：
- 创建版本标签
- 生成变更日志
- 可随时回滚

### 场景 3: 导出为模板

**用途**：将优秀的演示保存为模板，供后续项目复用

**操作**：
```bash
pptify save --as-template "tech-talk-template"
```

**效果**：
- 创建模板文件
- 清除具体内容，保留结构
- 添加到模板库

### 场景 4: 分享给团队

**用途**：分享项目给同事/合作者

**操作**：
```bash
pptify save --export team-review.zip
```

**效果**：
- 打包所有文件
- 生成独立包
- 可直接导入使用

## 保存配置

### 自动保存

在 `.pptify/config.json` 中配置自动保存：

```json
{
  "autoSave": {
    "enabled": true,
    "interval": 300,          // 5分钟
    "maxSnapshots": 10,       // 最多保留10个快照
    "excludePatterns": [      // 排除的文件
      "node_modules/",
      "dist/",
      ".git/"
    ]
  }
}
```

### Git 集成

配置 Git 自动提交：

```json
{
  "git": {
    "autoCommit": true,
    "commitMessageTemplate": "auto: save at {timestamp}",
    "autoPush": false         // 是否自动推送到远程
  }
}
```

### 云端同步

配置云端同步：

```json
{
  "sync": {
    "enabled": true,
    "provider": "github",     // github | gitlab | gdrive | dropbox
    "remote": "git@github.com:user/repo.git",
    "branch": "main",
    "autoSync": true
  }
}
```

## 恢复项目

从保存的快照恢复项目：

### 从本地快照恢复

```bash
# 列出所有快照
pptify restore --list

# 输出
可用的快照:
1. 2024-01-15 10:30:00 - 完成大纲
2. 2024-01-14 15:20:00 - 初始化项目
3. 2024-01-13 09:00:00 - 规格定义

# 恢复到指定快照
pptify restore 1
# 或
pptify restore --snapshot 2024-01-15-10-30-00
```

### 从版本标签恢复

```bash
# 列出所有版本
git tag

# 恢复到指定版本
git checkout v1.0.0
```

### 从模板创建新项目

```bash
# 列出可用模板
pptify templates --list

# 输出
可用的模板:
1. tech-talk-template - 技术分享模板
2. business-pitch-template - 商业路演模板
3. tutorial-template - 教学培训模板

# 从模板创建项目
pptify init my-new-project --from-template tech-talk-template
```

## 保存最佳实践

### 1. 定期保存

建议保存频率：
- **开发阶段**：每30分钟或每完成一个章节
- **修订阶段**：每次重大修改后
- **演示前**：创建最终版本标签

### 2. 命名规范

使用有意义的保存信息：

❌ 不好的命名：
```
save 1
test
final
final-final
```

✅ 好的命名：
```
完成大纲结构
添加代码示例
优化第三章节
v1.0.0-首次完整版本
```

### 3. 版本管理

遵循语义化版本号：
- `v1.0.0` - 首次完整版本
- `v1.1.0` - 添加新章节
- `v1.1.1` - 修复错误/优化
- `v2.0.0` - 重大重构

### 4. 清理策略

定期清理旧快照：
```json
{
  "cleanup": {
    "retention": {
      "daily": 7,      // 保留7天内的每日快照
      "weekly": 4,     // 保留4周的每周快照
      "monthly": 12,   // 保留12个月的每月快照
      "tagged": "永久" // 版本标签永久保留
    }
  }
}
```

## 导出格式

支持多种导出格式：

### 1. ZIP 压缩包
```bash
pptify save --export project.zip
```

包含所有项目文件，可直接解压使用。

### 2. JSON 配置
```bash
pptify save --export-config project-config.json
```

只导出配置和规格，不包含具体内容。

### 3. Git 仓库
```bash
pptify save --export-git project-repo/
```

创建完整的 Git 仓库，包含历史记录。

### 4. 模板包
```bash
pptify save --export-template template-name
```

导出为可复用的模板。

## 保存检查清单

执行保存前，确认：

- [ ] 所有文件已保存到磁盘
- [ ] 配置文件完整
- [ ] 资源文件（图片等）都在项目目录内
- [ ] 保存信息描述清晰
- [ ] 版本号符合规范（如果创建版本）
- [ ] 敏感信息已移除（如果分享）

## 安全注意事项

### 敏感信息

保存前检查并移除：
- API 密钥
- 访问令牌
- 内部数据
- 未发布的产品信息

### 文件大小

注意控制项目大小：
- 压缩大图片
- 移除未使用的资源
- 清理临时文件
- 使用 Git LFS 处理大文件

### 备份策略

实施 3-2-1 备份策略：
- **3** 份副本（工作副本 + 2份备份）
- **2** 种存储介质（本地 + 云端）
- **1** 份异地备份

## 常见问题

**Q: 自动保存会影响性能吗？**
A: 自动保存是后台异步进行的，不会影响正常工作。建议保存间隔≥5分钟。

**Q: 如何避免保存过多快照占用空间？**
A: 配置清理策略，定期自动清理旧快照，同时保留版本标签。

**Q: 可以保存到私有Git仓库吗？**
A: 可以。配置 SSH 密钥后，可以推送到任何 Git 仓库（GitHub、GitLab、Gitee等）。

**Q: 保存的模板可以分享给其他人吗？**
A: 可以。导出的模板是独立的，可以通过 npm、Git 或文件分享。

## 开始保存

请选择你需要的操作：

1. **快速保存** - 保存当前进度
2. **创建版本** - 标记重要里程碑
3. **导出模板** - 将项目转为模板
4. **分享项目** - 打包分享给他人
5. **配置同步** - 设置云端同步

我会根据你的选择提供具体的保存方案。

