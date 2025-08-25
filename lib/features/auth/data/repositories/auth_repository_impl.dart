import 'package:dio/dio.dart';
import 'package:ems_1/features/auth/data/datasources/auth_api_datasource.dart';
import 'package:ems_1/features/auth/data/models/approval_status_model.dart';
import 'package:ems_1/features/auth/data/models/base_user_model.dart';
import 'package:ems_1/features/auth/data/models/login_response_model.dart';
import 'package:ems_1/features/auth/data/models/provider_request_model.dart';
import 'package:ems_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:ems_1/core/storage/secure_storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiDatasource apiDatasource;
  final SecureStorageService secureStorageService;

  AuthRepositoryImpl({
    required this.apiDatasource,
    required this.secureStorageService,
  });

  @override
  Future<void> sendOtp({required String email}) async {
    try {
      await apiDatasource.sendOtp(email: email);
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to send OTP';
    }
  }

  @override
  Future<LoginResponseModel> registerUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
  }) async {
    try {
      final response = await apiDatasource.registerUser(data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'otp': otp,
      });
      await secureStorageService.saveToken(response.token);
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Registration failed';
    }
  }

  @override
  Future<ProviderRequestModel> registerProvider({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
    required List<String> services,
    required List<String> links,
  }) async {
    try {
      final response = await apiDatasource.registerProvider(data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'otp': otp,
        'services': services,
        'links': links,
      });
      await secureStorageService.saveToken(response.token);
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Provider registration failed';
    }
  }

  @override
  Future<ProviderRequestModel> registerCompany({
    required String companyName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
    required List<String> specializations,
    required List<String> links,
  }) async {
    try {
      final response = await apiDatasource.registerCompany(data: {
        'name': companyName,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'otp': otp,
        'specializations': specializations,
        'links': links,
      });
      await secureStorageService.saveToken(response.token);
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Company registration failed';
    }
  }

  @override
  Future<LoginResponseModel> login(
      {required String email, required String password}) async {
    try {
      final response = await apiDatasource.login(data: {
        'email': email,
        'password': password,
      });
      await secureStorageService.saveToken(response.token);
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Invalid credentials';
    }
  }

  @override
  Future<void> logout() async {
    try {
      await apiDatasource.logout();
    } finally {
      await secureStorageService.deleteToken();
    }
  }

  @override
  Future<ApprovalStatusModel> checkApprovalStatus(
      {required String email}) async {
    try {
      return await apiDatasource.checkApprovalStatus(email: email);
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to check status';
    }
  }

  @override
  Future<BaseUserModel?> getAuthenticatedUser() async {
    final token = await secureStorageService.getToken();
    if (token == null) {
      return null;
    }

    try {
      final userJson = await apiDatasource.getAuthenticatedUser();

      return BaseUserModel.fromJson(userJson);
    } catch (e) {
      await secureStorageService.deleteToken();
      return null;
    }
  }
}
