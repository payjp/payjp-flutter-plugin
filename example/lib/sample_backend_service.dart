import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:payjp_flutter/card_token.dart';
import 'package:http/http.dart' as http;

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
  try {
    final formData = { "card": token.id };
    var response = await http.post(backendUrl, body: formData);
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