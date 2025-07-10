#!/bin/bash
npx ts-node $GITHUB_WORKSPACE/workflow_utils/update_signing_config.ts ./NativeProject/build-profile.json5 com.example.capturebundle "$SIGNING_CONFIG_MAP"

cd ReactProject
install_dependencies
npm run dev
cd -

cd NativeProject
ohpm i
hvigorw --sync -p product=default --analyze=false --parallel --incremental --no-daemon --debug
hvigorw --mode module -p module=entry@default -p product=default -p buildMode=debug -p requiredDeviceType=phone assembleHap --analyze=false --parallel --incremental --no-daemon --debug
cd -

echo "build succeed"
