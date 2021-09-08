import 'package:testing_sdk/domain/auth/email_value.dart';
import 'package:testing_sdk/domain/auth/password_value.dart';

String? Function(String?) emailValidator = (emailStr) {
  final emailVal = EmailValue(emailStr!);
  if (!emailVal.isValid()) {
    return emailVal.getMessage();
  }
  return null;
};

String? Function(String?) passwordValidator = (passwordStr) {
  final passVal = PasswordValue(passwordStr!);
  if (!passVal.isValid()) {
    return passVal.getMessage();
  }
  return null;
};
