import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/login_response_model.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final response = await _authRepository.login(
        email: email,
        password: password,
      );
      // emit(LoginSuccess(response));
      if (response.user != null) {
        emit(LoginSuccess(response));
      } else {
        emit(LoginFailure("Login response missing user data"));
      }
      print('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
