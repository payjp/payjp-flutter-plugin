//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'card_brand.g.dart';

class CardBrand extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Visa')
  static const CardBrand visa = _$visa;
  @BuiltValueEnumConst(wireName: r'MasterCard')
  static const CardBrand masterCard = _$masterCard;
  @BuiltValueEnumConst(wireName: r'JCB')
  static const CardBrand JCB = _$JCB;
  @BuiltValueEnumConst(wireName: r'American Express')
  static const CardBrand americanExpress = _$americanExpress;
  @BuiltValueEnumConst(wireName: r'Diners Club')
  static const CardBrand dinersClub = _$dinersClub;
  @BuiltValueEnumConst(wireName: r'Discover')
  static const CardBrand discover = _$discover;

  static Serializer<CardBrand> get serializer => _$cardBrandSerializer;

  const CardBrand._(String name) : super(name);

  static BuiltSet<CardBrand> get values => _$values;
  static CardBrand valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class CardBrandMixin = Object with _$CardBrandMixin;

// ignore_for_file: constant_identifier_names,non_constant_identifier_names