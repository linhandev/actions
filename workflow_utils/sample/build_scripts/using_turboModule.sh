npx ts-node $GITHUB_WORKSPACE/workflow_utils/update_signing_config.ts ./SampleApp/build-profile.json5 com.example.turbomodule "$SIGNING_CONFIG_MAP"

cd SampleProject/MainProject
update_dependencies
npm i
npm run dev
cd -

cd SampleApp
ohpm i
hvigorw --sync -p product=default --analyze=false --parallel --incremental --no-daemon --debug
hvigorw --mode module -p module=entry@default -p product=default -p buildMode=debug -p requiredDeviceType=phone assembleHap --analyze=false --parallel --incremental --no-daemon --debug
cd -

echo "build succeed"
