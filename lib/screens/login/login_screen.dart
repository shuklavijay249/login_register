import 'package:auth_login_register_flutter_getx/controllers/login_controller.dart';
import 'package:auth_login_register_flutter_getx/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Obx(() {
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
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Log in to your account below.',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.black54,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

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
                    return null;
                  },
                ),
                const SizedBox(height: 32),

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

                    if (_formKey.currentState!.validate()) {
                      _controller.login(
                        _emailController.text,
                        _passwordController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/signup');
                      },
                      child: Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
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
