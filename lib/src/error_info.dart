/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'error_info.g.dart';

/// Information of error provided by Native.
abstract class ErrorInfo implements Built<ErrorInfo, ErrorInfoBuilder> {
  String get errorType;
  int get errorCode;
  String get errorMessage;

  ErrorInfo._();
  factory ErrorInfo([updates(ErrorInfoBuilder b)]) = _$ErrorInfo;
  static Serializer<ErrorInfo> get serializer => _$errorInfoSerializer;
}
