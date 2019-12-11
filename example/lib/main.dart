import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:payjp_flutter/card_form_status.dart';
import 'package:payjp_flutter/card_token.dart';
import 'package:payjp_flutter/payjp.dart';

import 'sample_backend_service.dart';
import 'widgets/alert_dialog.dart';

const String payjpPublicKey = "pk_test_0383a1b8f91e8a6e3ea0e2a9";

void main() => runApp(MaterialApp(
      home: HomeScreen(),
    ));

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initPayjp();
  }

  Future<void> _initPayjp() async {
    await Payjp.configure(publicKey: payjpPublicKey, debugEnabled: true);
    setState(() {
      _isLoading = false;
    });
  }

  void _onStartCardForm() async {
    await Payjp.startCardForm(
      onCardFormCanceledCallback: _onCardFormCanceled,
      onCardFormCompletedCallback: _onCardFormCompleted,
      onCardFormProducedTokenCallback: _onCardFormProducedToken,
    );
  }

  void _onStartApplePay() {
    // TODO: Apple Pay
    showAlertDialog(
        context: HomeScreen.scaffoldKey.currentContext,
        title: 'TODO',
        message: 'TODO: unimplemented');
  }

  void _onCardFormCanceled() {
    print('_onCardFormCanceled');
    showAlertDialog(
        context: HomeScreen.scaffoldKey.currentContext,
        title: 'カード登録',
        message: 'カード登録をキャンセルしました。');
  }

  void _onCardFormCompleted(Token token) {
    print('_onCardFormCompleted $token');
    showAlertDialog(
        context: HomeScreen.scaffoldKey.currentContext,
        title: 'カード登録',
        message: 'カードを登録しました。\nid: ${token.id}');
  }

  FutureOr<CardFormStatus> _onCardFormProducedToken(Token token) async {
    print('_onCardFormProducedToken');
    if (backendUrl.isEmpty) {
      final message = """
`backendUrl` is not replaced yet.
You can send token(${token.id}) to your own server to make Customer etc.
       """;
      print(message);
      return CardFormComplete();
    }
    try {
      await saveCard(token);
    } on ApiException catch (e) {
      return CardFormError(e.message);
    }
    return CardFormComplete();
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
                    Card(
                        child: ListTile(
                      title: Text('CardForm Sample'),
                      subtitle: Text('Tap here to start card form.'),
                      onTap: _onStartCardForm,
                    )),
                    Card(
                        child: ListTile(
                      title: Text('Start ApplePay Sample (iOS only)'),
                      enabled: Platform.isIOS,
                      onTap: _onStartApplePay,
                    )),
                  ],
                ),
        ),
      );
}
