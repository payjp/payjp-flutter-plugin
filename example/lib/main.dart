/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart' hide Card;
import 'package:flutter/material.dart' as material show Card;
import 'package:payjp_flutter/payjp_flutter.dart';

import 'sample_backend_service.dart';
import 'widgets/alert_dialog.dart';

// TODO: REPLACE WITH YOUR PAYJP Public key
const String payjpPublicKey = "pk_test_0383a1b8f91e8a6e3ea0e2a9";

const String appleMerchantId =
    'merchant.jp.pay.example2'; // TODO: REPLACE WITH YOUR APPLE MERCHANT ID

void main() => runApp(MaterialApp(
      home: HomeScreen(),
    ));

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  bool _canUseApplePay = false;

  @override
  void initState() {
    super.initState();
    _initPayjp();
  }

  Future<void> _initPayjp() async {
    await Payjp.init(
        publicKey: payjpPublicKey,
        debugEnabled: true,
        threeDSecureRedirect: PayjpThreeDSecureRedirect(
            url: 'jp.pay.example://tds/finish', key: 'mobileapp'));
    var isApplePayAvailable = false;
    if (Platform.isIOS) {
      await Payjp.setIOSCardFormStyle(
        labelTextColor: Colors.black87,
        inputTextColor: Colors.blue[700],
        errorTextColor: Colors.red,
        submitButtonColor: Colors.blue[800],
      );
      isApplePayAvailable = await Payjp.isApplePayAvailable();
    }
    setState(() {
      _isLoading = false;
      _canUseApplePay = isApplePayAvailable;
    });
  }

  void _onStartCardForm({required CardFormType formType}) async {
    await Payjp.startCardForm(
        onCardFormCanceledCallback: _onCardFormCanceled,
        onCardFormCompletedCallback: _onCardFormCompleted,
        onCardFormProducedTokenCallback: _onCardFormProducedToken,
        cardFormType: formType);
  }

  void _onStartApplePay() async {
    await Payjp.makeApplePayToken(
      appleMerchantId: appleMerchantId,
      currencyCode: 'JPY',
      countryCode: 'JP',
      summaryItemLabel: 'PAY.JP T-shirt',
      summaryItemAmount: '100',
      requiredBillingAddress: false,
      onApplePayProducedTokenCallback: _onApplePayProducedToken,
      onApplePayFailedRequestTokenCallback: _onApplePayFailedRequestToken,
      onApplePayCompletedCallback: _onApplePayCompleted,
    );
  }

  void _onCardFormCanceled() {
    print('_onCardFormCanceled');
  }

  void _onCardFormCompleted() {
    print('_onCardFormCompleted');
    showAlertDialog(
        context: HomeScreen.scaffoldKey.currentContext!,
        title: 'カード登録',
        message: 'カードを登録しました。');
  }

  FutureOr<CallbackResult> _onCardFormProducedToken(Token token) async {
    print('_onCardFormProducedToken');
    if (backendUrl.isEmpty) {
      final message = """
`backendUrl` is not replaced yet.
You can send token(${token.id}) to your own server to make Customer etc.
       """;
      print(message);
      return CallbackResultOk();
    }
    try {
      await saveCard(token);
    } on ApiException catch (e) {
      return CallbackResultError(e.message);
    }
    return CallbackResultOk();
  }

  FutureOr<CallbackResult> _onApplePayProducedToken(Token token) async {
    print('_onApplePayProducedToken');
    if (backendUrl.isEmpty) {
      final message = """
`backendUrl` is not replaced yet.
You can send token(${token.id}) to your own server to make Customer etc.
       """;
      print(message);
      return CallbackResultOk();
    }
    try {
      await saveCard(token);
    } on ApiException catch (e) {
      return CallbackResultError(e.message);
    }
    return CallbackResultOk();
  }

  FutureOr<CallbackResultError> _onApplePayFailedRequestToken(
      ErrorInfo errorInfo) async {
    print('_onApplePayFailedRequestToken');
    print('errorCode ${errorInfo.errorCode}');
    print('errorMessage ${errorInfo.errorMessage}');
    return CallbackResultError(errorInfo.errorMessage);
  }

  void _onApplePayCompleted() {
    print('onApplePayCompleted');
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          key: HomeScreen.scaffoldKey,
          appBar: AppBar(
            title: const Text('PAY.JP Flutter Plugin Sample'),
          ),
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: <Widget>[
                    material.Card(
                        child: ListTile(
                      title: Text('CardForm Sample (MultiLine)'),
                      subtitle: Text('Tap here to start card form.'),
                      onTap: () {
                        _onStartCardForm(formType: CardFormType.multiLine);
                      },
                    )),
                    material.Card(
                        child: ListTile(
                      title: Text('CardForm Sample (CardDisplay)'),
                      subtitle: Text('Tap here to start card form.'),
                      onTap: () {
                        _onStartCardForm(formType: CardFormType.cardDisplay);
                      },
                    )),
                    material.Card(
                        child: ListTile(
                      title: Text('Start ApplePay Sample (iOS only)'),
                      subtitle: Text(_canUseApplePay
                          ? 'Sample payment with Apple Pay.'
                          : 'This device is not supported.'),
                      enabled: _canUseApplePay,
                      onTap: _onStartApplePay,
                    )),
                  ],
                ),
        ),
      );
}
