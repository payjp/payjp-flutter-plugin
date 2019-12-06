import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:payjp_flutter/card_form_status.dart';

typedef OnCardFormCompletedCallback = void Function(Object token); // TODO: type
typedef OnCardFormCanceledCallback = void Function();
typedef OnCardFormProducedTokenCallback = CardFormStatus Function(Object token); // TODO: type

// ignore: avoid_classes_with_only_static_members
class Payjp {
  static OnCardFormCanceledCallback _onCardFormCanceledCallback;
  static OnCardFormCompletedCallback _onCardFormCompletedCallback;
  static OnCardFormProducedTokenCallback _onCardFormProducedTokenCallback;

  static final MethodChannel _channel =
      const MethodChannel('payjp')
        ..setMethodCallHandler(_nativeCallHandler);

  static Future<dynamic> _nativeCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onCardFormCanceled':
        if (_onCardFormCanceledCallback != null) {
          _onCardFormCanceledCallback();
        }
        break;
      case 'onCardFormCompleted':
        if (_onCardFormCompletedCallback != null) {
          _onCardFormCompletedCallback(call.arguments); // TODO: convert
        }
        break;
      case 'onCardFormProducedToken':
        var status = CardFormComplete();
        if (_onCardFormProducedTokenCallback != null) {
          status = _onCardFormProducedTokenCallback(call.arguments); // TODO: convert
        }
        await requestCardFormStatus(status);
        break;
    }
    return null;
  }

  static Future configure({
    @required String publicKey,
    bool debugEnabled = false
  }) async {
    final params = <String, dynamic>{
      'publicKey': publicKey,
      'debugEnabled': debugEnabled,
    };
    await _channel.invokeMethod('configure', params);
  }

  static Future startCardForm({
    OnCardFormCanceledCallback onCardFormCanceledCallback,
    OnCardFormCompletedCallback onCardFormCompletedCallback,
    OnCardFormProducedTokenCallback onCardFormProducedTokenCallback,
    String tenantId
  }) async {
    _onCardFormCanceledCallback = onCardFormCanceledCallback;
    _onCardFormCompletedCallback = onCardFormCompletedCallback;
    _onCardFormProducedTokenCallback = onCardFormProducedTokenCallback;
    final params = <String, dynamic>{
      'tenantId': tenantId,
    };
    await _channel.invokeMethod('startCardForm', params);
  }

  static Future requestCardFormStatus(
      CardFormStatus status) async {
    if (status is CardFormComplete) {
      await completeCardForm();
    } else if (status is CardFormError) {
      await showTokenProcessingError(status.message);
    }
  }

  static Future completeCardForm() async {
    await _channel.invokeMethod('completeCardForm');
  }

  static Future showTokenProcessingError(String message) async {
    final params = <String, dynamic>{
      'message': message,
    };
    await _channel.invokeMethod('showTokenProcessingError', params);
  }

  // TODO: applePay
}
