import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_sdk/applications/auth/auth_controller.dart';
import 'package:testing_sdk/applications/auth/value_validator.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(debugLabel: '_loginForm');

  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.find();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text('SignIn'),
            SizedBox(height: 20),
            TextFormField(
              controller: auth.emailController.value,
              decoration: const InputDecoration(
                hintText: 'Enter Your Email',
                labelText: 'Email',
              ),
              validator: emailValidator,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: auth.passwordController.value,
              decoration: const InputDecoration(
                hintText: 'Enter Your Password',
                labelText: 'Password',
              ),
              validator: passwordValidator,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ButtonBar(
              children: [
                TextButton(
                  child: const Text('Register'),
                  onPressed: () {
                    auth.pageState(AuthPageState.register);
                  },
                ),
                Obx(
                  () => ElevatedButton(
                    child: auth.isLoading.value == true
                        ? CircularProgressIndicator()
                        : const Text(
                            'Signin',
                            style: TextStyle(fontSize: 15),
                          ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        auth.signInWithEmailAndPassword();
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
