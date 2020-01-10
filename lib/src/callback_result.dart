/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

import 'package:meta/meta.dart';

/// Represents success or error.
@sealed
// ignore: one_member_abstracts
abstract class CallbackResult {
  bool isOk();
}

/// Represents success
class CallbackResultOk extends CallbackResult {
  @override
  bool isOk() => true;
}

/// Represents error
class CallbackResultError extends CallbackResult {
  /// error message
  final String message;

  CallbackResultError(this.message);

  @override
  bool isOk() => false;
}
