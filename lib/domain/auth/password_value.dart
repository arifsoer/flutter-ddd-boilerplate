import 'package:dartz/dartz.dart';
import 'package:testing_sdk/domain/invalid_value.dart';
import 'package:testing_sdk/domain/object_value.dart';

class PasswordValue extends ObjectValue<String> {
  const PasswordValue._(this.value);
  final Either<InvalidValue, String> value;

  factory PasswordValue(String input) {
    return PasswordValue._(
      validatePassword(input),
    );
  }
}

Either<InvalidValue, String> validatePassword(String input) {
  if (input.length <= 6) {
    return left(
      InvalidValue('Please input password with more than 6 character'),
    );
  } else {
    return right(input);
  }
}
