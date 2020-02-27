/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

Future<void> main() async {
  final driver = await FlutterDriver.connect();
  final result =
      await driver.requestData(null, timeout: const Duration(minutes: 1));
  await driver.close();
  exit(result == 'pass' ? 0 : 1);
}
