import 'package:equatable/equatable.dart';

class CompanyStatisticsModel extends Equatable {
  final int reservationsCount;
  final int reviewsCount;
  final double averageRating;
  final double totalRevenue;
  final int activeEvents;
  final int galleryImages;

  const CompanyStatisticsModel({
    required this.reservationsCount,
    required this.reviewsCount,
    required this.averageRating,
    required this.totalRevenue,
    required this.activeEvents,
    required this.galleryImages,
  });

  // Getters for backward compatibility
  int get totalReservations => reservationsCount;
  int get totalReviews => reviewsCount;

  factory CompanyStatisticsModel.fromJson(Map<String, dynamic> json) {
    return CompanyStatisticsModel(
      reservationsCount: json['reservations_count'] ?? 0,
      reviewsCount: json['reviews_count'] ?? 0,
      averageRating: (json['average_rating'] ?? 0.0).toDouble(),
      totalRevenue: (json['total_revenue'] ?? 0.0).toDouble(),
      activeEvents: json['active_events'] ?? 0,
      galleryImages: json['gallery_images'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservations_count': reservationsCount,
      'reviews_count': reviewsCount,
      'average_rating': averageRating,
      'total_revenue': totalRevenue,
      'active_events': activeEvents,
      'gallery_images': galleryImages,
    };
  }

  // Format revenue for display
  String get formattedRevenue {
    return '${totalRevenue.toStringAsFixed(0)} S.P';
  }

  // Get star rating as list of booleans (for UI display)
  List<bool> get starRating {
    List<bool> stars = [];
    int fullStars = averageRating.floor();
    bool hasHalfStar = (averageRating - fullStars) >= 0.5;
    
    // Add full stars
    for (int i = 0; i < fullStars && i < 5; i++) {
      stars.add(true);
    }
    
    // Add half star if needed (for simplicity, we'll count it as full star)
    if (hasHalfStar && fullStars < 5) {
      stars.add(true);
      fullStars++;
    }
    
    // Add empty stars
    while (stars.length < 5) {
      stars.add(false);
    }
    
    return stars;
  }

  @override
  List<Object?> get props => [
    reservationsCount,
    reviewsCount,
    averageRating,
    totalRevenue,
    activeEvents,
    galleryImages,
  ];
}