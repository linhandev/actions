cd ReactProject
npm i ${HARMONY_PATH}
npm i
npm run dev
cd -

cd NativeProject
ohpm i
hvigorw --sync -p product=default --analyze=false --parallel --incremental --no-daemon --debug
hvigorw --mode module -p module=entry@default -p product=default -p buildMode=debug -p requiredDeviceType=phone assembleHap --analyze=false --parallel --incremental --no-daemon --debug
echo "build succeed"
