/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

package jp.pay.flutter

import io.flutter.plugin.common.MethodChannel

internal fun MethodChannel.Result.pluginError(message: String, details: Any? = null) {
    error("payjp-plugin-error", message, details)
}