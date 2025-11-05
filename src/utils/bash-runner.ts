import { spawn } from 'child_process';
import path from 'path';
import fs from 'fs-extra';
import { ScriptOutput } from '../types/index.js';

/**
 * 执行 Bash 脚本并返回 JSON 结果
 */
export async function executeBashScript(
  scriptName: string,
  args: string[] = []
): Promise<ScriptOutput> {
  return new Promise((resolve, reject) => {
    // 查找项目根目录的 scripts
    const projectRoot = findProjectRoot();
    
    if (!projectRoot) {
      reject(new Error('未找到项目根目录，请在 pptify 项目中运行此命令'));
      return;
    }

    // 检查配置文件以确定脚本类型
    const configPath = path.join(projectRoot, '.pptify', 'config.json');
    let scriptType = 'bash';
    let scriptExt = 'sh';

    if (fs.existsSync(configPath)) {
      try {
        const config = fs.readJsonSync(configPath);
        if (config.scriptType === 'ps') {
          scriptType = 'powershell';
          scriptExt = 'ps1';
        }
      } catch (error) {
        // 使用默认值
      }
    }

    const scriptPath = path.join(
      projectRoot,
      'scripts',
      scriptType,
      `${scriptName}.${scriptExt}`
    );

    if (!fs.existsSync(scriptPath)) {
      reject(new Error(`脚本不存在: ${scriptPath}`));
      return;
    }

    const shell = scriptExt === 'sh' ? 'bash' : 'powershell';
    const childProcess = spawn(shell, [scriptPath, ...args], {
      cwd: projectRoot,
      env: { ...process.env, PROJECT_ROOT: projectRoot }
    });

    let stdout = '';
    let stderr = '';

    childProcess.stdout.on('data', (data: Buffer) => {
      stdout += data.toString();
    });

    childProcess.stderr.on('data', (data: Buffer) => {
      stderr += data.toString();
    });

    childProcess.on('close', (code: number | null) => {
      if (code !== 0) {
        reject(new Error(`脚本执行失败 (退出码: ${code})\n${stderr}`));
        return;
      }

      try {
        // 尝试解析 JSON 输出
        const result = JSON.parse(stdout.trim());
        resolve(result);
      } catch (error) {
        reject(new Error(`无法解析脚本输出为 JSON:\n${stdout}`));
      }
    });

    childProcess.on('error', (error: Error) => {
      reject(new Error(`启动脚本失败: ${error.message}`));
    });
  });
}

/**
 * 查找项目根目录（包含 .pptify 目录）
 */
function findProjectRoot(): string | null {
  let currentDir = process.cwd();
  
  // 向上查找，最多 10 层
  for (let i = 0; i < 10; i++) {
    const pptifyDir = path.join(currentDir, '.pptify');
    if (fs.existsSync(pptifyDir)) {
      return currentDir;
    }
    
    const parentDir = path.dirname(currentDir);
    if (parentDir === currentDir) {
      break; // 已到达根目录
    }
    currentDir = parentDir;
  }
  
  return null;
}

