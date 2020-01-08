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

  const CardBrand._(String name) : super(name);

  static BuiltSet<CardBrand> get values => _$cardBrandValues;
  static CardBrand valueOf(String name) => _$cardBrandValueOf(name);
}

abstract class Card implements Built<Card, CardBuilder> {
  String get id;
  @nullable
  String get name;
  CardBrand get brand;
  @BuiltValueField(wireName: "exp_month")
  int get expirationMonth;
  @BuiltValueField(wireName: "exp_year")
  int get expirationYear;
  String get fingerprint;
  bool get livemode;
  DateTime get created;

  Card._();
  factory Card([updates(CardBuilder b)]) = _$Card;
  static Serializer<Card> get serializer => _$cardSerializer;
}
