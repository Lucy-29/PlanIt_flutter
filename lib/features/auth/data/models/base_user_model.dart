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
    switch (json['type']) {
      case 'provider':
        return IndividualProviderModel.fromJson(json);

      case 'company':
        return CompanyUserModel.fromJson(json);

      case 'user':
      default:
        return SimpleUserModel.fromJson(json);
    }
  }

  @override
  List<Object?> get props => [id, name, email, type];

  get profileImageUrl => null;
}
