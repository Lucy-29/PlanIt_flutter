import 'package:equatable/equatable.dart';
import 'gallery_image_model.dart';

class CompanyProfileModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? description;
  final String? profileImage;
  final String? providerType; // company type from backend
  final List<String>? specializations;
  final List<GalleryImageModel>? gallery;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CompanyProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.description,
    this.profileImage,
    this.providerType,
    this.specializations,
    this.gallery,
    this.createdAt,
    this.updatedAt,
  });

  factory CompanyProfileModel.fromJson(Map<String, dynamic> json) {
    return CompanyProfileModel(
      id: _parseInt(json['id']),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      description: json['description'],
      profileImage: json['profile_image'],
      providerType: json['provider_type'],
      specializations: json['specializations'] != null 
          ? List<String>.from(json['specializations'])
          : null,
      gallery: json['gallery'] != null
          ? (json['gallery'] as List).map((img) => GalleryImageModel.fromJson(img)).toList()
          : null,
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
      'name': name,
      'email': email,
      'description': description,
      'profile_image': profileImage,
      'provider_type': providerType,
      'specializations': specializations,
      'gallery': gallery?.map((img) => img.toJson()).toList(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  CompanyProfileModel copyWith({
    int? id,
    String? name,
    String? email,
    String? description,
    String? profileImage,
    String? providerType,
    List<String>? specializations,
    List<GalleryImageModel>? gallery,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CompanyProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      description: description ?? this.description,
      profileImage: profileImage ?? this.profileImage,
      providerType: providerType ?? this.providerType,
      specializations: specializations ?? this.specializations,
      gallery: gallery ?? this.gallery,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    description,
    profileImage,
    providerType,
    specializations,
    gallery,
    createdAt,
    updatedAt,
  ];
}