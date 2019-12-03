import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:payjp_flutter/payjp.dart';
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
    await Payjp.startCardForm(null);
  }

  void _onStartApplePay(BuildContext context) {
    // TODO: Apple Pay
    showAlertDialog(
        context: context,
        title: 'TODO',
        message: 'TODO: unimplemented'
    );
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
