import 'package:get/get.dart';
import '../../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize LoginController when Login screen is loaded
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

