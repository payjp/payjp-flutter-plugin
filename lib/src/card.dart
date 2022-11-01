//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:payjp_flutter/src/card_brand.dart';

part 'card.g.dart';

/// Card
///
/// Properties:
/// * [id] - car_で始まり一意なオブジェクトを示す、最大32桁の文字列
/// * [object] - \\\"card\\\"の固定文字列
/// * [created] - カード作成時のタイムスタンプ
/// * [name] - カード保有者名
/// * [last4] - カード番号の下四桁
/// * [expMonth] - 有効期限月
/// * [expYear] - 有効期限年
/// * [brand]
/// * [cvcCheck] - CVCコードチェックの結果
/// * [threeDSecureStatus] - 3Dセキュアの実施結果。 加盟店において3Dセキュアが有効でない等未実施の場合null。
/// * [fingerprint] - このクレジットカード番号に紐づく値。 同一番号のカードからは同一の値が生成されることが保証されており、 トークン化の度にトークンIDは変わりますが、この値は変わりません。
/// * [addressState] - 都道府県
/// * [addressCity] - 市区町村
/// * [addressLine1] - 番地など
/// * [addressLine2] - 建物名など
/// * [country] - 2桁のISOコード(e.g. JP)
/// * [addressZip] - 郵便番号
/// * [addressZipCheck] - 郵便番号存在チェックの結果
/// * [customer] - 顧客オブジェクトのID
/// * [metadata] - キーバリューの任意データ
abstract class Card implements Built<Card, CardBuilder> {
  /// car_で始まり一意なオブジェクトを示す、最大32桁の文字列
  @BuiltValueField(wireName: r'id')
  String get id;

  /// \\\"card\\\"の固定文字列
  @BuiltValueField(wireName: r'object')
  String? get object;

  /// カード作成時のタイムスタンプ
  @BuiltValueField(wireName: r'created')
  int? get created;

  /// カード保有者名
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// カード番号の下四桁
  @BuiltValueField(wireName: r'last4')
  String? get last4;

  /// 有効期限月
  @BuiltValueField(wireName: r'exp_month')
  int? get expMonth;

  /// 有効期限年
  @BuiltValueField(wireName: r'exp_year')
  int? get expYear;

  @BuiltValueField(wireName: r'brand')
  CardBrand? get brand;
  // enum brandEnum {  Visa,  MasterCard,  JCB,  American Express,  Diners Club,  Discover,  };

  /// CVCコードチェックの結果
  @BuiltValueField(wireName: r'cvc_check')
  String? get cvcCheck;

  /// 3Dセキュアの実施結果。 加盟店において3Dセキュアが有効でない等未実施の場合null。
  @BuiltValueField(wireName: r'three_d_secure_status')
  String? get threeDSecureStatus;

  /// このクレジットカード番号に紐づく値。 同一番号のカードからは同一の値が生成されることが保証されており、 トークン化の度にトークンIDは変わりますが、この値は変わりません。
  @BuiltValueField(wireName: r'fingerprint')
  String? get fingerprint;

  /// 都道府県
  @BuiltValueField(wireName: r'address_state')
  String? get addressState;

  /// 市区町村
  @BuiltValueField(wireName: r'address_city')
  String? get addressCity;

  /// 番地など
  @BuiltValueField(wireName: r'address_line1')
  String? get addressLine1;

  /// 建物名など
  @BuiltValueField(wireName: r'address_line2')
  String? get addressLine2;

  /// 2桁のISOコード(e.g. JP)
  @BuiltValueField(wireName: r'country')
  String? get country;

  /// 郵便番号
  @BuiltValueField(wireName: r'address_zip')
  String? get addressZip;

  /// 郵便番号存在チェックの結果
  @BuiltValueField(wireName: r'address_zip_check')
  String? get addressZipCheck;

  /// 顧客オブジェクトのID
  @BuiltValueField(wireName: r'customer')
  String? get customer;

  /// キーバリューの任意データ
  @BuiltValueField(wireName: r'metadata')
  JsonObject? get metadata;

  Card._();

  static void _initializeBuilder(CardBuilder b) => b;

  factory Card([void updates(CardBuilder b)]) = _$Card;

  @BuiltValueSerializer(custom: true)
  static Serializer<Card> get serializer => _$CardSerializer();
}

class _$CardSerializer implements StructuredSerializer<Card> {
  @override
  final Iterable<Type> types = const [Card, _$Card];

  @override
  final String wireName = r'Card';

  @override
  Iterable<Object?> serialize(Serializers serializers, Card object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'id')
      ..add(serializers.serialize(object.id,
          specifiedType: const FullType(String)));
    if (object.object != null) {
      result
        ..add(r'object')
        ..add(serializers.serialize(object.object,
            specifiedType: const FullType(String)));
    }
    if (object.created != null) {
      result
        ..add(r'created')
        ..add(serializers.serialize(object.created,
            specifiedType: const FullType(int)));
    }
    if (object.name != null) {
      result
        ..add(r'name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.last4 != null) {
      result
        ..add(r'last4')
        ..add(serializers.serialize(object.last4,
            specifiedType: const FullType(String)));
    }
    if (object.expMonth != null) {
      result
        ..add(r'exp_month')
        ..add(serializers.serialize(object.expMonth,
            specifiedType: const FullType(int)));
    }
    if (object.expYear != null) {
      result
        ..add(r'exp_year')
        ..add(serializers.serialize(object.expYear,
            specifiedType: const FullType(int)));
    }
    if (object.brand != null) {
      result
        ..add(r'brand')
        ..add(serializers.serialize(object.brand,
            specifiedType: const FullType(CardBrand)));
    }
    if (object.cvcCheck != null) {
      result
        ..add(r'cvc_check')
        ..add(serializers.serialize(object.cvcCheck,
            specifiedType: const FullType(String)));
    }
    if (object.threeDSecureStatus != null) {
      result
        ..add(r'three_d_secure_status')
        ..add(serializers.serialize(object.threeDSecureStatus,
            specifiedType: const FullType(String)));
    }
    if (object.fingerprint != null) {
      result
        ..add(r'fingerprint')
        ..add(serializers.serialize(object.fingerprint,
            specifiedType: const FullType(String)));
    }
    if (object.addressState != null) {
      result
        ..add(r'address_state')
        ..add(serializers.serialize(object.addressState,
            specifiedType: const FullType(String)));
    }
    if (object.addressCity != null) {
      result
        ..add(r'address_city')
        ..add(serializers.serialize(object.addressCity,
            specifiedType: const FullType(String)));
    }
    if (object.addressLine1 != null) {
      result
        ..add(r'address_line1')
        ..add(serializers.serialize(object.addressLine1,
            specifiedType: const FullType(String)));
    }
    if (object.addressLine2 != null) {
      result
        ..add(r'address_line2')
        ..add(serializers.serialize(object.addressLine2,
            specifiedType: const FullType(String)));
    }
    if (object.country != null) {
      result
        ..add(r'country')
        ..add(serializers.serialize(object.country,
            specifiedType: const FullType(String)));
    }
    if (object.addressZip != null) {
      result
        ..add(r'address_zip')
        ..add(serializers.serialize(object.addressZip,
            specifiedType: const FullType(String)));
    }
    if (object.addressZipCheck != null) {
      result
        ..add(r'address_zip_check')
        ..add(serializers.serialize(object.addressZipCheck,
            specifiedType: const FullType(String)));
    }
    if (object.customer != null) {
      result
        ..add(r'customer')
        ..add(serializers.serialize(object.customer,
            specifiedType: const FullType(String)));
    }
    if (object.metadata != null) {
      result
        ..add(r'metadata')
        ..add(serializers.serialize(object.metadata,
            specifiedType: const FullType(JsonObject)));
    }
    return result;
  }

  @override
  Card deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = CardBuilder();

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
        case r'object':
          result.object = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case r'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'last4':
          result.last4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'exp_month':
          result.expMonth = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case r'exp_year':
          result.expYear = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case r'brand':
          result.brand = serializers.deserialize(value,
              specifiedType: const FullType(CardBrand)) as CardBrand;
          break;
        case r'cvc_check':
          result.cvcCheck = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'three_d_secure_status':
          result.threeDSecureStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'fingerprint':
          result.fingerprint = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'address_state':
          result.addressState = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'address_city':
          result.addressCity = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'address_line1':
          result.addressLine1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'address_line2':
          result.addressLine2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'country':
          result.country = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'address_zip':
          result.addressZip = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'address_zip_check':
          result.addressZipCheck = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'customer':
          result.customer = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case r'metadata':
          result.metadata = serializers.deserialize(value,
              specifiedType: const FullType(JsonObject)) as JsonObject;
          break;
      }
    }
    return result.build();
  }
}
