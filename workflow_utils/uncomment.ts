import * as fs from 'fs';
import * as path from 'path';

// Usage: ts-node uncomment.ts <filePath> <lineOfCode>
const [,, filePathArg, ...lineOfCodeArr] = process.argv;
if (!filePathArg || lineOfCodeArr.length === 0) {
  console.error('Usage: ts-node uncomment.ts <filePath> <lineOfCode>');
  process.exit(1);
}
const filePath = path.resolve(process.cwd(), filePathArg);
const lineOfCode = lineOfCodeArr.join(' ');

const fileContent = fs.readFileSync(filePath, 'utf8');
const lines = fileContent.split(/\r?\n/);
let found = false;

const uncommentedLines = lines.map(line => {
  const trimmed = line.trimStart();
  if (!found && trimmed.startsWith('//') && trimmed.slice(2).trimStart() === lineOfCode.trim()) {
    found = true;
    // Remove the '//' and preserve indentation
    return line.replace('//', '');
  }
  return line;
});

if (!found) {
  console.error('Line not found or already uncommented.');
  process.exit(1);
}

fs.writeFileSync(filePath, uncommentedLines.join('\n'), 'utf8');
console.log('Uncommented line:', lineOfCode);
