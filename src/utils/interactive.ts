import inquirer from 'inquirer';
import chalk from 'chalk';
import { AIConfig } from '../types/index.js';

// 检查是否为交互式终端
export function isInteractive(): boolean {
  return process.stdin.isTTY === true;
}

// 显示项目横幅
export function displayProjectBanner(): void {
  console.log('');
  console.log(chalk.bold.cyan('╔════════════════════════════════════════════════╗'));
  console.log(chalk.bold.cyan('║                                                ║'));
  console.log(chalk.bold.cyan('║           ') + chalk.bold.white('Pptify - AI 演示创作工具') + chalk.bold.cyan('        ║'));
  console.log(chalk.bold.cyan('║                                                ║'));
  console.log(chalk.bold.cyan('║      ') + chalk.dim('基于 Slidev 的智能演示生成系统') + chalk.bold.cyan('         ║'));
  console.log(chalk.bold.cyan('║                                                ║'));
  console.log(chalk.bold.cyan('╚════════════════════════════════════════════════╝'));
  console.log('');
}

// 显示成功消息
export function displaySuccess(message: string): void {
  console.log(chalk.green('✓ ') + message);
}

// 显示错误消息
export function displayError(message: string): void {
  console.log(chalk.red('✗ ') + message);
}

// 显示信息消息
export function displayInfo(message: string): void {
  console.log(chalk.blue('ℹ ') + message);
}

// 显示步骤
export function displayStep(current: number, total: number, title: string): void {
  console.log(chalk.bold(`[${current}/${total}] `) + chalk.cyan(title));
}

// 选择 AI 助手
export async function selectAIAssistant(configs: AIConfig[]): Promise<string> {
  const choices = configs.map(config => ({
    name: `${config.displayName.padEnd(25)} (${config.name})`,
    value: config.name,
    short: config.displayName
  }));

  const { ai } = await inquirer.prompt([
    {
      type: 'list',
      name: 'ai',
      message: '选择你使用的 AI 编程助手:',
      choices,
      default: 'claude'
    }
  ]);

  return ai;
}

// 选择演示类型
export async function selectPresentationType(): Promise<string> {
  const { type } = await inquirer.prompt([
    {
      type: 'list',
      name: 'type',
      message: '选择演示类型:',
      choices: [
        { name: '📊 技术分享 - 技术会议、内部分享、培训', value: '技术分享' },
        { name: '💼 商业路演 - 融资路演、产品发布、商业提案', value: '商业路演' },
        { name: '📚 教程培训 - 课程教学、工作坊、在线教程', value: '教程培训' },
        { name: '🎓 学术报告 - 论文答辩、学术会议、研究展示', value: '学术报告' }
      ],
      default: '技术分享'
    }
  ]);

  return type;
}

// 选择脚本类型
export async function selectBashScriptType(): Promise<'sh' | 'ps'> {
  const { scriptType } = await inquirer.prompt([
    {
      type: 'list',
      name: 'scriptType',
      message: '选择脚本类型:',
      choices: [
        { 
          name: '🐚 POSIX Shell (.sh) - macOS/Linux', 
          value: 'sh' 
        },
        { 
          name: '💠 PowerShell (.ps1) - Windows', 
          value: 'ps' 
        }
      ],
      default: 'sh'
    }
  ]);

  return scriptType;
}

