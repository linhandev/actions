import * as fs from 'fs';
import * as path from 'path';
import * as JSON5 from 'json5';

const USAGE = 'Usage: node update_signing_config.js <build-profile.json5> <appName>';

// Get file path from first command line argument
const filePathArg = process.argv[2];
if (!filePathArg) {
  console.error(USAGE);
  process.exit(1);
}
const filePath = path.resolve(process.cwd(), filePathArg);

// Get app name from second command line argument
const appName = process.argv[3];
if (!appName) {
  console.error(USAGE);
  process.exit(1);
}

// Read environment variable (should be a JSON string)
const envVar = process.env.SIGNING_CONFIG_MAP;
if (!envVar) {
  console.error('SIGNING_CONFIG_MAP environment variable not set.');
  process.exit(1);
}

let configMap: Record<string, string>;
try {
  configMap = JSON.parse(envVar);
} catch (e) {
  console.error('SIGNING_CONFIG_MAP is not valid JSON:', e);
  process.exit(1);
}

// Read and parse the JSON5 file
const fileContent = fs.readFileSync(filePath, 'utf8');
const data = JSON5.parse(fileContent) as any;

// Update signingConfig only for the specified app
if (data.app && Array.isArray(data.app.products)) {
  data.app.products.forEach((product: any) => {
    if (product.name === appName && configMap[appName]) {
      product.signingConfig = configMap[appName];
    }
  });
}

// Write back to the file (preserving JSON5 format)
fs.writeFileSync(filePath, JSON5.stringify(data, null, 2), 'utf8');

console.log(`Updated signingConfig for "${appName}" in`, filePath);