// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Card extends Card {
  @override
  final String id;
  @override
  final String? object;
  @override
  final int? created;
  @override
  final String? name;
  @override
  final String? last4;
  @override
  final int? expMonth;
  @override
  final int? expYear;
  @override
  final CardBrand? brand;
  @override
  final String? cvcCheck;
  @override
  final String? threeDSecureStatus;
  @override
  final String? fingerprint;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? addressState;
  @override
  final String? addressCity;
  @override
  final String? addressLine1;
  @override
  final String? addressLine2;
  @override
  final String? country;
  @override
  final String? addressZip;
  @override
  final String? addressZipCheck;
  @override
  final String? customer;
  @override
  final JsonObject? metadata;

  factory _$Card([void Function(CardBuilder)? updates]) =>
      (new CardBuilder()..update(updates))._build();

  _$Card._(
      {required this.id,
      this.object,
      this.created,
      this.name,
      this.last4,
      this.expMonth,
      this.expYear,
      this.brand,
      this.cvcCheck,
      this.threeDSecureStatus,
      this.fingerprint,
      this.email,
      this.phone,
      this.addressState,
      this.addressCity,
      this.addressLine1,
      this.addressLine2,
      this.country,
      this.addressZip,
      this.addressZipCheck,
      this.customer,
      this.metadata})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Card', 'id');
  }

  @override
  Card rebuild(void Function(CardBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CardBuilder toBuilder() => new CardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Card &&
        id == other.id &&
        object == other.object &&
        created == other.created &&
        name == other.name &&
        last4 == other.last4 &&
        expMonth == other.expMonth &&
        expYear == other.expYear &&
        brand == other.brand &&
        cvcCheck == other.cvcCheck &&
        threeDSecureStatus == other.threeDSecureStatus &&
        fingerprint == other.fingerprint &&
        email == other.email &&
        phone == other.phone &&
        addressState == other.addressState &&
        addressCity == other.addressCity &&
        addressLine1 == other.addressLine1 &&
        addressLine2 == other.addressLine2 &&
        country == other.country &&
        addressZip == other.addressZip &&
        addressZipCheck == other.addressZipCheck &&
        customer == other.customer &&
        metadata == other.metadata;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, object.hashCode);
    _$hash = $jc(_$hash, created.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, last4.hashCode);
    _$hash = $jc(_$hash, expMonth.hashCode);
    _$hash = $jc(_$hash, expYear.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, cvcCheck.hashCode);
    _$hash = $jc(_$hash, threeDSecureStatus.hashCode);
    _$hash = $jc(_$hash, fingerprint.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, addressState.hashCode);
    _$hash = $jc(_$hash, addressCity.hashCode);
    _$hash = $jc(_$hash, addressLine1.hashCode);
    _$hash = $jc(_$hash, addressLine2.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, addressZip.hashCode);
    _$hash = $jc(_$hash, addressZipCheck.hashCode);
    _$hash = $jc(_$hash, customer.hashCode);
    _$hash = $jc(_$hash, metadata.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Card')
          ..add('id', id)
          ..add('object', object)
          ..add('created', created)
          ..add('name', name)
          ..add('last4', last4)
          ..add('expMonth', expMonth)
          ..add('expYear', expYear)
          ..add('brand', brand)
          ..add('cvcCheck', cvcCheck)
          ..add('threeDSecureStatus', threeDSecureStatus)
          ..add('fingerprint', fingerprint)
          ..add('email', email)
          ..add('phone', phone)
          ..add('addressState', addressState)
          ..add('addressCity', addressCity)
          ..add('addressLine1', addressLine1)
          ..add('addressLine2', addressLine2)
          ..add('country', country)
          ..add('addressZip', addressZip)
          ..add('addressZipCheck', addressZipCheck)
          ..add('customer', customer)
          ..add('metadata', metadata))
        .toString();
  }
}

class CardBuilder implements Builder<Card, CardBuilder> {
  _$Card? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _object;
  String? get object => _$this._object;
  set object(String? object) => _$this._object = object;

  int? _created;
  int? get created => _$this._created;
  set created(int? created) => _$this._created = created;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _last4;
  String? get last4 => _$this._last4;
  set last4(String? last4) => _$this._last4 = last4;

  int? _expMonth;
  int? get expMonth => _$this._expMonth;
  set expMonth(int? expMonth) => _$this._expMonth = expMonth;

  int? _expYear;
  int? get expYear => _$this._expYear;
  set expYear(int? expYear) => _$this._expYear = expYear;

  CardBrand? _brand;
  CardBrand? get brand => _$this._brand;
  set brand(CardBrand? brand) => _$this._brand = brand;

  String? _cvcCheck;
  String? get cvcCheck => _$this._cvcCheck;
  set cvcCheck(String? cvcCheck) => _$this._cvcCheck = cvcCheck;

  String? _threeDSecureStatus;
  String? get threeDSecureStatus => _$this._threeDSecureStatus;
  set threeDSecureStatus(String? threeDSecureStatus) =>
      _$this._threeDSecureStatus = threeDSecureStatus;

  String? _fingerprint;
  String? get fingerprint => _$this._fingerprint;
  set fingerprint(String? fingerprint) => _$this._fingerprint = fingerprint;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _addressState;
  String? get addressState => _$this._addressState;
  set addressState(String? addressState) => _$this._addressState = addressState;

  String? _addressCity;
  String? get addressCity => _$this._addressCity;
  set addressCity(String? addressCity) => _$this._addressCity = addressCity;

  String? _addressLine1;
  String? get addressLine1 => _$this._addressLine1;
  set addressLine1(String? addressLine1) => _$this._addressLine1 = addressLine1;

  String? _addressLine2;
  String? get addressLine2 => _$this._addressLine2;
  set addressLine2(String? addressLine2) => _$this._addressLine2 = addressLine2;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  String? _addressZip;
  String? get addressZip => _$this._addressZip;
  set addressZip(String? addressZip) => _$this._addressZip = addressZip;

  String? _addressZipCheck;
  String? get addressZipCheck => _$this._addressZipCheck;
  set addressZipCheck(String? addressZipCheck) =>
      _$this._addressZipCheck = addressZipCheck;

  String? _customer;
  String? get customer => _$this._customer;
  set customer(String? customer) => _$this._customer = customer;

  JsonObject? _metadata;
  JsonObject? get metadata => _$this._metadata;
  set metadata(JsonObject? metadata) => _$this._metadata = metadata;

  CardBuilder() {
    Card._initializeBuilder(this);
  }

  CardBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _object = $v.object;
      _created = $v.created;
      _name = $v.name;
      _last4 = $v.last4;
      _expMonth = $v.expMonth;
      _expYear = $v.expYear;
      _brand = $v.brand;
      _cvcCheck = $v.cvcCheck;
      _threeDSecureStatus = $v.threeDSecureStatus;
      _fingerprint = $v.fingerprint;
      _email = $v.email;
      _phone = $v.phone;
      _addressState = $v.addressState;
      _addressCity = $v.addressCity;
      _addressLine1 = $v.addressLine1;
      _addressLine2 = $v.addressLine2;
      _country = $v.country;
      _addressZip = $v.addressZip;
      _addressZipCheck = $v.addressZipCheck;
      _customer = $v.customer;
      _metadata = $v.metadata;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Card other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Card;
  }

  @override
  void update(void Function(CardBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Card build() => _build();

  _$Card _build() {
    final _$result = _$v ??
        new _$Card._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Card', 'id'),
            object: object,
            created: created,
            name: name,
            last4: last4,
            expMonth: expMonth,
            expYear: expYear,
            brand: brand,
            cvcCheck: cvcCheck,
            threeDSecureStatus: threeDSecureStatus,
            fingerprint: fingerprint,
            email: email,
            phone: phone,
            addressState: addressState,
            addressCity: addressCity,
            addressLine1: addressLine1,
            addressLine2: addressLine2,
            country: country,
            addressZip: addressZip,
            addressZipCheck: addressZipCheck,
            customer: customer,
            metadata: metadata);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
