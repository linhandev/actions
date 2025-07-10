#!/bin/bash

# Source common utilities
source "$(dirname "$0")/common.sh"
npx ts-node $GITHUB_WORKSPACE/workflow_utils/update_signing_config.ts ./NativeProject/build-profile.json5 com.example.fabric "$SIGNING_CONFIG_MAP"

cd fabric-component-sample-package
npm pack
cd -

cd ReactProject
install_dependencies
cd -

cd NativeProject
ohpm i
cd -

cd ReactProject
npm run dev
cd -

cd NativeProject
hvigorw --sync -p product=default --analyze=false --parallel --incremental --no-daemon --debug
hvigorw --mode module -p module=entry@default -p product=default -p buildMode=debug -p requiredDeviceType=phone assembleHap --analyze=false --parallel --incremental --no-daemon --debug
cd -

echo "build succeed"
