/// Extra attributes for card form.
/// For now it is mainly used for 3-D Secure.
/// see [https://help.pay.jp/ja/articles/9556161]
sealed class ExtraAttribute {}

/// Email attribute.
/// [preset] Preset email address.
class ExtraAttributeEmail extends ExtraAttribute {
  final String? preset;

  ExtraAttributeEmail([this.preset]);
}

/// Phone attribute.
/// [presetRegion] Preset phone number region.
/// [presetNumber] Preset phone number.
class ExtraAttributePhone extends ExtraAttribute {
  final String? presetRegion;
  final String? presetNumber;

  ExtraAttributePhone([this.presetRegion, this.presetNumber]);
}
