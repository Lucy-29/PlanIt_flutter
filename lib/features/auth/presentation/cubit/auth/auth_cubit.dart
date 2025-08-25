// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../data/models/base_user_model.dart';
// import '../../../domain/repositories/auth_repository.dart';

// part 'auth_state.dart';

// class AuthCubit extends Cubit<AuthState> {
//   final AuthRepository _authRepository;

//   AuthCubit(this._authRepository) : super(AuthInitial()) {
//     checkAuthentication();
//   }

//   Future<void> checkAuthentication() async {
//     emit(AuthLoading());
//     try {
//       final user = await _authRepository.getAuthenticatedUser();
//       if (user != null) {
//         emit(Authenticated(user: user));
//       } else {
//         emit(Unauthenticated());
//       }
//     } catch (_) {
//       emit(Unauthenticated());
//     }
//   }

//   void userLoggedIn(BaseUserModel user) {
//     emit(Authenticated(user: user));
//   }

//   Future<void> logout() async {
//     await _authRepository.logout();
//     emit(Unauthenticated());
//   }
// }
import 'package:ems_1/features/auth/data/models/guest_user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/base_user_model.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial()) {
    // Don't auto-check authentication on init since we don't have /user endpoint
    _checkTokenOnly();
  }

  Future<void> _checkTokenOnly() async {
    emit(AuthLoading());
    try {
      // Check if we have a stored token, but don't validate with server
      final hasToken = await _authRepository.hasStoredToken();
      if (hasToken) {
        print('AuthCubit: Found stored token but cannot validate without /user endpoint');
        emit(Unauthenticated()); // Force login to get user data
      } else {
        print('AuthCubit: No stored token');
        emit(Unauthenticated());
      }
    } catch (e) {
      print('AuthCubit: token check error: $e');
      emit(Unauthenticated());
    }
  }

  Future<void> checkAuthentication() async {
    emit(AuthLoading());
    try {
      print('AuthCubit: checkAuthentication called');
      final user = await _authRepository.getAuthenticatedUser();
      print('AuthCubit: got user $user');
      if (user != null) {
        print('AuthCubit: emitting Authenticated with user type: ${user.type}');
        emit(Authenticated(user: user));
      } else {
        print('AuthCubit: no user found, emitting Unauthenticated');
        emit(Unauthenticated());
      }
    } catch (e) {
      print('AuthCubit: checkAuthentication error: $e');
      emit(Unauthenticated());
    }
  }

  void userLoggedIn(BaseUserModel user) {
    emit(Authenticated(user: user));
  }

  void loginAsGuest() {
    final guestUser = GuestUserModel(); // See model below
    emit(Authenticated(user: guestUser, isGuest: true));
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(Unauthenticated());
  }

  void updateAuthenticatedUser(BaseUserModel updatedUser) {
    if (state is Authenticated) {
      emit(Authenticated(user: updatedUser));
    }
  }
}
