import * as fs from 'fs';
import * as path from 'path';

const argPath = process.argv[2];
const filePath = argPath
  ? path.resolve(process.cwd(), argPath)
  : path.resolve(__dirname, 'signing_configs.json');
const content = fs.readFileSync(filePath, 'utf8');
const json = JSON.parse(content);
console.log(JSON.stringify(json));
