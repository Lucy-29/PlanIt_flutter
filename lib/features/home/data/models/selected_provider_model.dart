import 'package:equatable/equatable.dart';

class SelectedProviderModel extends Equatable {
  final String id;
  final String name;
  final String jobTitle;
  final String imageUrl;

  const SelectedProviderModel({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, jobTitle, imageUrl];
}
