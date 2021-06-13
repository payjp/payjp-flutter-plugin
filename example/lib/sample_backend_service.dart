/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:payjp_flutter/payjp_flutter.dart';

///
/// TODO: REPLACE WITH YOUR ENDPOINT URL
/// You can set up sample server api with following repo.
/// https://github.com/payjp/example-tokenize-backend
/// (If you deploy the sample server app to Heroku, the url will be like
/// `https://[your_app_name].herokuapp.com/save_card`)
///
/// See the link above for more details.
///
const String backendUrl = '';

class ApiException implements Exception {
  String message;
  ApiException(this.message);
}

Future<void> saveCard(Token token) async {
  if (backendUrl.isEmpty) {
    final message = """
`backendUrl` is not replaced yet.
You can send token(${token.id}) to your own server to make Customer etc.
       """;
    print(message);
    return;
  }
  try {
    final formData = {"card": token.id};
    var response = await http.post(Uri.parse(backendUrl), body: formData);
    final body = json.decode(response.body);
    print(body);
    if (response.statusCode >= 400) {
      throw ApiException(body['message']);
    }
  } on SocketException catch (e) {
    print(e);
    throw ApiException(e.message);
  }
}
