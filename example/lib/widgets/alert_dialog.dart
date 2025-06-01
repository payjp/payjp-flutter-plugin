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
    String button = "OK",
    Color? backgroundColor,
    Color? textColor}) {
  final titleText = Text(
    title,
    style: textColor != null ? TextStyle(color: textColor) : null,
  );
  final content = SingleChildScrollView(
    child: Text(
      message,
      style: textColor != null ? TextStyle(color: textColor) : null,
    ),
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
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ));
  } else {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              backgroundColor: backgroundColor,
              title: titleText,
              content: content,
              actions: <Widget>[
                TextButton(
                  child: buttonText,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ));
  }
}
