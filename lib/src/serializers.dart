/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

import 'package:built_value/serializer.dart';
import 'package:payjp_flutter/src/error_info.dart';
import 'package:payjp_flutter/src/card.dart';
import 'package:payjp_flutter/src/card_brand.dart';
import 'package:payjp_flutter/src/token.dart';

part 'serializers.g.dart';

@SerializersFor([ErrorInfo, Card, CardBrand, Token])
final Serializers serializers = _$serializers;
