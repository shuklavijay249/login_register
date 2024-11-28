import 'package:get/get.dart';

import '../controllers/signup_controller.dart';


class SignupBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize SignupController when Signup screen is loaded
    Get.lazyPut<SignupController>(() => SignupController());
  }
}

