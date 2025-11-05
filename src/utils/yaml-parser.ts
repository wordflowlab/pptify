import fs from 'fs-extra';
import yaml from 'js-yaml';
import { CommandMetadata } from '../types/index.js';

/**
 * 解析命令模板文件 (Markdown with YAML frontmatter)
 */
export async function parseCommandTemplate(
  templatePath: string
): Promise<{ metadata: CommandMetadata; content: string }> {
  const fileContent = await fs.readFile(templatePath, 'utf-8');
  
  // 提取 YAML frontmatter
  const frontmatterRegex = /^---\n([\s\S]*?)\n---\n([\s\S]*)$/;
  const match = fileContent.match(frontmatterRegex);
  
  if (!match) {
    return {
      metadata: { description: '', scripts: {} },
      content: fileContent
    };
  }
  
  const [, frontmatter, content] = match;
  const metadata = yaml.load(frontmatter) as CommandMetadata;
  
  return { metadata, content };
}

