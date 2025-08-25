import 'package:equatable/equatable.dart';

class GalleryImageModel extends Equatable {
  final int id;
  final String imagePath;
  final int companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const GalleryImageModel({
    required this.id,
    required this.imagePath,
    required this.companyId,
    this.createdAt,
    this.updatedAt,
  });

  factory GalleryImageModel.fromJson(Map<String, dynamic> json) {
    return GalleryImageModel(
      id: json['id'],
      imagePath: json['image_path'],
      companyId: json['company_id'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_path': imagePath,
      'company_id': companyId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Get full image URL
  String get imageUrl {
    if (imagePath.startsWith('http')) {
      return imagePath;
    }
    return 'https://your-app-domain.com/storage/$imagePath';
  }

  @override
  List<Object?> get props => [
    id,
    imagePath,
    companyId,
    createdAt,
    updatedAt,
  ];
}