/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

import 'dart:async';
import 'dart:ui';

import 'package:built_value/standard_json_plugin.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:payjp_flutter/src/callback_result.dart';
import 'package:payjp_flutter/src/card_form_type.dart';
import 'package:payjp_flutter/src/error_info.dart';
import 'package:payjp_flutter/src/extra_attribute.dart';
import 'package:payjp_flutter/src/serializers.dart';
import 'package:payjp_flutter/src/three_d_secure.dart';
import 'package:payjp_flutter/src/token.dart';

typedef OnCardFormCompletedCallback = void Function();
typedef OnCardFormCanceledCallback = void Function();
typedef OnCardFormProducedTokenCallback = FutureOr<CallbackResult> Function(
    Token token);
typedef OnApplePayProducedTokenCallback = FutureOr<CallbackResult> Function(
    Token token);
typedef OnApplePayFailedRequestTokenCallback = FutureOr<CallbackResultError>
    Function(ErrorInfo errorInfo);
typedef OnApplePayCompletedCallback = void Function();
typedef OnThreeDSecureProcessFinished = void Function(
    ThreeDSecureProcessStatus);

// ignore: avoid_classes_with_only_static_members
/// Provides flutter bridge for PAY.JP.
class Payjp {
  static OnCardFormCanceledCallback? _onCardFormCanceledCallback;
  static OnCardFormCompletedCallback? _onCardFormCompletedCallback;
  static OnCardFormProducedTokenCallback? _onCardFormProducedTokenCallback;
  static OnApplePayProducedTokenCallback? _onApplePayProducedTokenCallback;
  static OnApplePayFailedRequestTokenCallback?
      _onApplePayFailedRequestTokenCallback;
  static OnApplePayCompletedCallback? _onApplePayCompletedCallback;
  static OnThreeDSecureProcessFinished? _onThreeDSecureProcessFinishedCallback;

  @visibleForTesting
  static final MethodChannel channel = const MethodChannel('payjp')
    ..setMethodCallHandler(_nativeCallHandler);

  static final _serializers =
      (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

  static Future<dynamic> _nativeCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onCardFormCanceled':
        _onCardFormCanceledCallback?.call();
        break;
      case 'onCardFormCompleted':
        _onCardFormCompletedCallback?.call();
        break;
      case 'onCardFormProducedToken':
        CallbackResult result = CallbackResultOk();
        final token =
            _serializers.deserializeWith(Token.serializer, call.arguments)!;
        final resultFutureOr = _onCardFormProducedTokenCallback?.call(token);
        if (resultFutureOr != null) {
          if (resultFutureOr is Future<CallbackResult>) {
            result = await resultFutureOr;
          } else {
            result = resultFutureOr;
          }
          if (result is CallbackResultOk) {
            await completeCardForm();
          } else if (result is CallbackResultError) {
            await showTokenProcessingError(result.message);
          }
        }
        break;
      case 'onApplePayProducedToken':
        CallbackResult result = CallbackResultOk();
        final token =
            _serializers.deserializeWith(Token.serializer, call.arguments)!;
        final resultFutureOr = _onApplePayProducedTokenCallback?.call(token);
        if (resultFutureOr != null) {
          if (resultFutureOr is Future<CallbackResult>) {
            result = await resultFutureOr;
          } else {
            result = resultFutureOr;
          }
          final params = <String, dynamic>{
            'isSuccess': result.isOk(),
            'errorMessage':
                result is CallbackResultError ? result.message : null,
          };
          await channel.invokeMethod('completeApplePay', params);
        }
        break;
      case 'onApplePayFailedRequestToken':
        final errorInfo =
            _serializers.deserializeWith(ErrorInfo.serializer, call.arguments)!;
        var message = errorInfo.errorMessage;
        CallbackResultError result;
        final resultFutureOr =
            _onApplePayFailedRequestTokenCallback?.call(errorInfo);
        if (resultFutureOr != null) {
          if (resultFutureOr is Future<CallbackResultError>) {
            result = await resultFutureOr;
          } else {
            result = resultFutureOr;
          }
          message = result.message;
          final params = <String, dynamic>{
            'isSuccess': false,
            'errorMessage': message,
          };
          await channel.invokeMethod('completeApplePay', params);
        }
        break;
      case 'onApplePayCompleted':
        _onApplePayCompletedCallback?.call();
        break;
      case 'onThreeDSecureProcessFinished':
        final ThreeDSecureProcessStatus status;
        switch (call.arguments) {
          case 'completed':
            status = ThreeDSecureProcessStatus.completed;
            break;
          case 'canceled':
            status = ThreeDSecureProcessStatus.canceled;
            break;
          case 'failed':
            status = ThreeDSecureProcessStatus.failed;
            break;
          default:
            status = ThreeDSecureProcessStatus.canceled;
            break;
        }
        _onThreeDSecureProcessFinishedCallback?.call(status);
        break;
    }
    return null;
  }

  /// Initialize PAYJP with [publicKey] and other configurations.
  ///
  /// ```dart
  /// Payjp.init(publicKey: 'pk_test_xxxx');
  /// ```
  /// If you'd like to enable debugging, set [debugEnabled] to true (Android Only).
  /// You can also set [locale] manually, which is following the device setting
  /// by default. [threeDSecureRedirect] is required only if you support 3D Secure.
  /// You can register key and url in [PAY.JP dashboard](https://pay.jp/d/settings) if activated.
  static Future init(
      {required String publicKey,
      bool debugEnabled = false,
      Locale? locale,
      PayjpThreeDSecureRedirect? threeDSecureRedirect}) async {
    final params = <String, dynamic>{
      'publicKey': publicKey,
      'debugEnabled': debugEnabled,
      'locale': locale?.toLanguageTag(),
      'threeDSecureRedirectUrl': threeDSecureRedirect?.url,
      'threeDSecureRedirectKey': threeDSecureRedirect?.key
    };
    await channel.invokeMethod('initialize', params);
  }

  /// Start card form.
  /// It will activate a native screen provided by Payjp.
  /// All callback parameters are optional, but you should use [onCardFormProducedTokenCallback]
  /// to send PAY.JP token to your server.
  /// [tenantId] is a parameter only for platform API.
  /// [cardFormType] is type of CardForm.(default MultiLine)
  /// [extraAttributes] is a list of extra attributes for card form. (default Email and Phone)
  static Future startCardForm(
      {OnCardFormCanceledCallback? onCardFormCanceledCallback,
      OnCardFormCompletedCallback? onCardFormCompletedCallback,
      OnCardFormProducedTokenCallback? onCardFormProducedTokenCallback,
      String? tenantId,
      CardFormType cardFormType = CardFormType.multiLine,
      List<ExtraAttribute>? extraAttributes,
      bool? useThreeDSecure}) async {
    _onCardFormCanceledCallback = onCardFormCanceledCallback;
    _onCardFormCompletedCallback = onCardFormCompletedCallback;
    _onCardFormProducedTokenCallback = onCardFormProducedTokenCallback;
    extraAttributes ??= [ExtraAttributeEmail(), ExtraAttributePhone()];
    final extraAttributesEmail =
        extraAttributes.whereType<ExtraAttributeEmail>().firstOrNull;
    final extraAttributesPhone =
        extraAttributes.whereType<ExtraAttributePhone>().firstOrNull;
    final params = <String, dynamic>{
      'tenantId': tenantId,
      'cardFormType': cardFormType.name,
      'extraAttributesEmailEnabled': extraAttributesEmail != null,
      'extraAttributesEmailPreset': extraAttributesEmail?.preset,
      'extraAttributesPhoneEnabled': extraAttributesPhone != null,
      'extraAttributesPhonePresetRegion': extraAttributesPhone?.presetRegion,
      'extraAttributesPhonePresetNumber': extraAttributesPhone?.presetNumber,
      'useThreeDSecure': useThreeDSecure ?? false
    };
    await channel.invokeMethod('startCardForm', params);
  }

  /// Close displaying card form.
  static Future completeCardForm() async {
    await channel.invokeMethod('completeCardForm');
  }

  /// Keep displaying card form, and show [message] as error message.
  static Future showTokenProcessingError(String message) async {
    final params = <String, dynamic>{
      'message': message,
    };
    await channel.invokeMethod('showTokenProcessingError', params);
  }

  /// Set CardForm Style for iOS.
  static Future setIOSCardFormStyle(
      {Color? labelTextColor,
      Color? inputTextColor,
      Color? errorTextColor,
      Color? tintColor,
      Color? inputFieldBackgroundColor,
      Color? submitButtonColor,
      Color? highlightColor}) async {
    final params = <String, dynamic>{
      'labelTextColor': labelTextColor?.value, // ignore: deprecated_member_use
      'inputTextColor': inputTextColor?.value, // ignore: deprecated_member_use
      'errorTextColor': errorTextColor?.value, // ignore: deprecated_member_use
      'tintColor': tintColor?.value, // ignore: deprecated_member_use
      'inputFieldBackgroundColor':
          inputFieldBackgroundColor?.value, // ignore: deprecated_member_use
      'submitButtonColor':
          submitButtonColor?.value, // ignore: deprecated_member_use
      'highlightColor': highlightColor?.value, // ignore: deprecated_member_use
    };
    await channel.invokeMethod('setFormStyle', params);
  }

  /// Return availability of ApplePay.
  /// You should call in only iOS.
  /// See https://developer.apple.com/documentation/passkit/pkpaymentauthorizationviewcontroller/1616192-canmakepayments
  static Future<bool> isApplePayAvailable() async =>
      await channel.invokeMethod('isApplePayAvailable');

  /// Start Apple Pay payment authorization flow.
  /// You have to set your own merchant id provided by Apple into [appleMerchantId].
  /// All callback parameters are optional, but you should use [onApplePayProducedTokenCallback]
  /// to send PAY.JP token to your server.
  ///
  /// [requiredBillingAddress] flag is false by default.
  static Future makeApplePayToken(
      {required String appleMerchantId,
      required String currencyCode,
      required String countryCode,
      required String summaryItemLabel,
      required String summaryItemAmount,
      bool? requiredBillingAddress,
      OnApplePayProducedTokenCallback? onApplePayProducedTokenCallback,
      OnApplePayFailedRequestTokenCallback?
          onApplePayFailedRequestTokenCallback,
      OnApplePayCompletedCallback? onApplePayCompletedCallback}) async {
    _onApplePayProducedTokenCallback = onApplePayProducedTokenCallback;
    _onApplePayFailedRequestTokenCallback =
        onApplePayFailedRequestTokenCallback;
    _onApplePayCompletedCallback = onApplePayCompletedCallback;
    final params = <String, dynamic>{
      'appleMerchantId': appleMerchantId,
      'currencyCode': currencyCode,
      'countryCode': countryCode,
      'summaryItemLabel': summaryItemLabel,
      'summaryItemAmount': summaryItemAmount,
      'requiredBillingAddress': requiredBillingAddress ?? false
    };
    await channel.invokeMethod('makeApplePayToken', params);
  }

  /// Start 3D Secure process.
  /// resourceIdを使用して3Dセキュア処理を行います
  ///
  /// [resourceId]は処理対象のリソースIDを指定します（例：charge_xxxやcard_xxx）
  /// [onThreeDSecureProcessFinished]は3Dセキュア処理が終了した時のコールバック
  static Future startThreeDSecure({
    required String resourceId,
    OnThreeDSecureProcessFinished? onThreeDSecureProcessFinished,
  }) async {
    _onThreeDSecureProcessFinishedCallback = onThreeDSecureProcessFinished;
    final params = <String, dynamic>{
      'resourceId': resourceId,
    };
    await channel.invokeMethod('startThreeDSecureProcess', params);
  }
}
