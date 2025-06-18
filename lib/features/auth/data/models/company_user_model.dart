import 'base_user_model.dart';

class CompanyUserModel extends BaseUserModel {
  final String service;

  const CompanyUserModel({
    required super.id,
    required super.name,
    required super.email,
    required this.service,
  }) : super(type: 'company');

  factory CompanyUserModel.fromJson(Map<String, dynamic> json) {
    return CompanyUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      service: json['service'],
    );
  }

  @override
  List<Object?> get props => [...super.props, service];
}
