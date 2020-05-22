/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

/// View type of CardForm.
enum CardFormType { multiLine, cardDisplay }

class CardFormTypeTransformer {
  static dynamic enumToString(dynamic value) {
    switch (value) {
      case CardFormType.multiLine:
        {
          return "multiLine";
        }
      case CardFormType.cardDisplay:
        {
          return "cardDisplay";
        }
    }
  }
}
