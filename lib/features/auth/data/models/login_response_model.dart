import 'package:ems_1/features/auth/data/models/base_user_model.dart';
import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  final String message;
  final String token;
  final BaseUserModel? user;
  final String? name;

  const LoginResponseModel({
    required this.message,
    required this.token,
    this.user,
    this.name,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      token: json['token'],
      user: json['user'] != null ? BaseUserModel.fromJson(json['user']) : null,
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [message, token, user, name];
}
