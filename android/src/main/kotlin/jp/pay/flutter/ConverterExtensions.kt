package jp.pay.flutter

import jp.pay.android.model.Card
import jp.pay.android.model.Token

internal fun Card.toMap(): Map<String, Any?> = linkedMapOf(
    "id" to id,
    "name" to name,
    "last4" to last4,
    "brand" to brand.rawValue,
    "exp_month" to expirationMonth,
    "exp_year" to expirationYear,
    "fingerprint" to fingerprint,
    "livemode" to livemode,
    "created" to created.time
)

internal fun Token.toMap(): Map<String, Any?> = linkedMapOf(
    "id" to id,
    "livemode" to livemode,
    "used" to used,
    "card" to card.toMap(),
    "created" to created.time
)