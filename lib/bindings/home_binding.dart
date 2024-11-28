import 'package:auth_login_register_flutter_getx/controllers/homepage_controller.dart';
import 'package:get/get.dart';


class HomepageBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize HomepageController when Homepage screen is loaded
    Get.lazyPut<HomepageController>(() => HomepageController());
  }
}

