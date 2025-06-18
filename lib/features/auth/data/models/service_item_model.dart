import 'package:equatable/equatable.dart';

class ServiceItemModel extends Equatable {
  final String serviceName;
  final String emoji;

  const ServiceItemModel({
    required this.serviceName,
    required this.emoji,
  });

  @override
  List<Object?> get props => [serviceName, emoji];
}
