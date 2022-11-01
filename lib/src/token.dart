//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:payjp_flutter/src/card.dart';

part 'token.g.dart';

/// Token
///
/// Properties:
/// * [id] - tok_で始まる一意なオブジェクトを示す文字列
/// * [card]
/// * [created] - このトークン作成時のタイムスタンプ
/// * [livemode] - 本番環境かどうか
/// * [object] - \\\"token\\\"の固定文字列
/// * [used] - このトークンが使用済みかどうか
abstract class Token implements Built<Token, TokenBuilder> {
  /// tok_で始まる一意なオブジェクトを示す文字列
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'card')
  Card get card;

  /// このトークン作成時のタイムスタンプ
  @BuiltValueField(wireName: r'created')
  int get created;

  /// 本番環境かどうか
  @BuiltValueField(wireName: r'livemode')
  bool get livemode;

  /// \\\"token\\\"の固定文字列
  @BuiltValueField(wireName: r'object')
  String get object;

  /// このトークンが使用済みかどうか
  @BuiltValueField(wireName: r'used')
  bool get used;

  Token._();

  static void _initializeBuilder(TokenBuilder b) => b;

  factory Token([void updates(TokenBuilder b)]) = _$Token;

  @BuiltValueSerializer(custom: true)
  static Serializer<Token> get serializer => _$TokenSerializer();
}

class _$TokenSerializer implements StructuredSerializer<Token> {
  @override
  final Iterable<Type> types = const [Token, _$Token];

  @override
  final String wireName = r'Token';

  @override
  Iterable<Object?> serialize(Serializers serializers, Token object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'id')
      ..add(serializers.serialize(object.id,
          specifiedType: const FullType(String)));
    result
      ..add(r'card')
      ..add(serializers.serialize(object.card,
          specifiedType: const FullType(Card)));
    result
      ..add(r'created')
      ..add(serializers.serialize(object.created,
          specifiedType: const FullType(int)));
    result
      ..add(r'livemode')
      ..add(serializers.serialize(object.livemode,
          specifiedType: const FullType(bool)));
    result
      ..add(r'object')
      ..add(serializers.serialize(object.object,
          specifiedType: const FullType(String)));
    result
      ..add(r'used')
      ..add(serializers.serialize(object.used,
          specifiedType: const FullType(bool)));
    return result;
  }

  @override
  Token deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = TokenBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      // ignore: omit_local_variable_types
      final Object? value = iterator.current;
      switch (key) {
        case r'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'card':
          result.card.replace(serializers.deserialize(value,
              specifiedType: const FullType(Card)) as Card);
          break;
        case r'created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case r'livemode':
          result.livemode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case r'object':
          result.object = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'used':
          result.used = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }
    return result.build();
  }
}
