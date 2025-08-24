import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ems_1/features/auth/data/models/base_user_model.dart';
import 'package:ems_1/features/home/data/datasources/profile_api_datasource.dart';
import 'package:ems_1/features/home/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiDatasource apiDatasource;
  ProfileRepositoryImpl({required this.apiDatasource});

  @override
  Future<BaseUserModel> getUserProfile(String userId) async {
    final responseData = await apiDatasource.getUserProfile(userId);
    // Use the smart factory constructor from your BaseUserModel to parse the response
    return BaseUserModel.fromJson(responseData['user']);
  }

  @override
  Future<BaseUserModel> updateUserProfile({
    required String userId,
    required String name,
    required String email,
    String? password,
    File? profileImage,
  }) async {
    // 1. Create a map for all the text-based data
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
    };

    // 2. Add the password fields only if a new password is provided
    if (password != null && password.isNotEmpty) {
      data['password'] = password;
      data['password_confirmation'] = password;
    }

    // 3. Create the FormData object, which is necessary for file uploads
    final formData = FormData.fromMap(data);

    // 4. If the user picked a new image, add the file to the FormData
    if (profileImage != null) {
      // The key 'profile_image' must match your Laravel controller's validation rule
      formData.files.add(MapEntry(
        'profile_image',
        await MultipartFile.fromFile(profileImage.path),
      ));
    }

    // 5. Call the datasource to send the completed form data to the server
    final responseData = await apiDatasource.updateUserProfile(
        userId: userId, formData: formData);
    return BaseUserModel.fromJson(responseData['user']);
  }
}
