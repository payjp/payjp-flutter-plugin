/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

import 'package:e2e/e2e.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payjp_flutter/src/payjp.dart';

void main() {
  E2EWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Can talk with PAY.JP', (tester) async {
    await Payjp.init(publicKey: 'pk_test_0383a1b8f91e8a6e3ea0e2a9');
    await Payjp.startCardForm();
  });
}
