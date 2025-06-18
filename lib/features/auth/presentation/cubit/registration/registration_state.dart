part of 'registration_cubit.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccessUser extends RegistrationState {
  final LoginResponseModel loginResponse;
  const RegistrationSuccessUser(this.loginResponse);
  @override
  List<Object> get props => [loginResponse];
}

class RegistrationSuccessProvider extends RegistrationState {
  final ProviderRequestModel providerRequest;
  const RegistrationSuccessProvider(this.providerRequest);
  @override
  List<Object> get props => [providerRequest];
}

class RegistrationFailure extends RegistrationState {
  final String error;
  const RegistrationFailure(this.error);
  @override
  List<Object> get props => [error];
}
