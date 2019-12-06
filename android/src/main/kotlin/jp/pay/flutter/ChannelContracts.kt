package jp.pay.flutter

internal object ChannelContracts {

    const val CONFIGURE = "configure"
    const val START_CARD_FORM = "startCardForm"
    const val SHOW_TOKEN_PROCESSING_ERROR = "showTokenProcessingError"
    const val COMPLETE_CARD_FORM = "completeCardForm"

    const val ON_CARD_FORM_COMPLETED = "onCardFormCompleted"
    const val ON_CARD_FORM_CANCELED = "onCardFormCanceled"
    const val ON_CARD_FORM_PRODUCED_TOKEN = "onCardFormProducedToken"
}