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

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart' hide Card;
import 'package:flutter/material.dart' as material show Card;
import 'package:payjp_flutter/payjp.dart';

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
    await Payjp.init(publicKey: payjpPublicKey, debugEnabled: true);
    var isApplePayAvailable = false;
    if (Platform.isIOS) {
      isApplePayAvailable = await Payjp.isApplePayAvailable();
    }
    setState(() {
      _isLoading = false;
      _canUseApplePay = isApplePayAvailable;
    });
  }

  void _onStartCardForm() async {
    await Payjp.startCardForm(
      onCardFormCanceledCallback: _onCardFormCanceled,
      onCardFormCompletedCallback: _onCardFormCompleted,
      onCardFormProducedTokenCallback: _onCardFormProducedToken,
    );
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
    showAlertDialog(
        context: HomeScreen.scaffoldKey.currentContext,
        title: 'カード登録',
        message: 'カード登録をキャンセルしました。');
  }

  void _onCardFormCompleted() {
    print('_onCardFormCompleted');
    showAlertDialog(
        context: HomeScreen.scaffoldKey.currentContext,
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
                      title: Text('CardForm Sample'),
                      subtitle: Text('Tap here to start card form.'),
                      onTap: _onStartCardForm,
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
