import 'package:auth_login_register_flutter_getx/screens/home/home_screen.dart';
import 'package:auth_login_register_flutter_getx/screens/login/login_screen.dart';
import 'package:auth_login_register_flutter_getx/screens/signup/signup_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const login = '/login';
  static const signup = '/signup';
  static const homepage = '/homepage';

  static final routes = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: signup, page: () => SignupScreen()),
    GetPage(name: homepage, page: () => HomepageScreen()),
  ];
}
