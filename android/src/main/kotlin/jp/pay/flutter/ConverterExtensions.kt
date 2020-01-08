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