import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Loader {
  static void show() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );
  }

  static void hide() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
