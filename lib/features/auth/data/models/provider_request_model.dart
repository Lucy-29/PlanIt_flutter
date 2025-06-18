import 'package:equatable/equatable.dart';

class ProviderRequestModel extends Equatable {
  final String message;
  final String status;
  final String token;
  final String name;
  final String email;
  // final String service;
  // final List<String> links;

  const ProviderRequestModel({
    required this.message,
    required this.status,
    required this.token,
    required this.name,
    required this.email,
    // required this.service,
    // required this.links,
  });

  factory ProviderRequestModel.fromJson(Map<String, dynamic> json) {
    return ProviderRequestModel(
      message: json['message'],
      status: json['status'],
      token: json['token'],
      name: json['name'],
      email: json['email'],
      // service: json['service'],
      // links: json['links'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'token': token,
      'name': name,
      'email': email,
      // 'service': service,
      //'links': links,
    };
  }

  @override
  List<Object?> get props => [message, status, token, name, email];
}
