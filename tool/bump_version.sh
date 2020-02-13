#!/bin/bash -ex
ROOT="$(git rev-parse --show-toplevel)"

if [ $# -ne 1 ]; then
  echo 'Error: Missing argument' 1>&2
  echo "Usage: ${0} NEW_VERSION" 1>&2
  exit 1
fi
NEW_VERSION=$1

# pubspec.yaml
PUBSPEC="$ROOT/pubspec.yaml"
NEW_VERSION_PUBSPEC="version: $NEW_VERSION"
sed -i '' -e "s/version: .*/$NEW_VERSION_PUBSPEC/g" $PUBSPEC

# podspec
PODSPEC="$ROOT/ios/payjp_flutter.podspec"
NEW_VERSION_PODSPEC="s.version          = '$NEW_VERSION'"
sed -i '' -e "s/s.version.*/$NEW_VERSION_PODSPEC/g" $PODSPEC

# ios constants
IOS_CONST="$ROOT/ios/Classes/PayjpPluginConstant.swift"
NEW_VERSION_IOS_CONST="static let PluginVersion: String = \"$NEW_VERSION\""
sed -i '' -e "s/static let PluginVersion: String =.*/$NEW_VERSION_IOS_CONST/g" $IOS_CONST

# gradle.properties
GRADLEP="$ROOT/android/gradle.properties"
NEW_VERSION_GRADLEP="VERSION_NAME=$NEW_VERSION"
sed -i '' -e "s/VERSION_NAME=.*/$NEW_VERSION_GRADLEP/g" $GRADLEP

exit $?
