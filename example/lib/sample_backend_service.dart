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
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:payjp_flutter/card_token.dart';

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
    final formData = {"card": token.id};
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
