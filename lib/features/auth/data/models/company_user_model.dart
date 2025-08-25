import 'base_user_model.dart';

class CompanyUserModel extends BaseUserModel {
  final String? service;
  final String? providerType;

  const CompanyUserModel({
    required super.id,
    required super.name,
    required super.email,
    this.service,
    this.providerType,
  }) : super(type: 'provider');

  factory CompanyUserModel.fromJson(Map<String, dynamic> json) {
    return CompanyUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      service: json['service'],
      providerType: json['provider_type'],
    );
  }

  @override
  List<Object?> get props => [...super.props, service, providerType];
}
