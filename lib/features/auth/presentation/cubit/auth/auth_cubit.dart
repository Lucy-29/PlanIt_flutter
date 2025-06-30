import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/base_user_model.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial()) {
    checkAuthentication();
  }

  Future<void> checkAuthentication() async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.getAuthenticatedUser();
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }

  void userLoggedIn(BaseUserModel user) {
    emit(Authenticated(user: user));
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(Unauthenticated());
  }
}
