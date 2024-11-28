import 'package:auth_login_register_flutter_getx/repositories/auth_repository.dart';
import 'package:auth_login_register_flutter_getx/widgets/loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  var otpSent = false.obs;
  var otp = ''.obs;
  var message = ''.obs;
  var isSuccess = false.obs;


  Future<void> sendOtp(String email) async {
    try {
      Loader.show(); // Show loader before starting the API call
      // Call the API to send OTP
      final response = await _authRepository.sendOtp(email);
      otp.value = response['otp'];
      otpSent.value = true;
      isSuccess.value = true;
      message.value = 'OTP sent successfully. OTP: ${otp.value}';
    } catch (e) {
      isSuccess.value = false;
      message.value = 'Failed to send OTP: ${_extractErrorMessage(e)}';
    } finally {
      Loader.hide(); // Hide the loader after the API call completes
    }
  }

  Future<void> signup(String name, String mobile, String email, String password,
      String otp) async {
    try {
      Loader.show(); // Show loader before starting the API call
      final response =
          await _authRepository.signup(name, mobile, email, password, otp);

      if (response['message'] == 'User already exists') {
        isSuccess.value = false;
        message.value = 'User already exists. Redirecting to login.';
        Get.offAllNamed('/login');
        return;
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response['token']);
      prefs.setString('user_id', response['user']['_id']);
      prefs.setString('email', response['user']['email']);
      prefs.setBool('isVerified', response['user']['isVerified']);

      isSuccess.value = true;
      message.value = 'Signup successful! Redirecting to homepage.';
      Get.offAllNamed('/homepage'); // Navigate to homepage
    } catch (e) {
      isSuccess.value = false;
      if(e.toString().contains("409")){
        message.value = 'User already exists';
      }else{
        message.value = _extractErrorMessage(e);
      }
    } finally {
      Loader.hide();
    }
  }

  String _extractErrorMessage(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        if (error.response?.statusCode == 409) {
          return 'User already exists';
        }
        return error.response?.data['message'] ?? 'An unexpected error occurred.';
      } else {
        return 'Network error: ${error.message}';
      }
    }
    return error.toString();
  }
}
