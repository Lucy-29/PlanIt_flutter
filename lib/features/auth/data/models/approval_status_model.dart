import 'package:equatable/equatable.dart';

class ApprovalStatusModel extends Equatable {
  final String status;
  final String? name;
  final String? type;
  // final String? service;

  const ApprovalStatusModel({
    required this.status,
    this.name,
    this.type,
    // this.service,
  });

  factory ApprovalStatusModel.fromJson(Map<String, dynamic> json) {
    return ApprovalStatusModel(
      status: json['status'],
      name: json['name'],
      type: json['type'],
      // service: json['service'],
    );
  }

  @override
  List<Object?> get props => [status, name, type];
}
