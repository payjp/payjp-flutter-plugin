import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:payjp_flutter/card.dart';

part 'card_token.g.dart';

abstract class Token implements Built<Token, TokenBuilder> {
  String get id;
  bool get livemode;
  bool get used;
  Card get card;
  DateTime get created;

  Token._();
  factory Token([updates(TokenBuilder b)]) = _$Token;
  static Serializer<Token> get serializer => _$tokenSerializer;
}