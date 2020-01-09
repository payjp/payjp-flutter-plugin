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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ErrorInfo> _$errorInfoSerializer = new _$ErrorInfoSerializer();

class _$ErrorInfoSerializer implements StructuredSerializer<ErrorInfo> {
  @override
  final Iterable<Type> types = const [ErrorInfo, _$ErrorInfo];
  @override
  final String wireName = 'ErrorInfo';

  @override
  Iterable<Object> serialize(Serializers serializers, ErrorInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'errorType',
      serializers.serialize(object.errorType,
          specifiedType: const FullType(String)),
      'errorCode',
      serializers.serialize(object.errorCode,
          specifiedType: const FullType(int)),
      'errorMessage',
      serializers.serialize(object.errorMessage,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ErrorInfo deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ErrorInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'errorType':
          result.errorType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'errorCode':
          result.errorCode = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'errorMessage':
          result.errorMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ErrorInfo extends ErrorInfo {
  @override
  final String errorType;
  @override
  final int errorCode;
  @override
  final String errorMessage;

  factory _$ErrorInfo([void Function(ErrorInfoBuilder) updates]) =>
      (new ErrorInfoBuilder()..update(updates)).build();

  _$ErrorInfo._({this.errorType, this.errorCode, this.errorMessage})
      : super._() {
    if (errorType == null) {
      throw new BuiltValueNullFieldError('ErrorInfo', 'errorType');
    }
    if (errorCode == null) {
      throw new BuiltValueNullFieldError('ErrorInfo', 'errorCode');
    }
    if (errorMessage == null) {
      throw new BuiltValueNullFieldError('ErrorInfo', 'errorMessage');
    }
  }

  @override
  ErrorInfo rebuild(void Function(ErrorInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorInfoBuilder toBuilder() => new ErrorInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorInfo &&
        errorType == other.errorType &&
        errorCode == other.errorCode &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, errorType.hashCode), errorCode.hashCode),
        errorMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ErrorInfo')
          ..add('errorType', errorType)
          ..add('errorCode', errorCode)
          ..add('errorMessage', errorMessage))
        .toString();
  }
}

class ErrorInfoBuilder implements Builder<ErrorInfo, ErrorInfoBuilder> {
  _$ErrorInfo _$v;

  String _errorType;
  String get errorType => _$this._errorType;
  set errorType(String errorType) => _$this._errorType = errorType;

  int _errorCode;
  int get errorCode => _$this._errorCode;
  set errorCode(int errorCode) => _$this._errorCode = errorCode;

  String _errorMessage;
  String get errorMessage => _$this._errorMessage;
  set errorMessage(String errorMessage) => _$this._errorMessage = errorMessage;

  ErrorInfoBuilder();

  ErrorInfoBuilder get _$this {
    if (_$v != null) {
      _errorType = _$v.errorType;
      _errorCode = _$v.errorCode;
      _errorMessage = _$v.errorMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ErrorInfo;
  }

  @override
  void update(void Function(ErrorInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ErrorInfo build() {
    final _$result = _$v ??
        new _$ErrorInfo._(
            errorType: errorType,
            errorCode: errorCode,
            errorMessage: errorMessage);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
