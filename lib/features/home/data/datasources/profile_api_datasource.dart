import 'dart:io';
import 'package:dio/dio.dart';

class ProfileApiDatasource {
  final Dio dio;
  ProfileApiDatasource({required this.dio});

  // Makes a GET request to your /users/{id} endpoint
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    final response = await dio.get('/users/$userId');
    return response.data;
  }

  // Makes a POST request to your /users/{id} endpoint with multipart form data
  Future<Map<String, dynamic>> updateUserProfile({
    required String userId,
    required FormData formData,
  }) async {
    // Laravel handles updates via POST when a file is included.
    // The '_method' field is a common way to specify the intended HTTP verb.
    formData.fields.add(const MapEntry('_method', 'PUT'));

    final response = await dio.post(
      '/users/$userId',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    return response.data;
  }
}
