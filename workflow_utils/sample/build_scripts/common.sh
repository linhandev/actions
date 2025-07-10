#!/bin/bash

install_dependencies() {
    jq --arg harmony_path "$HARMONY_PATH" '.dependencies["@react-native-oh/react-native-harmony"] = $harmony_path' package.json >package.json.tmp && mv package.json.tmp package.json

    if jq -e '.devDependencies["@react-native-oh/react-native-harmony-cli"]' package.json >/dev/null; then
        jq --arg cli_path "$CLI_PATH" '.devDependencies["@react-native-oh/react-native-harmony-cli"] = $cli_path' package.json >package.json.tmp && mv package.json.tmp package.json
    fi
    cat package.json
    npm i
}
