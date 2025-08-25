import 'package:equatable/equatable.dart';
import '../../../data/models/company_profile_model.dart';

abstract class CompanyProfileState extends Equatable {
  const CompanyProfileState();

  @override
  List<Object?> get props => [];
}

class CompanyProfileInitial extends CompanyProfileState {}

class CompanyProfileLoading extends CompanyProfileState {}

class CompanyProfileLoaded extends CompanyProfileState {
  final CompanyProfileModel profile;

  const CompanyProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class CompanyProfileError extends CompanyProfileState {
  final String message;

  const CompanyProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CompanyProfileUpdating extends CompanyProfileState {}

class CompanyProfileUpdated extends CompanyProfileState {
  final CompanyProfileModel profile;

  const CompanyProfileUpdated({required this.profile});

  @override
  List<Object?> get props => [profile];
}