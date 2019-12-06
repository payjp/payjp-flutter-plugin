import 'package:meta/meta.dart';

@sealed
class CardFormStatus {}

class CardFormComplete extends CardFormStatus {}

class CardFormError extends CardFormStatus {
  final String message;

  CardFormError(this.message);
}

