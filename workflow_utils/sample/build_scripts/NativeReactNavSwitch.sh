npx ts-node $GITHUB_WORKSPACE/workflow_utils/update_signing_config.ts ./NavigationApp/build-profile.json5 com.example.navigationapp "$SIGNING_CONFIG_MAP"

cd NavigationProject/MainProject
update_dependencies
npm run setup
npm run dev
cd -

cd NavigationApp
ohpm i
hvigorw --sync -p product=default --analyze=false --parallel --incremental --no-daemon --debug
hvigorw --mode module -p module=entry@default -p product=default -p buildMode=debug -p requiredDeviceType=phone assembleHap --analyze=false --parallel --incremental --no-daemon --debug
cd -

echo "build succeed"
