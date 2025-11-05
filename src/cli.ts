#!/usr/bin/env node

import { Command } from '@commander-js/extra-typings';
import chalk from 'chalk';
import fs from 'fs-extra';
import ora from 'ora';
import path from 'path';
import { fileURLToPath } from 'url';
import { createRequire } from 'module';
import {
  displayProjectBanner,
  displaySuccess,
  displayError,
  displayInfo,
  displayStep,
  isInteractive,
  selectAIAssistant,
  selectPresentationType,
  selectBashScriptType
} from './utils/interactive.js';
import { executeBashScript } from './utils/bash-runner.js';
import { parseCommandTemplate } from './utils/yaml-parser.js';
import { AIConfig } from './types/index.js';

// 读取 package.json 版本号
const require = createRequire(import.meta.url);
const { version } = require('../package.json');

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// AI 平台配置 - 所有支持的13个平台
const AI_CONFIGS: AIConfig[] = [
  { name: 'claude', dir: '.claude', commandsDir: 'commands', displayName: 'Claude Code' },
  { name: 'cursor', dir: '.cursor', commandsDir: 'commands', displayName: 'Cursor' },
  { name: 'gemini', dir: '.gemini', commandsDir: 'commands', displayName: 'Gemini CLI' },
  { name: 'windsurf', dir: '.windsurf', commandsDir: 'workflows', displayName: 'Windsurf' },
  { name: 'roocode', dir: '.roo', commandsDir: 'commands', displayName: 'Roo Code' },
  { name: 'copilot', dir: '.github', commandsDir: 'prompts', displayName: 'GitHub Copilot' },
  { name: 'qwen', dir: '.qwen', commandsDir: 'commands', displayName: 'Qwen Code' },
  { name: 'opencode', dir: '.opencode', commandsDir: 'command', displayName: 'OpenCode' },
  { name: 'codex', dir: '.codex', commandsDir: 'prompts', displayName: 'Codex CLI' },
  { name: 'kilocode', dir: '.kilocode', commandsDir: 'workflows', displayName: 'Kilo Code' },
  { name: 'auggie', dir: '.augment', commandsDir: 'commands', displayName: 'Auggie CLI' },
  { name: 'codebuddy', dir: '.codebuddy', commandsDir: 'commands', displayName: 'CodeBuddy' },
  { name: 'q', dir: '.amazonq', commandsDir: 'prompts', displayName: 'Amazon Q Developer' }
];

const program = new Command();

// Display banner
displayProjectBanner();

program
  .name('pptify')
  .description(chalk.cyan('Pptify - AI 驱动的 Slidev 演示创作工具'))
  .version(version);

// /init - 初始化项目(支持13个AI助手)
program
  .command('init')
  .argument('[name]', '项目名称')
  .option('--here', '在当前目录初始化')
  .option('--ai <type>', '选择 AI 助手 (claude|cursor|gemini|windsurf|roocode|copilot|qwen|opencode|codex|kilocode|auggie|codebuddy|q)')
  .description('初始化 Pptify 项目（生成 AI 配置）')
  .action(async (name, options) => {
    // 交互式选择
    const shouldShowInteractive = isInteractive() && !options.ai;

    let selectedAI = 'claude';
    let selectedScriptType = 'sh';
    let selectedType = '技术分享';

    if (shouldShowInteractive) {
      // 显示欢迎横幅
      displayProjectBanner();

      // [1/3] 选择 AI 助手
      displayStep(1, 3, '选择 AI 助手');
      selectedAI = await selectAIAssistant(AI_CONFIGS);
      console.log('');

      // [2/3] 选择演示类型
      displayStep(2, 3, '选择演示类型');
      selectedType = await selectPresentationType();
      console.log('');

      // [3/3] 选择脚本类型
      displayStep(3, 3, '选择脚本类型');
      selectedScriptType = await selectBashScriptType();
      console.log('');
    } else if (options.ai) {
      selectedAI = options.ai;
    }

    const spinner = ora('正在初始化 Pptify 项目...').start();

    try {
      // 确定项目路径
      let projectPath: string;
      if (options.here) {
        projectPath = process.cwd();
        name = path.basename(projectPath);
      } else {
        if (!name) {
          spinner.fail('请提供项目名称或使用 --here 参数');
          process.exit(1);
        }
        projectPath = path.join(process.cwd(), name);
        if (await fs.pathExists(projectPath)) {
          spinner.fail(`项目目录 "${name}" 已存在`);
          process.exit(1);
        }
        await fs.ensureDir(projectPath);
      }

      // 获取选中的AI配置
      const aiConfig = AI_CONFIGS.find(c => c.name === selectedAI);
      if (!aiConfig) {
        spinner.fail(`不支持的AI助手: ${selectedAI}`);
        process.exit(1);
      }

      // 创建基础项目结构
      const dirs = [
        '.pptify',
        `${aiConfig.dir}/${aiConfig.commandsDir}`
      ];

      for (const dir of dirs) {
        await fs.ensureDir(path.join(projectPath, dir));
      }

      // 创建项目配置文件
      const config = {
        name: name,
        type: 'pptify-project',
        ai: selectedAI,
        scriptType: selectedScriptType,
        defaultType: selectedType,
        created: new Date().toISOString(),
        version: '0.1.0'
      };
      await fs.writeJson(path.join(projectPath, '.pptify', 'config.json'), config, { spaces: 2 });

      // 从npm包复制模板和脚本到项目
      const packageRoot = path.resolve(__dirname, '..');

      // 根据选择的脚本类型复制对应脚本
      const scriptsSubDir = selectedScriptType === 'ps' ? 'powershell' : 'bash';
      const scriptsSource = path.join(packageRoot, 'scripts', scriptsSubDir);
      const scriptsTarget = path.join(projectPath, 'scripts', scriptsSubDir);

      if (await fs.pathExists(scriptsSource)) {
        await fs.copy(scriptsSource, scriptsTarget);

        // 设置bash脚本执行权限
        if (selectedScriptType === 'sh') {
          const bashFiles = await fs.readdir(scriptsTarget);
          for (const file of bashFiles) {
            if (file.endsWith('.sh')) {
              const filePath = path.join(scriptsTarget, file);
              await fs.chmod(filePath, 0o755);
            }
          }
        }
      }

      // 复制templates到项目
      const templatesSource = path.join(packageRoot, 'templates');
      const templatesTarget = path.join(projectPath, 'templates');
      if (await fs.pathExists(templatesSource)) {
        await fs.copy(templatesSource, templatesTarget);
      }

      // 生成AI配置文件（直接复制模板文件）
      const commandFiles = await fs.readdir(path.join(packageRoot, 'templates', 'commands'));

      for (const file of commandFiles) {
        if (file.endsWith('.md')) {
          const sourcePath = path.join(packageRoot, 'templates', 'commands', file);
          const targetPath = path.join(projectPath, aiConfig.dir, aiConfig.commandsDir, file);
          await fs.copy(sourcePath, targetPath);
        }
      }

      // 创建 package.json（包含 Slidev）
      const projectPackageJson = {
        name: name.toLowerCase().replace(/\s+/g, '-'),
        version: '1.0.0',
        type: 'module',
        scripts: {
          dev: 'slidev',
          build: 'slidev build',
          export: 'slidev export',
          'export:pdf': 'slidev export',
          'export:pptx': 'slidev export --format pptx',
          'export:png': 'slidev export --format png'
        },
        dependencies: {
          '@slidev/cli': '^0.49.0',
          '@slidev/theme-default': '^latest'
        },
        devDependencies: {
          'playwright-chromium': '^1.40.0'
        }
      };
      await fs.writeJson(path.join(projectPath, 'package.json'), projectPackageJson, { spaces: 2 });

      // 创建README
      const readme = `# ${name}

使用 Pptify 创作的${selectedType}演示项目

## 配置

- **AI 助手**: ${aiConfig.displayName}
- **演示类型**: ${selectedType}
- **脚本类型**: ${selectedScriptType === 'sh' ? 'POSIX Shell (macOS/Linux)' : 'PowerShell (Windows)'}

## 创作流程

使用 Slash Commands 完成演示创作：

\`\`\`bash
/spec         # 1. 定义演示规格（类型、时长、受众）
/outline      # 2. 创建演示大纲
/content      # 3. 生成详细内容（可选）
/slides       # 4. 生成 Slidev 幻灯片
/theme        # 5. 选择和配置主题
/preview      # 6. 预览演示
/export       # 7. 导出 PDF/PPTX
\`\`\`

## 项目结构

- \`spec.json\` - 演示规格配置
- \`outline.md\` - 演示大纲
- \`content.md\` - 详细内容
- \`slides.md\` - Slidev 幻灯片
- \`scripts/${scriptsSubDir}/\` - ${selectedScriptType === 'sh' ? 'Bash' : 'PowerShell'}脚本
- \`templates/\` - AI提示词模板和 Slidev 模板
- \`${aiConfig.dir}/\` - ${aiConfig.displayName}配置

## 快速开始

\`\`\`bash
# 安装依赖
npm install

# 预览演示
npm run dev

# 导出 PDF
npm run export
\`\`\`

## 更多命令

\`\`\`bash
/polish       # 内容润色
/review       # 质量检查
/convert      # 转换现有文档
/save         # 保存项目
\`\`\`

## 文档

查看 [Pptify文档](https://github.com/wordflowlab/pptify)
查看 [Slidev文档](https://sli.dev)
`;

      await fs.writeFile(path.join(projectPath, 'README.md'), readme);

      spinner.succeed(`项目 "${name}" 初始化成功!`);

      console.log('');
      displayInfo('下一步:');
      if (!options.here) {
        console.log(`  • cd ${name}`);
        console.log(`  • npm install`);
      } else {
        console.log(`  • npm install`);
      }
      console.log(`  • 运行 /spec 定义演示规格`);
      console.log(`  • 运行 /outline 开始创建大纲`);

    } catch (error) {
      spinner.fail('初始化项目失败');
      console.error(error);
      process.exit(1);
    }
  });

// /spec - 定义演示规格
program
  .command('spec')
  .description('定义/更新演示规格')
  .argument('[project]', '项目名称(可选)')
  .action(async (project?: string) => {
    try {
      const args = project ? [project] : [];
      const result = await executeBashScript('spec', args);

      if (result.status === 'success') {
        displaySuccess(`项目: ${result.project_name}`);

        // Read and display command template
        const templatePath = 'templates/commands/spec.md';
        if (await fs.pathExists(templatePath)) {
          const { metadata, content } = await parseCommandTemplate(templatePath);
          console.log('\n' + chalk.dim('─'.repeat(50)));
          console.log(content);
          console.log(chalk.dim('─'.repeat(50)) + '\n');

          // Display script output context for AI
          console.log(chalk.dim('## 脚本输出信息\n'));
          console.log('```json');
          console.log(JSON.stringify(result, null, 2));
          console.log('```');
        }
      } else {
        displayError(result.message || '发生未知错误');
        process.exit(1);
      }
    } catch (error) {
      displayError(error instanceof Error ? error.message : String(error));
      process.exit(1);
    }
  });

// /outline - 创建大纲
program
  .command('outline')
  .description('创建演示大纲')
  .argument('[project]', '项目名称(可选)')
  .action(async (project?: string) => {
    try {
      const args = project ? [project] : [];
      const result = await executeBashScript('outline', args);

      if (result.status === 'success') {
        displaySuccess(`项目: ${result.project_name}`);

        const templatePath = 'templates/commands/outline.md';
        if (await fs.pathExists(templatePath)) {
          const { metadata, content } = await parseCommandTemplate(templatePath);
          console.log('\n' + chalk.dim('─'.repeat(50)));
          console.log(content);
          console.log(chalk.dim('─'.repeat(50)) + '\n');

          console.log(chalk.dim('## 脚本输出信息\n'));
          console.log('```json');
          console.log(JSON.stringify(result, null, 2));
          console.log('```');
        }
      } else {
        displayError(result.message || '发生未知错误');
        process.exit(1);
      }
    } catch (error) {
      displayError(error instanceof Error ? error.message : String(error));
      process.exit(1);
    }
  });

// /slides - 生成 Slidev 幻灯片
program
  .command('slides')
  .description('生成 Slidev 幻灯片')
  .option('--project <name>', '项目名称')
  .action(async (options) => {
    try {
      const args = options.project ? ['--project', options.project] : [];
      const result = await executeBashScript('slides', args);

      if (result.status === 'success') {
        displaySuccess(`项目: ${result.project_name}`);

        const templatePath = 'templates/commands/slides.md';
        if (await fs.pathExists(templatePath)) {
          const { metadata, content } = await parseCommandTemplate(templatePath);
          console.log('\n' + chalk.dim('─'.repeat(50)));
          console.log(content);
          console.log(chalk.dim('─'.repeat(50)) + '\n');

          console.log(chalk.dim('## 脚本输出信息\n'));
          console.log('```json');
          console.log(JSON.stringify(result, null, 2));
          console.log('```');
        }
      } else {
        displayError(result.message || '发生未知错误');
        process.exit(1);
      }
    } catch (error) {
      displayError(error instanceof Error ? error.message : String(error));
      process.exit(1);
    }
  });

// /preview - 预览演示
program
  .command('preview')
  .description('启动 Slidev 预览服务器')
  .action(async () => {
    try {
      const result = await executeBashScript('preview', []);
      if (result.status === 'success') {
        displaySuccess(result.message || '预览服务器已启动');
      } else {
        displayError(result.message || '启动失败');
        process.exit(1);
      }
    } catch (error) {
      displayError(error instanceof Error ? error.message : String(error));
      process.exit(1);
    }
  });

// /export - 导出演示
program
  .command('export')
  .description('导出演示文稿')
  .option('--pdf', '导出为 PDF（默认）')
  .option('--pptx', '导出为 PowerPoint (需要 playwright-chromium)')
  .option('--png', '导出为 PNG 图片')
  .option('--html', '导出为 HTML（构建 SPA）')
  .action(async (options) => {
    try {
      const args = [];
      if (options.pptx) {
        args.push('--pptx');
        displayInfo('💡 提示：PPTX 导出会将幻灯片转为图片，文本不可选择');
      } else if (options.png) {
        args.push('--png');
      } else if (options.html) {
        args.push('--html');
        displayInfo('💡 提示：HTML 导出将构建可托管的 SPA 应用');
      } else {
        args.push('--pdf');
      }

      const result = await executeBashScript('export', args);
      if (result.status === 'success') {
        displaySuccess(result.message || '导出成功');
        displayInfo(`📁 输出文件: ${result.output_file}`);
      } else {
        displayError(result.message || '导出失败');
        process.exit(1);
      }
    } catch (error) {
      displayError(error instanceof Error ? error.message : String(error));
      process.exit(1);
    }
  });

// Help command
program
  .command('help')
  .description('显示帮助信息')
  .action(() => {
    console.log(chalk.bold('\nPptify - AI 驱动的 Slidev 演示创作工具\n'));
    console.log(chalk.cyan('📋 项目管理:'));
    console.log('  pptify init <项目名>              创建新项目');
    console.log('  pptify save [项目]                保存项目');
    console.log('');
    console.log(chalk.cyan('✨ 创作流程:'));
    console.log('  pptify spec [项目]                定义演示规格');
    console.log('  pptify outline [项目]             创建大纲');
    console.log('  pptify content [项目]             生成详细内容');
    console.log('  pptify slides                     生成 Slidev 幻灯片');
    console.log('');
    console.log(chalk.cyan('🎨 增强功能:'));
    console.log('  pptify theme                      选择/配置主题');
    console.log('  pptify polish                     内容润色');
    console.log('  pptify convert                    转换现有文档');
    console.log('');
    console.log(chalk.cyan('👀 预览导出:'));
    console.log('  pptify preview                    预览演示');
    console.log('  pptify export                     导出 PDF（默认）');
    console.log('  pptify export --pptx              导出 PowerPoint');
    console.log('  pptify export --png               导出 PNG 图片');
    console.log('  pptify export --html              导出 HTML（SPA）');
    console.log('');
    console.log(chalk.cyan('📖 查看文档:'));
    console.log('  README.md - 快速开始指南');
    console.log('  https://sli.dev - Slidev 官方文档');
    console.log('');
  });

// Parse arguments
program.parse();

