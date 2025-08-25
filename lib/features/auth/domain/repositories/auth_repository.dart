import 'package:ems_1/features/auth/data/models/approval_status_model.dart';
import 'package:ems_1/features/auth/data/models/base_user_model.dart';
import 'package:ems_1/features/auth/data/models/login_response_model.dart';
import 'package:ems_1/features/auth/data/models/provider_request_model.dart';

abstract class AuthRepository {
  Future<void> sendOtp({required String email});
  Future<LoginResponseModel> registerUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
  });
  Future<ProviderRequestModel> registerProvider({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
    required List<String> services,
    required List<String> links,
  });

  Future<ProviderRequestModel> registerCompany({
    required String companyName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
    required List<String> specializations,
    required List<String> links,
  });
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<ApprovalStatusModel> checkApprovalStatus({required String email});
  Future<BaseUserModel?> getAuthenticatedUser();
  Future<bool> hasStoredToken();
}
