/*
 *
 * Copyright (c) 2020 PAY, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'dart:async';
import 'dart:ui';

import 'package:built_value/standard_json_plugin.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:payjp_flutter/src/callback_result.dart';
import 'package:payjp_flutter/src/error_info.dart';
import 'package:payjp_flutter/src/models.dart';
import 'package:payjp_flutter/src/serializers.dart';

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
class Payjp {
  static OnCardFormCanceledCallback _onCardFormCanceledCallback;
  static OnCardFormCompletedCallback _onCardFormCompletedCallback;
  static OnCardFormProducedTokenCallback _onCardFormProducedTokenCallback;
  static OnApplePayProducedTokenCallback _onApplePayProducedTokenCallback;
  static OnApplePayFailedRequestTokenCallback
      _onApplePayFailedRequestTokenCallback;
  static OnApplePayCompletedCallback _onApplePayCompletedCallback;

  static final MethodChannel _channel = const MethodChannel('payjp')
    ..setMethodCallHandler(_nativeCallHandler);

  static final _serializers =
      (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

  static Future<dynamic> _nativeCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onCardFormCanceled':
        if (_onCardFormCanceledCallback != null) {
          _onCardFormCanceledCallback();
        }
        break;
      case 'onCardFormCompleted':
        if (_onCardFormCompletedCallback != null) {
          _onCardFormCompletedCallback();
        }
        break;
      case 'onCardFormProducedToken':
        CallbackResult result = CallbackResultOk();
        if (_onCardFormProducedTokenCallback != null) {
          final token = Token.fromJson(call.arguments);
          final resultFutureOr = _onCardFormProducedTokenCallback(token);
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
          final resultFutureOr = _onApplePayProducedTokenCallback(token);
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
        await _channel.invokeMethod('completeApplePay', params);
        break;
      case 'onApplePayFailedRequestToken':
        final errorInfo =
            _serializers.deserializeWith(ErrorInfo.serializer, call.arguments);
        var message = errorInfo.errorMessage;
        if (_onApplePayFailedRequestTokenCallback != null) {
          CallbackResultError result;
          final resultFutureOr =
              _onApplePayFailedRequestTokenCallback(errorInfo);
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
        await _channel.invokeMethod('completeApplePay', params);
        break;
      case 'onApplePayCompleted':
        if (_onApplePayCompletedCallback != null) {
          _onApplePayCompletedCallback();
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
  /// If you'd like to enable debugging, set [debugEnabled] to true.
  /// You can also set [locale] manually, which is following the device setting
  /// by default.
  static Future init(
      {@required String publicKey,
      bool debugEnabled = false,
      bool scannerEnabled = true,
      Locale locale}) async {
    final params = <String, dynamic>{
      'publicKey': publicKey,
      'debugEnabled': debugEnabled,
      'locale': locale != null ? locale.toLanguageTag() : null,
    };
    await _channel.invokeMethod('initialize', params);
  }

  /// Start card form.
  /// It will activate a native screen provided by Payjp.
  /// [tenantId] is a optional parameter only for platform API.
  static Future startCardForm(
      {OnCardFormCanceledCallback onCardFormCanceledCallback,
      OnCardFormCompletedCallback onCardFormCompletedCallback,
      OnCardFormProducedTokenCallback onCardFormProducedTokenCallback,
      String tenantId}) async {
    _onCardFormCanceledCallback = onCardFormCanceledCallback;
    _onCardFormCompletedCallback = onCardFormCompletedCallback;
    _onCardFormProducedTokenCallback = onCardFormProducedTokenCallback;
    final params = <String, dynamic>{
      'tenantId': tenantId,
    };
    await _channel.invokeMethod('startCardForm', params);
  }

  /// Close displaying card form.
  static Future completeCardForm() async {
    await _channel.invokeMethod('completeCardForm');
  }

  /// Keep displaying card form, and show [message] as error message.
  static Future showTokenProcessingError(String message) async {
    final params = <String, dynamic>{
      'message': message,
    };
    await _channel.invokeMethod('showTokenProcessingError', params);
  }

  /// Return availability of ApplePay.
  /// You should call in only iOS.
  /// See https://developer.apple.com/documentation/passkit/pkpaymentauthorizationviewcontroller/1616192-canmakepayments
  static Future<bool> isApplePayAvailable() async =>
      _channel.invokeMethod('isApplePayAvailable');

  /// Start Apple Pay payment authorization flow.
  static Future makeApplePayToken(
      {@required String appleMerchantId,
      @required String currencyCode,
      @required String countryCode,
      @required String summaryItemLabel,
      @required String summaryItemAmount,
      bool requiredBillingAddress = false,
      OnApplePayProducedTokenCallback onApplePayProducedTokenCallback,
      OnApplePayFailedRequestTokenCallback onApplePayFailedRequestTokenCallback,
      OnApplePayCompletedCallback onApplePayCompletedCallback}) async {
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
    await _channel.invokeMethod('makeApplePayToken', params);
  }
}
