// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CardBrand _$visa = const CardBrand._('visa');
const CardBrand _$mastercard = const CardBrand._('mastercard');
const CardBrand _$jcb = const CardBrand._('jcb');
const CardBrand _$amex = const CardBrand._('amex');
const CardBrand _$dinersClub = const CardBrand._('dinersClub');
const CardBrand _$discover = const CardBrand._('discover');
const CardBrand _$unknown = const CardBrand._('unknown');

CardBrand _$cardBrandValueOf(String name) {
  switch (name) {
    case 'visa':
      return _$visa;
    case 'mastercard':
      return _$mastercard;
    case 'jcb':
      return _$jcb;
    case 'amex':
      return _$amex;
    case 'dinersClub':
      return _$dinersClub;
    case 'discover':
      return _$discover;
    case 'unknown':
      return _$unknown;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<CardBrand> _$cardBrandValues =
    new BuiltSet<CardBrand>(const <CardBrand>[
  _$visa,
  _$mastercard,
  _$jcb,
  _$amex,
  _$dinersClub,
  _$discover,
  _$unknown,
]);

Serializer<CardBrand> _$cardBrandSerializer = new _$CardBrandSerializer();
Serializer<Card> _$cardSerializer = new _$CardSerializer();

class _$CardBrandSerializer implements PrimitiveSerializer<CardBrand> {
  static const Map<String, String> _toWire = const <String, String>{
    'visa': 'Visa',
    'mastercard': 'MasterCard',
    'jcb': 'JCB',
    'amex': 'American Express',
    'dinersClub': 'Diners Club',
    'discover': 'Discover',
    'unknown': 'Unknown',
  };
  static const Map<String, String> _fromWire = const <String, String>{
    'Visa': 'visa',
    'MasterCard': 'mastercard',
    'JCB': 'jcb',
    'American Express': 'amex',
    'Diners Club': 'dinersClub',
    'Discover': 'discover',
    'Unknown': 'unknown',
  };

  @override
  final Iterable<Type> types = const <Type>[CardBrand];
  @override
  final String wireName = 'CardBrand';

  @override
  Object serialize(Serializers serializers, CardBrand object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CardBrand deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CardBrand.valueOf(_fromWire[serialized] ?? serialized as String);
}

class _$CardSerializer implements StructuredSerializer<Card> {
  @override
  final Iterable<Type> types = const [Card, _$Card];
  @override
  final String wireName = 'Card';

  @override
  Iterable<Object> serialize(Serializers serializers, Card object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'brand',
      serializers.serialize(object.brand,
          specifiedType: const FullType(CardBrand)),
      'exp_month',
      serializers.serialize(object.expirationMonth,
          specifiedType: const FullType(int)),
      'exp_year',
      serializers.serialize(object.expirationYear,
          specifiedType: const FullType(int)),
      'fingerprint',
      serializers.serialize(object.fingerprint,
          specifiedType: const FullType(String)),
      'livemode',
      serializers.serialize(object.livemode,
          specifiedType: const FullType(bool)),
      'created',
      serializers.serialize(object.created,
          specifiedType: const FullType(DateTime)),
    ];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Card deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CardBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'brand':
          result.brand = serializers.deserialize(value,
              specifiedType: const FullType(CardBrand)) as CardBrand;
          break;
        case 'exp_month':
          result.expirationMonth = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'exp_year':
          result.expirationYear = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'fingerprint':
          result.fingerprint = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'livemode':
          result.livemode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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

class _$Card extends Card {
  @override
  final String id;
  @override
  final String name;
  @override
  final CardBrand brand;
  @override
  final int expirationMonth;
  @override
  final int expirationYear;
  @override
  final String fingerprint;
  @override
  final bool livemode;
  @override
  final DateTime created;

  factory _$Card([void Function(CardBuilder) updates]) =>
      (new CardBuilder()..update(updates)).build();

  _$Card._(
      {this.id,
      this.name,
      this.brand,
      this.expirationMonth,
      this.expirationYear,
      this.fingerprint,
      this.livemode,
      this.created})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Card', 'id');
    }
    if (brand == null) {
      throw new BuiltValueNullFieldError('Card', 'brand');
    }
    if (expirationMonth == null) {
      throw new BuiltValueNullFieldError('Card', 'expirationMonth');
    }
    if (expirationYear == null) {
      throw new BuiltValueNullFieldError('Card', 'expirationYear');
    }
    if (fingerprint == null) {
      throw new BuiltValueNullFieldError('Card', 'fingerprint');
    }
    if (livemode == null) {
      throw new BuiltValueNullFieldError('Card', 'livemode');
    }
    if (created == null) {
      throw new BuiltValueNullFieldError('Card', 'created');
    }
  }

  @override
  Card rebuild(void Function(CardBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CardBuilder toBuilder() => new CardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Card &&
        id == other.id &&
        name == other.name &&
        brand == other.brand &&
        expirationMonth == other.expirationMonth &&
        expirationYear == other.expirationYear &&
        fingerprint == other.fingerprint &&
        livemode == other.livemode &&
        created == other.created;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), name.hashCode),
                            brand.hashCode),
                        expirationMonth.hashCode),
                    expirationYear.hashCode),
                fingerprint.hashCode),
            livemode.hashCode),
        created.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Card')
          ..add('id', id)
          ..add('name', name)
          ..add('brand', brand)
          ..add('expirationMonth', expirationMonth)
          ..add('expirationYear', expirationYear)
          ..add('fingerprint', fingerprint)
          ..add('livemode', livemode)
          ..add('created', created))
        .toString();
  }
}

class CardBuilder implements Builder<Card, CardBuilder> {
  _$Card _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  CardBrand _brand;
  CardBrand get brand => _$this._brand;
  set brand(CardBrand brand) => _$this._brand = brand;

  int _expirationMonth;
  int get expirationMonth => _$this._expirationMonth;
  set expirationMonth(int expirationMonth) =>
      _$this._expirationMonth = expirationMonth;

  int _expirationYear;
  int get expirationYear => _$this._expirationYear;
  set expirationYear(int expirationYear) =>
      _$this._expirationYear = expirationYear;

  String _fingerprint;
  String get fingerprint => _$this._fingerprint;
  set fingerprint(String fingerprint) => _$this._fingerprint = fingerprint;

  bool _livemode;
  bool get livemode => _$this._livemode;
  set livemode(bool livemode) => _$this._livemode = livemode;

  DateTime _created;
  DateTime get created => _$this._created;
  set created(DateTime created) => _$this._created = created;

  CardBuilder();

  CardBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _brand = _$v.brand;
      _expirationMonth = _$v.expirationMonth;
      _expirationYear = _$v.expirationYear;
      _fingerprint = _$v.fingerprint;
      _livemode = _$v.livemode;
      _created = _$v.created;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Card other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Card;
  }

  @override
  void update(void Function(CardBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Card build() {
    final _$result = _$v ??
        new _$Card._(
            id: id,
            name: name,
            brand: brand,
            expirationMonth: expirationMonth,
            expirationYear: expirationYear,
            fingerprint: fingerprint,
            livemode: livemode,
            created: created);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
