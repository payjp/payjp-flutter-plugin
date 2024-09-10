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

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
