// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_brand.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CardBrand _$visa = const CardBrand._('visa');
const CardBrand _$masterCard = const CardBrand._('masterCard');
const CardBrand _$JCB = const CardBrand._('JCB');
const CardBrand _$americanExpress = const CardBrand._('americanExpress');
const CardBrand _$dinersClub = const CardBrand._('dinersClub');
const CardBrand _$discover = const CardBrand._('discover');

CardBrand _$valueOf(String name) {
  switch (name) {
    case 'visa':
      return _$visa;
    case 'masterCard':
      return _$masterCard;
    case 'JCB':
      return _$JCB;
    case 'americanExpress':
      return _$americanExpress;
    case 'dinersClub':
      return _$dinersClub;
    case 'discover':
      return _$discover;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<CardBrand> _$values = new BuiltSet<CardBrand>(const <CardBrand>[
  _$visa,
  _$masterCard,
  _$JCB,
  _$americanExpress,
  _$dinersClub,
  _$discover,
]);

class _$CardBrandMeta {
  const _$CardBrandMeta();
  CardBrand get visa => _$visa;
  CardBrand get masterCard => _$masterCard;
  CardBrand get JCB => _$JCB;
  CardBrand get americanExpress => _$americanExpress;
  CardBrand get dinersClub => _$dinersClub;
  CardBrand get discover => _$discover;
  CardBrand valueOf(String name) => _$valueOf(name);
  BuiltSet<CardBrand> get values => _$values;
}

abstract class _$CardBrandMixin {
  _$CardBrandMeta get CardBrand => const _$CardBrandMeta();
}

Serializer<CardBrand> _$cardBrandSerializer = new _$CardBrandSerializer();

class _$CardBrandSerializer implements PrimitiveSerializer<CardBrand> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'visa': 'Visa',
    'masterCard': 'MasterCard',
    'JCB': 'JCB',
    'americanExpress': 'American Express',
    'dinersClub': 'Diners Club',
    'discover': 'Discover',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Visa': 'visa',
    'MasterCard': 'masterCard',
    'JCB': 'JCB',
    'American Express': 'americanExpress',
    'Diners Club': 'dinersClub',
    'Discover': 'discover',
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
      CardBrand.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,constant_identifier_names,non_constant_identifier_names
