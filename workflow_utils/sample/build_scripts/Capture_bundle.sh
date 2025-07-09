set -ex

cd ReactProject
npm i ${HARMONY_PATH} --save-dev ${CLI_PATH}
cat package.json
npm run dev
cd -

npm install @tsconfig/recommended json5
npx ts-node $GITHUB_WORKSPACE/workflow_utils/update_signing_config.ts ../NativeProject/build-profile.json5 com.example.capturebundle "$SIGNING_CONFIG_MAP"

cd NativeProject
ohpm i
hvigorw --sync -p product=default --analyze=false --parallel --incremental --no-daemon --debug
hvigorw --mode module -p module=entry@default -p product=default -p buildMode=debug -p requiredDeviceType=phone assembleHap --analyze=false --parallel --incremental --no-daemon --debug
cd -

echo "build succeed"
