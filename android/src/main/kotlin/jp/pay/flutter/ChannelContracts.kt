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

internal object ChannelContracts {

    const val INITIALIZE = "initialize"
    const val START_CARD_FORM = "startCardForm"
    const val SHOW_TOKEN_PROCESSING_ERROR = "showTokenProcessingError"
    const val COMPLETE_CARD_FORM = "completeCardForm"
    const val START_THREE_D_SECURE_PROCESS = "startThreeDSecureProcess"

    const val ON_CARD_FORM_COMPLETED = "onCardFormCompleted"
    const val ON_CARD_FORM_CANCELED = "onCardFormCanceled"
    const val ON_CARD_FORM_PRODUCED_TOKEN = "onCardFormProducedToken"
    const val ON_THREE_D_SECURE_PROCESS_FINISHED = "onThreeDSecureProcessFinished"
}