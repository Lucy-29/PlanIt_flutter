import 'base_user_model.dart';

class SimpleUserModel extends BaseUserModel {
  const SimpleUserModel({
    required super.id,
    required super.name,
    required super.email,
  }) : super(type: 'user');

  factory SimpleUserModel.fromJson(Map<String, dynamic> json) {
    return SimpleUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
