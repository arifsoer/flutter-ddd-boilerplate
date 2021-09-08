import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_sdk/applications/auth/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Successfuly Login'),
            ElevatedButton(
              onPressed: () {
                auth.logout();
              },
              child: const Text('signout'),
            )
          ],
        ),
      ),
    );
  }
}
