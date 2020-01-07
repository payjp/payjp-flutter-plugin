import 'package:built_value/serializer.dart';
import 'package:payjp_flutter/card.dart';
import 'package:payjp_flutter/card_token.dart';
import 'package:payjp_flutter/error_info.dart';

part 'serializers.g.dart';

@SerializersFor([
  CardBrand,
  Card,
  Token,
  ErrorInfo
])
final Serializers serializers = _$serializers;