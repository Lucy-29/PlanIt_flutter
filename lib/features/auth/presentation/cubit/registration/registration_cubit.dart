import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/login_response_model.dart';
import '../../../data/models/provider_request_model.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final AuthRepository _authRepository;
  RegistrationCubit(this._authRepository) : super(RegistrationInitial());

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
  }) async {
    emit(RegistrationLoading());
    try {
      final response = await _authRepository.registerUser(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        otp: otp,
      );
      emit(RegistrationSuccessUser(response));
    } catch (e) {
      emit(RegistrationFailure(e.toString()));
    }
  }

  Future<void> registerProvider({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
    required String service,
    required List<String> links,
  }) async {
    emit(RegistrationLoading());
    try {
      final response = await _authRepository.registerProvider(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        otp: otp,
        // service: service,
        links: links,
      );
      emit(RegistrationSuccessProvider(response));
    } catch (e) {
      emit(RegistrationFailure(e.toString()));
    }
  }

  Future<void> registerCompany({
    required String companyName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String otp,
    required String service,
    required List<String> links,
  }) async {
    emit(RegistrationLoading());
    try {
      final response = await _authRepository.registerCompany(
        companyName: companyName,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        otp: otp,
        // service: service,
        links: links,
      );
      emit(RegistrationSuccessProvider(response));
    } catch (e) {
      emit(RegistrationFailure(e.toString()));
    }
  }
}
