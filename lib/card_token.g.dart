// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_token.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Token> _$tokenSerializer = new _$TokenSerializer();

class _$TokenSerializer implements StructuredSerializer<Token> {
  @override
  final Iterable<Type> types = const [Token, _$Token];
  @override
  final String wireName = 'Token';

  @override
  Iterable<Object> serialize(Serializers serializers, Token object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'livemode',
      serializers.serialize(object.livemode,
          specifiedType: const FullType(bool)),
      'used',
      serializers.serialize(object.used, specifiedType: const FullType(bool)),
      'card',
      serializers.serialize(object.card, specifiedType: const FullType(Card)),
      'created',
      serializers.serialize(object.created,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  Token deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TokenBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'livemode':
          result.livemode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'used':
          result.used = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'card':
          result.card.replace(serializers.deserialize(value,
              specifiedType: const FullType(Card)) as Card);
          break;
        case 'created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$Token extends Token {
  @override
  final String id;
  @override
  final bool livemode;
  @override
  final bool used;
  @override
  final Card card;
  @override
  final DateTime created;

  factory _$Token([void Function(TokenBuilder) updates]) =>
      (new TokenBuilder()..update(updates)).build();

  _$Token._({this.id, this.livemode, this.used, this.card, this.created})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Token', 'id');
    }
    if (livemode == null) {
      throw new BuiltValueNullFieldError('Token', 'livemode');
    }
    if (used == null) {
      throw new BuiltValueNullFieldError('Token', 'used');
    }
    if (card == null) {
      throw new BuiltValueNullFieldError('Token', 'card');
    }
    if (created == null) {
      throw new BuiltValueNullFieldError('Token', 'created');
    }
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
        livemode == other.livemode &&
        used == other.used &&
        card == other.card &&
        created == other.created;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), livemode.hashCode), used.hashCode),
            card.hashCode),
        created.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Token')
          ..add('id', id)
          ..add('livemode', livemode)
          ..add('used', used)
          ..add('card', card)
          ..add('created', created))
        .toString();
  }
}

class TokenBuilder implements Builder<Token, TokenBuilder> {
  _$Token _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  bool _livemode;
  bool get livemode => _$this._livemode;
  set livemode(bool livemode) => _$this._livemode = livemode;

  bool _used;
  bool get used => _$this._used;
  set used(bool used) => _$this._used = used;

  CardBuilder _card;
  CardBuilder get card => _$this._card ??= new CardBuilder();
  set card(CardBuilder card) => _$this._card = card;

  DateTime _created;
  DateTime get created => _$this._created;
  set created(DateTime created) => _$this._created = created;

  TokenBuilder();

  TokenBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _livemode = _$v.livemode;
      _used = _$v.used;
      _card = _$v.card?.toBuilder();
      _created = _$v.created;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Token other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Token;
  }

  @override
  void update(void Function(TokenBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Token build() {
    _$Token _$result;
    try {
      _$result = _$v ??
          new _$Token._(
              id: id,
              livemode: livemode,
              used: used,
              card: card.build(),
              created: created);
    } catch (_) {
      String _$failedField;
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
