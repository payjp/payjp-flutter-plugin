import 'dart:async';

import 'package:built_value/standard_json_plugin.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:payjp_flutter/card_form_status.dart';
import 'package:payjp_flutter/card_token.dart';
import 'package:payjp_flutter/serializers.dart';

typedef OnCardFormCompletedCallback = void Function(Token token);
typedef OnCardFormCanceledCallback = void Function();
typedef OnCardFormProducedTokenCallback = FutureOr<CardFormStatus> Function(Token token);

// ignore: avoid_classes_with_only_static_members
class Payjp {
  static OnCardFormCanceledCallback _onCardFormCanceledCallback;
  static OnCardFormCompletedCallback _onCardFormCompletedCallback;
  static OnCardFormProducedTokenCallback _onCardFormProducedTokenCallback;

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
          final token =
              _serializers.deserializeWith(Token.serializer, call.arguments);
          _onCardFormCompletedCallback(token);
        }
        break;
      case 'onCardFormProducedToken':
        CardFormStatus status = CardFormComplete();
        if (_onCardFormProducedTokenCallback != null) {
          final token =
              _serializers.deserializeWith(Token.serializer, call.arguments);
          final statusFutureOr = _onCardFormProducedTokenCallback(token);
          if (statusFutureOr is Future<CardFormStatus>) {
            status = await statusFutureOr;
          } else {
            status = statusFutureOr as CardFormStatus;
          }
        }
        await _requestCardFormStatus(status);
        break;
    }
    return null;
  }

  static Future configure(
      {@required String publicKey, bool debugEnabled = false}) async {
    final params = <String, dynamic>{
      'publicKey': publicKey,
      'debugEnabled': debugEnabled,
    };
    await _channel.invokeMethod('configure', params);
  }

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

  static Future _requestCardFormStatus(CardFormStatus status) async {
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
