import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'card.g.dart';

class CardBrand extends EnumClass {
  static Serializer<CardBrand> get serializer => _$cardBrandSerializer;
  @BuiltValueEnumConst(wireName: 'Visa')
  static const CardBrand visa = _$visa;
  @BuiltValueEnumConst(wireName: 'MasterCard')
  static const CardBrand mastercard = _$mastercard;
  @BuiltValueEnumConst(wireName: 'JCB')
  static const CardBrand jcb = _$jcb;
  @BuiltValueEnumConst(wireName: 'American Express')
  static const CardBrand amex = _$amex;
  @BuiltValueEnumConst(wireName: 'Diners Club')
  static const CardBrand dinersClub = _$dinersClub;
  @BuiltValueEnumConst(wireName: 'Discover')
  static const CardBrand discover = _$discover;
  @BuiltValueEnumConst(wireName: 'Unknown')
  static const CardBrand unknown = _$unknown;

  const CardBrand._(String name): super(name);

  static BuiltSet<CardBrand> get values => _$cardBrandValues;
  static CardBrand valueOf(String name) => _$cardBrandValueOf(name);
}

abstract class Card implements Built<Card, CardBuilder> {
  String get id;
  @nullable
  String get name;
  CardBrand get brand;
  int get expirationMonth;
  int get expirationYear;
  String get fingerprint;
  bool get livemode;
  DateTime get created;

  Card._();
  factory Card([updates(CardBuilder b)]) = _$Card;
  static Serializer<Card> get serializer => _$cardSerializer;
}
