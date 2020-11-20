/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

/// Redirect configuration for 3D Secure.
/// Register in [PAY.JP dashboard](https://pay.jp/d/settings).
class PayjpThreeDSecureRedirect {
  final String url;
  final String key;
  PayjpThreeDSecureRedirect({required this.url, required this.key});
}
