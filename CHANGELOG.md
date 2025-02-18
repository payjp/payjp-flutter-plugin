## 0.7.4

- Remove deprecated Registrar usage in Android embedding v1 classes. #87

## 0.7.3

- Update payjp-ios to [2.1.5](https://github.com/payjp/payjp-ios/releases/tag/2.1.5).

## 0.7.2

- Update payjp-ios to [2.1.4](https://github.com/payjp/payjp-ios/releases/tag/2.1.4).

## 0.7.1

- Update payjp-ios to [2.1.3](https://github.com/payjp/payjp-ios/releases/tag/2.1.3).
- Update payjp-android to [2.1.1](https://github.com/payjp/payjp-android/releases/tag/2.1.1).

## 0.7.0

- Update payjp-ios to [2.1.0](https://github.com/payjp/payjp-ios/releases/tag/2.1.0).
- Update payjp-android to [2.1.0](https://github.com/payjp/payjp-android/releases/tag/2.1.0).
- Add `useThreeDSecure` to `Payjp.startCardForm`. #82

## 0.6.0

- Add `extraAttributes` to `Payjp.startCardForm`. #80
- Update payjp-ios to [2.0.0](https://github.com/payjp/payjp-ios/releases/tag/2.0.0).
- Update payjp-android to [2.0.0](https://github.com/payjp/payjp-android/releases/tag/2.0.0).
- Update Dart sdk constraints to `">=3.0.0 <4.0.0"` from `>=2.12.0 <3.0.0`.
- Add properties named `email` and `phone` to `Card` class.
- Remove an implicit dependency on card.io in iOS.
  - card.io cannot be built successfully on the arm64 iOS simulator.
  - If you want to add the scan feature, you need to add the dependency on the app side.
  - In Android, the dependency on card.io is still included.

## 0.5.0

- Fix unexpected response to another activity result on Android. #74
- Update payjp-ios to [1.6.2](https://github.com/payjp/payjp-ios/releases/tag/1.6.2).

## 0.4.1

- Fix hanging in creating token on Android.
  - Update payjp-android to [1.6.0](https://github.com/payjp/payjp-android/releases/tag/1.6.0).

## 0.4.0

- Support sound-null-safety.

## 0.3.4

- Update payjp-ios to [1.6.0](https://github.com/payjp/payjp-ios/releases/tag/1.6.0).
- Update payjp-android to [1.5.0](https://github.com/payjp/payjp-android/releases/tag/1.5.0).

## 0.3.3

- Fix token error message in iOS.

## 0.3.2

- Update payjp-ios to [1.5.1](https://github.com/payjp/payjp-ios/releases/tag/1.5.1).
- Update payjp-android to [1.4.1](https://github.com/payjp/payjp-android/releases/tag/1.4.1).

## 0.3.1

- Update dependency of [GoogleUtilities/AppDelegateSwizzler](https://github.com/firebase/firebase-ios-sdk/tree/master/GoogleUtilities/AppDelegateSwizzler) to 7.2.

## 0.3.0

- Update payjp-ios to [1.5.0](https://github.com/payjp/payjp-ios/releases/tag/1.5.0).
- Update payjp-android to [1.4.0](https://github.com/payjp/payjp-android/releases/tag/1.4.0).

## 0.2.8

- Fix android build with Android Gradle Plugin 4.1.0.

## 0.2.7

- Update dependency of [GoogleUtilities/AppDelegateSwizzler](https://github.com/firebase/firebase-ios-sdk/tree/master/GoogleUtilities/AppDelegateSwizzler) to 7.1.

## 0.2.6

- Update payjp-ios to [1.4.0](https://github.com/payjp/payjp-ios/releases/tag/1.4.0).

## 0.2.5

- Update payjp-ios to [1.3.1](https://github.com/payjp/payjp-ios/releases/tag/1.3.1).
- Update payjp-android to [1.3.1](https://github.com/payjp/payjp-android/releases/tag/1.3.1).
- Update dependency of [GoogleUtilities/AppDelegateSwizzler](https://github.com/firebase/firebase-ios-sdk/tree/master/GoogleUtilities/AppDelegateSwizzler) to 7.0.0.

## 0.2.4

- Update payjp-ios to [1.3.0](https://github.com/payjp/payjp-ios/releases/tag/1.3.0).
- Update payjp-android to [1.3.0](https://github.com/payjp/payjp-android/releases/tag/1.3.0).

## 0.2.3

- Update payjp-ios to [1.2.5](https://github.com/payjp/payjp-ios/releases/tag/1.2.5).
- Update payjp-android to [1.2.2](https://github.com/payjp/payjp-android/releases/tag/1.2.2).
- Update dependencies.
- Fix images not displayed in Flutter v1.17.+ #18.

## 0.2.2

- Update payjp-ios to [1.2.3](https://github.com/payjp/payjp-ios/releases/tag/1.2.3).

## 0.2.1

- Update payjp-ios to [1.2.2](https://github.com/payjp/payjp-ios/releases/tag/1.2.2).
- Update payjp-android to [1.2.1](https://github.com/payjp/payjp-android/releases/tag/1.2.1).
- Add option `cardFormType` to Payjp.startCardForm.

## 0.2.0

- Update payjp-ios to [1.2.0](https://github.com/payjp/payjp-ios/releases/tag/1.2.0).
- Update payjp-android to [1.2.0](https://github.com/payjp/payjp-android/releases/tag/1.2.0).
- Add field `threeDSecureStatus` to `Card`.
- Add option `threeDSecureRedirect` to Payjp.init. It is only for 3D Secure.
- In iOS platform, Add [GoogleUtilities/AppDelegateSwizzler](https://github.com/firebase/firebase-ios-sdk/tree/master/GoogleUtilities/AppDelegateSwizzler) to hook `(BOOL)application:openURL:options:`.
- Fix onCardFormCanceledCallback not called on iOS 13 after dismiss by swipe down the modal.

## 0.1.7

- Update payjp-ios to [1.1.6](https://github.com/payjp/payjp-ios/releases/tag/1.1.6).
- Add e2e testing.
- Specify supported platforms.

## 0.1.6

- Fix using string literal instead of BuildConfig.LIBRARY_PACKAGE_NAME.

## 0.1.5

- Fix error message deserialization problem on Apple Pay (iOS).

## 0.1.4

- Update payjp-ios to [1.1.5](https://github.com/payjp/payjp-ios/releases/tag/1.1.5).
- Update payjp-android to [1.1.3](https://github.com/payjp/payjp-android/releases/tag/1.1.3).

## 0.1.3

- Update payjp-ios to [1.1.3](https://github.com/payjp/payjp-ios/releases/tag/1.1.3).

## 0.1.2

- Update payjp-ios to [1.1.2](https://github.com/payjp/payjp-ios/releases/tag/1.1.2).

## 0.1.1

- Support Flutter Android embedding version 2 (and still support v1 too).

## 0.1.0

- Update payjp-android to [1.1.2](https://github.com/payjp/payjp-android/releases/tag/1.1.2).

## 0.0.1

Initial release.
