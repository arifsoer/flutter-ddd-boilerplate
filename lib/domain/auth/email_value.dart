import 'package:dartz/dartz.dart';
import 'package:testing_sdk/domain/invalid_value.dart';
import 'package:testing_sdk/domain/object_value.dart';

class EmailValue extends ObjectValue<String> {
  const EmailValue._(this.value);
  @override
  final Either<InvalidValue, String> value;

  factory EmailValue(String input) {
    return EmailValue._(
      validateEmailAddress(input),
    );
  }
}

Either<InvalidValue, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(InvalidValue('Input correct format email address'));
  }
}
