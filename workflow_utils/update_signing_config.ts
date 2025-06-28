import * as fs from 'fs';
import * as path from 'path';
import * as JSON5 from 'json5';

const USAGE =
  "Usage: node update_signing_config.js <build-profile.json5> <appName> <signingConfigMap>";

// arguments
const filePathArg = process.argv[2];
const appName = process.argv[3];
const signingConfigMap = process.argv[4];

if (!filePathArg || !appName || !signingConfigMap) {
  console.error(USAGE);
  process.exit(1);
}
const filePath = path.resolve(process.cwd(), filePathArg);

let configMap: Record<string, any>;
try {
  configMap = JSON.parse(signingConfigMap);
} catch (e) {
  console.error("signingConfigMap is not valid JSON:", e);
  process.exit(1);
}

if (!(appName in configMap)) {
  console.error(
    `No signing config found for app "${appName}" in signingConfigMap.`
  );
  process.exit(1);
}

// process build-profile
const fileContent = fs.readFileSync(filePath, "utf8");
const data = JSON5.parse(fileContent) as any;

data.app.signingConfigs = [configMap[appName]];

// Write back to the file (preserving JSON5 format)
fs.writeFileSync(filePath, JSON5.stringify(data, null, 2), 'utf8');

console.log(`Updated signingConfig for "${appName}" in`, filePath);