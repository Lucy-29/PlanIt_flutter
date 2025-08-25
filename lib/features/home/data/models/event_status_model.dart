import 'package:equatable/equatable.dart';

// Event status from Laravel API
enum EventStatus { pending, approved, rejected }

class EventStatusModel extends Equatable {
  final String eventId;
  final EventStatus status;
  final String title;
  final String date;
  final String time;
  final String description;
  final double? price;
  final String? eventType;
  final String? privacy;
  final String? location;
  final String? organizerName;
  final String? invitationCode;
  final List<OfferStatusModel> offers;

  const EventStatusModel({
    required this.eventId,
    required this.status,
    required this.title,
    required this.date,
    required this.time,
    required this.description,
    this.price,
    this.eventType,
    this.privacy,
    this.location,
    this.organizerName,
    this.invitationCode,
    required this.offers,
  });

  factory EventStatusModel.fromJson(Map<String, dynamic> json) {
    // Handle privacy parsing more robustly
    String privacyValue = 'private'; // default
    if (json['is_public'] != null) {
      final isPublic = json['is_public'];
      privacyValue = (isPublic == true || isPublic == 1 || isPublic == '1') ? 'public' : 'private';
    } else if (json['privacy'] != null) {
      privacyValue = json['privacy'].toString().toLowerCase() == 'public' ? 'public' : 'private';
    }
    
    return EventStatusModel(
      eventId: json['id'].toString(),
      status: _parseStatus(json['status']?.toString() ?? 'pending'),
      title: json['title']?.toString() ?? '',
      date: json['date']?.toString() ?? json['event_date']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: json['price'] != null ? double.tryParse(json['price'].toString()) : null,
      eventType: json['type']?.toString() ?? json['event_type']?.toString(),
      privacy: privacyValue,
      location: json['location']?.toString(),
      organizerName: json['user']?['name']?.toString(),
      invitationCode: json['invitation_code']?.toString(),
      offers: (json['offers'] as List<dynamic>?)
          ?.map((offer) => OfferStatusModel.fromJson(offer))
          .toList() ?? [],
    );
  }

  static EventStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return EventStatus.approved;
      case 'rejected':
        return EventStatus.rejected;
      case 'pending':
      default:
        return EventStatus.pending;
    }
  }

  @override
  List<Object?> get props => [eventId, status, title, date, time, description, price, eventType, privacy, location, organizerName, invitationCode, offers];
}

class OfferStatusModel extends Equatable {
  final String offerId;
  final String title;
  final double price;
  final String status; // 'pending', 'approved', 'rejected'
  final ProviderModel provider;

  const OfferStatusModel({
    required this.offerId,
    required this.title,
    required this.price,
    required this.status,
    required this.provider,
  });

  factory OfferStatusModel.fromJson(Map<String, dynamic> json) {
    return OfferStatusModel(
      offerId: json['id'].toString(),
      title: json['title'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      status: json['pivot']?['status'] ?? json['status'] ?? 'pending',
      provider: ProviderModel.fromJson(json['user'] ?? json['provider'] ?? {}),
    );
  }

  @override
  List<Object?> get props => [offerId, title, price, status, provider];
}

class ProviderModel extends Equatable {
  final String id;
  final String name;

  const ProviderModel({
    required this.id,
    required this.name,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name];
}