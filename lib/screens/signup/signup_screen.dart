import 'package:auth_login_register_flutter_getx/controllers/signup_controller.dart';
import 'package:auth_login_register_flutter_getx/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  final SignupController _controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
        centerTitle: true,
      ),
      body: Obx(() {
        // Show Snackbar if there's a new message
        if (_controller.message.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackbar(
                title: _controller.isSuccess.value ? 'Success' : 'Error',
                message: _controller.message.value,
                backgroundColor:
                    _controller.isSuccess.value ? Colors.green : Colors.red,
              ),
            );
            _controller.message.value = '';
          });
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 24),
                Text(
                  'Create Your Account',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Fill in your details below to sign up.',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.black54,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name cannot be empty';
                    }
                    if (value.length < 2) {
                      return 'Name must be at least 2 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Mobile Number Field
                TextFormField(
                  controller: _mobileController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile number cannot be empty';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email cannot be empty';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value.length < 5) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // OTP Field (conditionally displayed)
                if (_controller.otpSent.value)
                  TextFormField(
                    controller: _otpController..text = _controller.otp.value,
                    decoration: const InputDecoration(
                      labelText: 'Enter OTP',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.security),
                    ),
                  ),
                const SizedBox(height: 32),

                // Submit Button
                ElevatedButton(
                  onPressed: () async {
                    bool isConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isConnected) {
                      // Show connectivity error
                      Get.snackbar(
                        "No Internet",
                        "Please check your internet connection and try again.",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    if (!_controller.otpSent.value) {
                      if (_formKey.currentState!.validate()) {
                        _controller.sendOtp(_emailController.text);
                      }
                    } else {
                      if (_formKey.currentState!.validate()) {
                        _controller.signup(
                          _nameController.text,
                          _mobileController.text,
                          _emailController.text,
                          _passwordController.text,
                          _otpController.text,
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    _controller.otpSent.value ? 'Signup' : 'Send OTP',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
