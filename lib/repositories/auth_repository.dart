import 'package:auth_login_register_flutter_getx/services/api_service.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final Dio _client = ApiService.dio;

  Future<Map<String, dynamic>> sendOtp(String email) async {
    try {
      final response = await _client.post(
        'https://adigo-backend.vercel.app/api/auth/send-otp',
        data: {"email": email},
      );
      return response.data; // Return the response containing OTP
    } catch (e) {
      throw Exception('Failed to send OTP. ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> signup(String name, String mobile, String email,
      String password, String otp) async {
    try {
      final response = await _client.post('/auth/signup', data: {
        'name': name,
        'mobile': mobile,
        'email': email,
        'password': password,
        'otp': otp,
      });
      if (response.data['signup_success'] != true) {
        throw Exception('Signup failed.');
      }
      return response.data;
    } catch (e) {
      throw Exception('Signup failed. ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _client.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        return response.data; // Return the API response on success
      } else {
        throw Exception('Login failed. ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Login failed. ${e.toString()}');
    }
  }
}
