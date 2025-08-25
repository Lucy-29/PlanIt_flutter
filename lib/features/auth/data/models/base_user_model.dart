import 'package:ems_1/features/auth/data/models/company_user_model.dart';
import 'package:ems_1/features/auth/data/models/individual_provider_model.dart';
import 'package:ems_1/features/auth/data/models/simple_user_model.dart';
import 'package:equatable/equatable.dart';

abstract class BaseUserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String type;

  const BaseUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
  });

  factory BaseUserModel.fromJson(Map<String, dynamic> json) {
    // Handle the backend structure where companies have type='provider' and provider_type='company'
    final userType = json['type'];
    final providerType = json['provider_type'];
    
    if (userType == 'provider' && providerType == 'company') {
      return CompanyUserModel.fromJson(json);
    } else if (userType == 'provider' && providerType == 'individual') {
      return IndividualProviderModel.fromJson(json);
    } else if (userType == 'user') {
      return SimpleUserModel.fromJson(json);
    } else {
      // Default fallback to SimpleUserModel
      return SimpleUserModel.fromJson(json);
    }
  }

  @override
  List<Object?> get props => [id, name, email, type];

  get profileImageUrl => null;
}
