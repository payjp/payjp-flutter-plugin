import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

// ignore: avoid_classes_with_only_static_members
class Payjp {
  static final MethodChannel _channel =
      const MethodChannel('payjp'); // TODO setCallbackHandler

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

  static Future startCardForm(
      String tenantId) async {
    final params = <String, dynamic>{
      'tenantId': tenantId,
    };
    await _channel.invokeMethod('startCardForm', params);
  }

  // TODO: applePay
}
