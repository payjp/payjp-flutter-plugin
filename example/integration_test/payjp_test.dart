/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */
// TODO: integration_test is not sound null safety.
// @dart = 2.8

import 'package:flutter_test/flutter_test.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:integration_test/integration_test.dart';
import 'package:payjp_flutter/src/payjp.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Can talk with PAY.JP', (tester) async {
    await Payjp.init(publicKey: 'pk_test_0383a1b8f91e8a6e3ea0e2a9');
    await Payjp.startCardForm();
  });
}
