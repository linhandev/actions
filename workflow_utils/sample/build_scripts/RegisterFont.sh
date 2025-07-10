npx ts-node $GITHUB_WORKSPACE/workflow_utils/update_signing_config.ts ./RegisterFontNativeProject/build-profile.json5 com.example.registerfont "$SIGNING_CONFIG_MAP"

cd RegisterFontRnProject
update_dependencies
npm i
npm run dev
cd -

cd RegisterFontNativeProject
ohpm i
hvigorw --sync -p product=default --analyze=false --parallel --incremental --no-daemon --debug
hvigorw --mode module -p module=entry@default -p product=default -p buildMode=debug -p requiredDeviceType=phone assembleHap --analyze=false --parallel --incremental --no-daemon --debug
cd -

echo "build succeed"
