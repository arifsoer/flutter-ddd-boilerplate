import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_sdk/domain/auth/auth_facade.dart';
import 'package:testing_sdk/domain/auth/email_value.dart';
import 'package:testing_sdk/domain/auth/password_value.dart';
import 'package:testing_sdk/infrastructures/auth/auth_provider.dart';
import 'package:testing_sdk/presentaions/routes.dart';

enum AuthState {
  loggedIn,
  loggedOut,
  login,
  register,
}

enum AuthPageState {
  login,
  register,
}

class AuthController extends GetxController {
  final state = AuthState.loggedOut.obs;
  final pageState = AuthPageState.login.obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final isLoading = false.obs;
  final AuthFacade _auth = AuthProvider();

  @override
  void onInit() {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        state(AuthState.loggedIn);
        Get.offAllNamed(Routes.home);
      } else {
        state(AuthState.loggedOut);
        Get.offAllNamed(Routes.authPage);
      }
    });
    super.onInit();
  }

  void registerWIthEmailAndPassword() async {
    isLoading(true);

    final emailValue = EmailValue(emailController.value.text);
    final passwordValue = PasswordValue(passwordController.value.text);

    final regisRespon = await _auth.registerWIthEmailAndPassword(
      email: emailValue,
      password: passwordValue,
    );

    if (regisRespon.isLeft()) {
      print(regisRespon);
    }

    isLoading(false);
  }

  void signInWithEmailAndPassword() async {
    isLoading(true);

    final emailValue = EmailValue(emailController.value.text);
    final passwordValue = PasswordValue(passwordController.value.text);

    final doSignInRespon = await _auth.signInWithEmailAndPassword(
      email: emailValue,
      password: passwordValue,
    );

    if (doSignInRespon.isLeft()) {
      print(doSignInRespon);
    }

    isLoading(false);
  }

  void verifyEmail() async {
    isLoading(true);

    final emailValue = EmailValue(emailController.value.text);

    final respon = await _auth.verifyEmail(email: emailValue);

    respon.fold(
      (error) {
        print(error);
      },
      (rightValue) {
        if (rightValue.contains('password')) {
          pageState(AuthPageState.login);
        } else {
          pageState(AuthPageState.register);
        }
      },
    );

    isLoading(false);
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.authPage);
  }

  void changeLoginRegisterState() {
    if (pageState.value == AuthPageState.login) {
      pageState(AuthPageState.register);
    } else {
      pageState(AuthPageState.login);
    }
  }

  void clearController() {
    emailController.value.clear();
    passwordController.value.clear();
  }

  void changeLoadingState() {
    isLoading(!isLoading.value);
  }
}
