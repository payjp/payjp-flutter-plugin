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
import 'package:payjp_flutter/src/models.dart';
import 'package:payjp_flutter/src/serializers.dart';
import 'package:payjp_flutter/src/three_d_secure.dart';

typedef OnCardFormCompletedCallback = void Function();
typedef OnCardFormCanceledCallback = void Function();
typedef OnCardFormProducedTokenCallback = FutureOr<CallbackResult> Function(
    Token token);
typedef OnApplePayProducedTokenCallback = FutureOr<CallbackResult> Function(
    Token token);
typedef OnApplePayFailedRequestTokenCallback = FutureOr<CallbackResultError>
    Function(ErrorInfo errorInfo);
typedef OnApplePayCompletedCallback = void Function();

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

  @visibleForTesting
  static final MethodChannel channel = const MethodChannel('payjp')
    ..setMethodCallHandler(_nativeCallHandler);

  static final _serializers =
      (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

  static Future<dynamic> _nativeCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onCardFormCanceled':
        if (_onCardFormCanceledCallback != null) {
          _onCardFormCanceledCallback?.call();
        }
        break;
      case 'onCardFormCompleted':
        if (_onCardFormCompletedCallback != null) {
          _onCardFormCompletedCallback?.call();
        }
        break;
      case 'onCardFormProducedToken':
        CallbackResult result = CallbackResultOk();
        if (_onCardFormProducedTokenCallback != null) {
          final token = Token.fromJson(call.arguments);
          final resultFutureOr = _onCardFormProducedTokenCallback?.call(token);
          if (resultFutureOr is Future<CallbackResult>) {
            result = await resultFutureOr;
          } else {
            result = resultFutureOr as CallbackResult;
          }
        }
        if (result is CallbackResultOk) {
          await completeCardForm();
        } else if (result is CallbackResultError) {
          await showTokenProcessingError(result.message);
        }
        break;
      case 'onApplePayProducedToken':
        CallbackResult result = CallbackResultOk();
        if (_onApplePayProducedTokenCallback != null) {
          final token = Token.fromJson(call.arguments);
          final resultFutureOr = _onApplePayProducedTokenCallback?.call(token);
          if (resultFutureOr is Future<CallbackResult>) {
            result = await resultFutureOr;
          } else {
            result = resultFutureOr as CallbackResult;
          }
        }
        final params = <String, dynamic>{
          'isSuccess': result.isOk(),
          'errorMessage': result is CallbackResultError ? result.message : null,
        };
        await channel.invokeMethod('completeApplePay', params);
        break;
      case 'onApplePayFailedRequestToken':
        final errorInfo =
            _serializers.deserializeWith(ErrorInfo.serializer, call.arguments);
        var message = errorInfo.errorMessage;
        if (_onApplePayFailedRequestTokenCallback != null) {
          CallbackResultError result;
          final resultFutureOr =
              _onApplePayFailedRequestTokenCallback?.call(errorInfo);
          if (resultFutureOr is Future<CallbackResultError>) {
            result = await resultFutureOr;
          } else {
            result = resultFutureOr as CallbackResultError;
          }
          message = result.message;
        }
        final params = <String, dynamic>{
          'isSuccess': false,
          'errorMessage': message,
        };
        await channel.invokeMethod('completeApplePay', params);
        break;
      case 'onApplePayCompleted':
        if (_onApplePayCompletedCallback != null) {
          _onApplePayCompletedCallback?.call();
        }
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
  static Future startCardForm(
      {OnCardFormProducedTokenCallback? onCardFormProducedTokenCallback,
      OnCardFormCanceledCallback? onCardFormCanceledCallback,
      OnCardFormCompletedCallback? onCardFormCompletedCallback,
      String? tenantId,
      CardFormType cardFormType = CardFormType.multiLine}) async {
    _onCardFormCanceledCallback = onCardFormCanceledCallback;
    _onCardFormCompletedCallback = onCardFormCompletedCallback;
    _onCardFormProducedTokenCallback = onCardFormProducedTokenCallback;
    final params = <String, dynamic>{
      'tenantId': tenantId,
      'cardFormType': CardFormTypeTransformer.enumToString(cardFormType)
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
      'labelTextColor': labelTextColor?.value,
      'inputTextColor': inputTextColor?.value,
      'errorTextColor': errorTextColor?.value,
      'tintColor': tintColor?.value,
      'inputFieldBackgroundColor': inputFieldBackgroundColor?.value,
      'submitButtonColor': submitButtonColor?.value,
      'highlightColor': highlightColor?.value,
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
      bool requiredBillingAddress = false,
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
      'requiredBillingAddress': requiredBillingAddress
    };
    await channel.invokeMethod('makeApplePayToken', params);
  }
}
