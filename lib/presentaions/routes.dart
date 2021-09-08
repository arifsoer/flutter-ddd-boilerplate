import 'package:get/get.dart';
import 'package:testing_sdk/presentaions/auth/auth_page.dart';
import 'package:testing_sdk/presentaions/home/home_page.dart';

class Routes {
  Routes._();

  static const home = '/';
  static const authPage = '/signin';

  static final routes = [
    GetPage(
      name: home,
      page: () => HomePage(),
    ),
    GetPage(
      name: authPage,
      page: () => AuthPage(),
    ),
  ];
}
