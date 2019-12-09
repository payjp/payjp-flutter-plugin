import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:payjp_flutter/payjp.dart';
import 'package:payjp_flutter/card_token.dart';
import 'package:payjp_flutter/card_form_status.dart';
import 'package:payjp_flutter_example/widgets/alert_dialog.dart';

const String payjpPublicKey = "pk_test_0383a1b8f91e8a6e3ea0e2a9";

void main() => runApp(MaterialApp(
  home: HomeScreen(),
));

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initPayjp();
  }

  Future<void> _initPayjp() async {
    await Payjp.configure(
        publicKey: payjpPublicKey,
        debugEnabled: true
    );
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

  void _onStartApplePay(BuildContext context) {
    // TODO: Apple Pay
    showAlertDialog(
        context: context,
        title: 'TODO',
        message: 'TODO: unimplemented'
    );
  }

  void _onCardFormCanceled() {
    print('_onCardFormCanceled');
  }

  void _onCardFormCompleted(Token token) {
    print('_onCardFormCompleted $token');
  }

  FutureOr<CardFormStatus> _onCardFormProducedToken(Token token) async {
    print('_onCardFormProducedToken');
    await Future.delayed(Duration(seconds: 2)); // TODO: send token to server
    return CardFormError('エラーです');
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
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
              )
          ),
          Card(
              child: ListTile(
                title: Text('Start ApplePay Sample (iOS only)'),
                enabled: Platform.isIOS,
                onTap: () => _onStartApplePay(context),
              )
          ),
        ],
      ),
    ),
  );
}
