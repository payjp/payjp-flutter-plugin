// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Token extends Token {
  @override
  final String id;
  @override
  final Card card;
  @override
  final int created;
  @override
  final bool livemode;
  @override
  final String object;
  @override
  final bool used;

  factory _$Token([void Function(TokenBuilder)? updates]) =>
      (new TokenBuilder()..update(updates)).build();

  _$Token._(
      {required this.id,
      required this.card,
      required this.created,
      required this.livemode,
      required this.object,
      required this.used})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'Token', 'id');
    BuiltValueNullFieldError.checkNotNull(card, 'Token', 'card');
    BuiltValueNullFieldError.checkNotNull(created, 'Token', 'created');
    BuiltValueNullFieldError.checkNotNull(livemode, 'Token', 'livemode');
    BuiltValueNullFieldError.checkNotNull(object, 'Token', 'object');
    BuiltValueNullFieldError.checkNotNull(used, 'Token', 'used');
  }

  @override
  Token rebuild(void Function(TokenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenBuilder toBuilder() => new TokenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Token &&
        id == other.id &&
        card == other.card &&
        created == other.created &&
        livemode == other.livemode &&
        object == other.object &&
        used == other.used;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, id.hashCode), card.hashCode), created.hashCode),
                livemode.hashCode),
            object.hashCode),
        used.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Token')
          ..add('id', id)
          ..add('card', card)
          ..add('created', created)
          ..add('livemode', livemode)
          ..add('object', object)
          ..add('used', used))
        .toString();
  }
}

class TokenBuilder implements Builder<Token, TokenBuilder> {
  _$Token? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  CardBuilder? _card;
  CardBuilder get card => _$this._card ??= new CardBuilder();
  set card(CardBuilder? card) => _$this._card = card;

  int? _created;
  int? get created => _$this._created;
  set created(int? created) => _$this._created = created;

  bool? _livemode;
  bool? get livemode => _$this._livemode;
  set livemode(bool? livemode) => _$this._livemode = livemode;

  String? _object;
  String? get object => _$this._object;
  set object(String? object) => _$this._object = object;

  bool? _used;
  bool? get used => _$this._used;
  set used(bool? used) => _$this._used = used;

  TokenBuilder() {
    Token._initializeBuilder(this);
  }

  TokenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _card = $v.card.toBuilder();
      _created = $v.created;
      _livemode = $v.livemode;
      _object = $v.object;
      _used = $v.used;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Token other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Token;
  }

  @override
  void update(void Function(TokenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Token build() {
    _$Token _$result;
    try {
      _$result = _$v ??
          new _$Token._(
              id: BuiltValueNullFieldError.checkNotNull(id, 'Token', 'id'),
              card: card.build(),
              created: BuiltValueNullFieldError.checkNotNull(
                  created, 'Token', 'created'),
              livemode: BuiltValueNullFieldError.checkNotNull(
                  livemode, 'Token', 'livemode'),
              object: BuiltValueNullFieldError.checkNotNull(
                  object, 'Token', 'object'),
              used:
                  BuiltValueNullFieldError.checkNotNull(used, 'Token', 'used'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'card';
        card.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Token', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
