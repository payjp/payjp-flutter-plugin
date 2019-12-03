import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog({
  BuildContext context,
  String title,
  String message,
  String button = "OK"
}) {
  final titleText = Text(title);
  final content = SingleChildScrollView(
    child: Text(message),
  );
  final buttonText = Text(button);
  onPressed() {
    Navigator.pop(context);
  };
  if (Platform.isIOS) {
    return showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: titleText,
        content: content,
        actions: <Widget>[
          CupertinoDialogAction(
            child: buttonText,
            onPressed: onPressed,
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
            onPressed: onPressed,
          ),
        ],
      ));
  }
}