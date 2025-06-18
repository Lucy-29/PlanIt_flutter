import 'base_user_model.dart';

class IndividualProviderModel extends BaseUserModel {
  final String service;

  const IndividualProviderModel({
    required super.id,
    required super.name,
    required super.email,
    required this.service,
  }) : super(type: 'provider');

  factory IndividualProviderModel.fromJson(Map<String, dynamic> json) {
    return IndividualProviderModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      service: json['service'],
    );
  }

  @override
  List<Object?> get props => [...super.props, service];
}
