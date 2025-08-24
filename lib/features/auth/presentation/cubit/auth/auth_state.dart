// part of 'auth_cubit.dart';

// abstract class AuthState extends Equatable {
//   const AuthState();
//   @override
//   List<Object?> get props => [];
// }

// class AuthInitial extends AuthState {}

// class AuthLoading extends AuthState {}

// class Authenticated extends AuthState {
//   final BaseUserModel user;
//   const Authenticated({required this.user});

//   @override
//   List<Object?> get props => [user];
// }

// class Unauthenticated extends AuthState {}
part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final BaseUserModel user;
  final bool isGuest;

  const Authenticated({required this.user, this.isGuest = false});

  @override
  List<Object?> get props => [user, isGuest];
}

class Unauthenticated extends AuthState {}
