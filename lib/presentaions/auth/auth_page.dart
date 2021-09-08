import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_sdk/applications/auth/auth_controller.dart';

import 'components/login_form.dart';
import 'components/register_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              '📝',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 130),
            ),
            Obx(
              () => auth.pageState.value == AuthPageState.register
                  ? RegisterForm()
                  : LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
