// AI 配置接口
export interface AIConfig {
  name: string;
  dir: string;
  commandsDir: string;
  displayName: string;
}

// 项目配置接口
export interface ProjectConfig {
  name: string;
  type: 'pptify-project';
  ai: string;
  scriptType: 'sh' | 'ps';
  defaultType: string;
  created: string;
  version: string;
}

// 演示规格接口
export interface PresentationSpec {
  project_name: string;
  type: string;
  duration: string;
  slides_count: number;
  topic: string;
  audience: {
    level: string;
    size: string;
  };
  target_platform: string[];
  style: string;
  created_at: string;
  updated_at: string;
}

// 命令模板元数据
export interface CommandMetadata {
  description: string;
  scripts: {
    sh?: string;
    ps1?: string;
  };
}

// Bash 脚本输出接口
export interface ScriptOutput {
  status: 'success' | 'error' | 'info';
  action?: string;
  project_name?: string;
  project_path?: string;
  message?: string;
  [key: string]: any;
}

