#!/bin/bash -e
# sdkconfig.json の iOS SDK バージョンと Package.swift の payjp-ios バージョンが一致するか検証する
ROOT="$(git rev-parse --show-toplevel)"

SDKCONFIG_VERSION=$(jq -r .ios "$ROOT/sdkconfig.json")
PACKAGE_VERSION=$(grep -E 'payjp-ios\.git' "$ROOT/ios/payjp_flutter/Package.swift" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')

if [ "$SDKCONFIG_VERSION" != "$PACKAGE_VERSION" ]; then
  echo "Error: iOS SDK version mismatch (sdkconfig.json: $SDKCONFIG_VERSION, Package.swift: $PACKAGE_VERSION)" 1>&2
  exit 1
fi
echo "iOS SDK version: $SDKCONFIG_VERSION"
