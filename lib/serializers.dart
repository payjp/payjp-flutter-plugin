import 'package:built_value/serializer.dart';
import 'package:payjp_flutter/card.dart';
import 'package:payjp_flutter/card_token.dart';

part 'serializers.g.dart';

@SerializersFor([
  CardBrand,
  Card,
  Token
])
final Serializers serializers = _$serializers;