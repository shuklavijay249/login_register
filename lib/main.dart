import 'package:auth_login_register_flutter_getx/routes/app_routes.dart';
import 'package:auth_login_register_flutter_getx/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService.init(); // Initialize Dio client
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<String> getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return token != null ? AppRoutes.homepage : AppRoutes.signup;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getInitialRoute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator())));
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: snapshot.data ?? AppRoutes.signup,
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
