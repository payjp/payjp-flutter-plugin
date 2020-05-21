/*
 * Copyright (c) 2020 PAY, Inc.
 *
 * Use of this source code is governed by a MIT License that can by found in the LICENSE file.
 */

/// View type of CardForm.
/// tableStyled is iOS only.
enum CardFormType { multiLine, cardDisplay, tableStyled }

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
      case CardFormType.tableStyled:
        {
          return "tableStyled";
        }
    }
  }
}
