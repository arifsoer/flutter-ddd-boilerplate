import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_sdk/domain/auth/auth_facade.dart';
import 'package:testing_sdk/domain/server_failure.dart';
import 'package:testing_sdk/domain/auth/password_value.dart';
import 'package:testing_sdk/domain/auth/email_value.dart';

class AuthProvider implements AuthFacade {
  @override
  Future<Either<ServerFailure, Unit>> registerWIthEmailAndPassword({
    required EmailValue email,
    required PasswordValue password,
  }) async {
    final emailStr = email.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );

      await credential.user!.reload();
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(ServerFailure('Your Password too weak'));
      } else if (e.code == 'email-already-in-use') {
        return left(ServerFailure('Your email already regietered'));
      } else {
        return left(ServerFailure('Server Unhandled Error code'));
      }
    }
  }

  @override
  Future<Either<ServerFailure, Unit>> signInWithEmailAndPassword({
    required EmailValue email,
    required PasswordValue password,
  }) async {
    final emailStr = email.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(ServerFailure('Your User data not found'));
      } else if (e.code == 'wrong-password') {
        return left(ServerFailure('Wrong password provided'));
      } else {
        return left(ServerFailure('Server Unhandled Error code'));
      }
    }
  }

  @override
  Future<Either<ServerFailure, List<String>>> verifyEmail({
    required EmailValue email,
  }) async {
    final emailStr = email.getOrCrash();

    try {
      var method =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailStr);
      return right(method);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return left(ServerFailure('Your email is invalid'));
      } else {
        return left(ServerFailure('Server Unhandled Error code'));
      }
    }
  }
}
