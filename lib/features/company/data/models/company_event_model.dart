import 'package:equatable/equatable.dart';

class CompanyEventModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final String? image;
  final double ticketPrice;
  final int capacity;
  final String category;
  final int userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CompanyEventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    this.image,
    required this.ticketPrice,
    required this.capacity,
    required this.category,
    required this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory CompanyEventModel.fromJson(Map<String, dynamic> json) {
    return CompanyEventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['date_time']),
      location: json['location'],
      image: json['image'],
      ticketPrice: (json['ticket_price'] ?? 0.0).toDouble(),
      capacity: json['capacity'] ?? 0,
      category: json['category'] ?? '',
      userId: json['user_id'],
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
      'title': title,
      'description': description,
      'date_time': dateTime.toIso8601String(),
      'location': location,
      'image': image,
      'ticket_price': ticketPrice,
      'capacity': capacity,
      'category': category,
      'user_id': userId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Get full image URL
  String? get imageUrl {
    if (image == null) return null;
    if (image!.startsWith('http')) {
      return image;
    }
    return 'https://your-app-domain.com/storage/$image';
  }

  // Format price for display
  String get formattedPrice {
    return '${ticketPrice.toStringAsFixed(0)} S.P';
  }

  // Format date for display
  String get formattedDate {
    return '${dateTime.day} ${_getMonthName(dateTime.month)} ${dateTime.year}';
  }

  // Format time for display
  String get formattedTime {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _getMonthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  CompanyEventModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dateTime,
    String? location,
    String? image,
    double? ticketPrice,
    int? capacity,
    String? category,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CompanyEventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      image: image ?? this.image,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      capacity: capacity ?? this.capacity,
      category: category ?? this.category,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    dateTime,
    location,
    image,
    ticketPrice,
    capacity,
    category,
    userId,
    createdAt,
    updatedAt,
  ];
}