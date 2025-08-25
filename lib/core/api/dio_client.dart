import 'package:dio/dio.dart';
import 'package:ems_1/core/storage/secure_storage_service.dart';

class DioClient {
  // static const String _baseUrl = 'http://192.168.97.109:8000/api';
  static const String _baseUrl = 'http://10.0.2.2:8000/api';
  late Dio _dio;

  final SecureStorageService secureStorageService;

  DioClient({required this.secureStorageService}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 3000),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await secureStorageService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          print('🌐 API Request: ${options.method} ${options.uri}');
          print('🌐 Headers: ${options.headers}');
          print('🌐 Body: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ API Response: ${response.statusCode} ${response.requestOptions.uri}');
          print('✅ Response Data: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('❌ API Error: ${error.requestOptions.method} ${error.requestOptions.uri}');
          print('❌ Status Code: ${error.response?.statusCode}');
          print('❌ Error Message: ${error.message}');
          print('❌ Error Response: ${error.response?.data}');
          return handler.next(error);
        },
      ),
    );
  }

  Dio get instance => _dio;
}
