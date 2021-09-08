import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_sdk/presentaions/home/home_page.dart';
import 'package:testing_sdk/presentaions/routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<FirebaseApp> _initialize = Firebase.initializeApp();

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _initialize,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something when wrone');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return HomePage();
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      getPages: Routes.routes,
    );
  }
}
