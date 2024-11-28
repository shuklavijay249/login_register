import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://adigo-backend.vercel.app/api"
    ));
    dio.interceptors.add(PrettyDioLogger());
  }
}
