# Flutter Plugin for PAY.JP SDK

[![pub package](https://img.shields.io/pub/v/payjp_flutter.svg)](https://pub.dartlang.org/packages/payjp_flutter)
[![Build Status](https://travis-ci.org/payjp/payjp-flutter-plugin.svg?branch=master)](https://travis-ci.org/payjp/payjp-flutter-plugin)

A Flutter plugin for PAY.JP Mobile SDK.

オンライン決済サービス「[PAY.JP](https://pay.jp/)」をFlutterアプリケーションに組み込むためのプラグインです。
このプラグインは以下の機能を提供します。

- クレジットカード決済のためのカードフォーム
- Apple Payアプリ内決済（iOSのみ）

詳細は[公式オンラインドキュメント](https://pay.jp/docs/mobileapp-flutter)を確認ください。

## Compatible Platforms

|Platform|CardForm          |ApplePay          |
|--------|------------------|------------------|
|iOS     |:white_check_mark:|:white_check_mark:|
|Android |:white_check_mark:|                  |
|Web     |                  |                  |

## License

Flutter Plugin for PAY.JP SDK is available under the MIT license. See the LICENSE file for more info.

## Development

### Generate models

See generator/README.md.

### Bump up version

```bash
tool/bump_version.sh [NEW_VERSION]
```
