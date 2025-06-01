/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

import 'package:flutter/material.dart';
import 'package:payjp_flutter/payjp_flutter.dart' hide Card;
import 'package:url_launcher/url_launcher.dart';

import '../widgets/alert_dialog.dart';

class ThreeDSecureScreen extends StatefulWidget {
  @override
  _ThreeDSecureScreenState createState() => _ThreeDSecureScreenState();
}

class _ThreeDSecureScreenState extends State<ThreeDSecureScreen> {
  final TextEditingController _resourceIdController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _resourceIdController.dispose();
    super.dispose();
  }

  void _startThreeDSecure() async {
    final resourceId = _resourceIdController.text.trim();
    if (resourceId.isEmpty) {
      showAlertDialog(
        context: context,
        title: 'エラー',
        message: 'リソースIDを入力してください',
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    await Payjp.startThreeDSecure(
      resourceId: resourceId,
      onThreeDSecureProcessFinished: _onThreeDSecureSucceeded,
    );

    setState(() {
      _isProcessing = false;
    });
  }

  void _onThreeDSecureSucceeded(ThreeDSecureProcessStatus status) {
    String message;
    Color? backgroundColor;
    Color? textColor;

    if (status == ThreeDSecureProcessStatus.completed) {
      message =
          '3Dセキュア認証が完了しました。\nこの結果をサーバーサイドに伝え、完了処理や結果のハンドリングを行なってください。\n後続処理の実装方法に関してはドキュメントをご参照ください。';
      backgroundColor = Colors.green;
      textColor = Colors.white;
    } else if (status == ThreeDSecureProcessStatus.canceled) {
      message = '3Dセキュア認証がキャンセルされました';
      backgroundColor = Colors.yellow;
      textColor = Colors.black;
    } else {
      message = '3Dセキュア認証が失敗しました';
      backgroundColor = Colors.red;
      textColor = Colors.white;
    }

    showAlertDialog(
      context: context,
      title: '3Dセキュア認証',
      message: message,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3Dセキュア'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'リソースID',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _resourceIdController,
                        decoration: InputDecoration(
                          hintText: 'リソースIDを入力',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        enabled: !_isProcessing,
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.lock, color: Colors.white),
                          label: Text(
                            '3Dセキュア認証を開始',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _isProcessing ? null : _startThreeDSecure,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800],
                            padding: EdgeInsets.symmetric(vertical: 12),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                '手順',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildStepItem(
                '1',
                '下記を参考に、先にサーバーサイドで支払い、または3Dセキュアリクエストを作成してください。',
                [
                  '支払い作成時の3Dセキュア:',
                  'https://pay.jp/docs/charge-tds',
                  '顧客カードに対する3Dセキュア:',
                  'https://pay.jp/docs/customer-card-tds',
                ],
              ),
              SizedBox(height: 16),
              _buildStepItem(
                '2',
                '作成したリソースのIDを上記に入力して3Dセキュアを開始してください。',
                [],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: prefer_expression_function_bodies
  Widget _buildStepItem(String number, String title, List<String> links) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              if (links.isNotEmpty) ...[
                SizedBox(height: 8),
                ...links.map((link) => link.startsWith('http')
                    ? GestureDetector(
                        onTap: () => _launchURL(link),
                        child: Text(
                          link,
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    : Text(link)),
              ]
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _launchURL(String urlString) async {
    final url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      showAlertDialog(
        context: context,
        title: 'エラー',
        message: 'URLを開けませんでした: $urlString',
      );
    }
  }
}
