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
  Iterable<Object?> serialize(Serializers serializers, ErrorInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
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
  ErrorInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ErrorInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'errorType':
          result.errorType = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'errorCode':
          result.errorCode = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'errorMessage':
          result.errorMessage = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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

  factory _$ErrorInfo([void Function(ErrorInfoBuilder)? updates]) =>
      (new ErrorInfoBuilder()..update(updates))._build();

  _$ErrorInfo._(
      {required this.errorType,
      required this.errorCode,
      required this.errorMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(errorType, r'ErrorInfo', 'errorType');
    BuiltValueNullFieldError.checkNotNull(errorCode, r'ErrorInfo', 'errorCode');
    BuiltValueNullFieldError.checkNotNull(
        errorMessage, r'ErrorInfo', 'errorMessage');
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
    var _$hash = 0;
    _$hash = $jc(_$hash, errorType.hashCode);
    _$hash = $jc(_$hash, errorCode.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ErrorInfo')
          ..add('errorType', errorType)
          ..add('errorCode', errorCode)
          ..add('errorMessage', errorMessage))
        .toString();
  }
}

class ErrorInfoBuilder implements Builder<ErrorInfo, ErrorInfoBuilder> {
  _$ErrorInfo? _$v;

  String? _errorType;
  String? get errorType => _$this._errorType;
  set errorType(String? errorType) => _$this._errorType = errorType;

  int? _errorCode;
  int? get errorCode => _$this._errorCode;
  set errorCode(int? errorCode) => _$this._errorCode = errorCode;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  ErrorInfoBuilder();

  ErrorInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _errorType = $v.errorType;
      _errorCode = $v.errorCode;
      _errorMessage = $v.errorMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ErrorInfo;
  }

  @override
  void update(void Function(ErrorInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ErrorInfo build() => _build();

  _$ErrorInfo _build() {
    final _$result = _$v ??
        new _$ErrorInfo._(
            errorType: BuiltValueNullFieldError.checkNotNull(
                errorType, r'ErrorInfo', 'errorType'),
            errorCode: BuiltValueNullFieldError.checkNotNull(
                errorCode, r'ErrorInfo', 'errorCode'),
            errorMessage: BuiltValueNullFieldError.checkNotNull(
                errorMessage, r'ErrorInfo', 'errorMessage'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
