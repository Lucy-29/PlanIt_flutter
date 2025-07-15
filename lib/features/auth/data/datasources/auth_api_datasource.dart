import 'package:dio/dio.dart';
import 'package:ems_1/features/auth/data/models/approval_status_model.dart';
import 'package:ems_1/features/auth/data/models/login_response_model.dart';
import 'package:ems_1/features/auth/data/models/provider_request_model.dart';

class AuthApiDatasource {
  final Dio dio;

  AuthApiDatasource({required this.dio});

  Future<void> sendOtp({required String email}) async {
    await dio.post('/send-otp', data: {'email': email});
  }

  Future<LoginResponseModel> registerUser({
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.post('/register/user', data: data);
    return LoginResponseModel.fromJson(response.data);
  }

  Future<ProviderRequestModel> registerProvider({
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.post('/register/provider', data: data);
    return ProviderRequestModel.fromJson(response.data);
  }

  Future<ProviderRequestModel> registerCompany({
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.post('/register/company', data: data);
    return ProviderRequestModel.fromJson(response.data);
  }

  Future<LoginResponseModel> login({required Map<String, dynamic> data}) async {
    final response = await dio.post('/login', data: data);
    return LoginResponseModel.fromJson(response.data);
  }

  Future<void> logout() async {
    await dio.post('/logout');
  }

  Future<ApprovalStatusModel> checkApprovalStatus(
      {required String email}) async {
    final response =
        await dio.post('/check-approval-status', data: {'email': email});
    return ApprovalStatusModel.fromJson(response.data);
  }

  Future<Map<String, dynamic>> getAuthenticatedUser() async {
    final response = await dio.get('/user');
    return response.data;
  }
}
