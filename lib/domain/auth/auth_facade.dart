import 'package:testing_sdk/domain/auth/email_value.dart';
import 'package:testing_sdk/domain/auth/password_value.dart';
import 'package:testing_sdk/domain/server_failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthFacade {
  Future<Either<ServerFailure, Unit>> registerWIthEmailAndPassword({
    required EmailValue email,
    required PasswordValue password,
  });
  Future<Either<ServerFailure, Unit>> signInWithEmailAndPassword({
    required EmailValue email,
    required PasswordValue password,
  });
  Future<Either<ServerFailure, List<String>>> verifyEmail({
    required EmailValue email,
  });
}
