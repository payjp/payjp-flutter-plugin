/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog(
    {required BuildContext context,
    required String title,
    required String message,
    String button = "OK"}) {
  final titleText = Text(title);
  final content = SingleChildScrollView(
    child: Text(message),
  );
  final buttonText = Text(button);
  if (Platform.isIOS) {
    return showCupertinoDialog<void>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: titleText,
              content: content,
              actions: <Widget>[
                CupertinoDialogAction(
                  child: buttonText,
                  onPressed: () => Navigator.of(context)?.pop(),
                )
              ],
            ));
  } else {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              title: titleText,
              content: content,
              actions: <Widget>[
                FlatButton(
                  child: buttonText,
                  onPressed: () => Navigator.of(context)?.pop(),
                ),
              ],
            ));
  }
}
