import 'package:auth_login_register_flutter_getx/repositories/auth_repository.dart';
import 'package:auth_login_register_flutter_getx/widgets/loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  var message = ''.obs;
  var isSuccess = false.obs;


  Future<void> login(String email, String password) async {
    try {
      Loader.show(); // Show loader before starting the API call

      final response = await _authRepository.login(email, password);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response['token']);
      prefs.setString('user_id', response['id']);
      prefs.setString('role', response['role']);
      prefs.setBool('isVerified', response['isVerified']);
      prefs.setString('email', response['user']['email']);

      message.value = 'Login successful!';
      isSuccess.value = true;

      Get.offAllNamed('/homepage');
    } catch (e) {
      message.value = _extractErrorMessage(e);
      isSuccess.value = false;
    } finally {
      Loader.hide(); // Hide the loader after the API call completes
    }
  }

  String _extractErrorMessage(dynamic error) {
    if (error is DioException) {
      if (error.response != null && error.response?.data != null) {
        return error.response?.data['message'] ?? 'An unexpected error occurred.';
      } else {
        return 'Network error: ${error.message}';
      }
    }
    return error.toString();
  }
}
