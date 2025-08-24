import 'package:ems_1/features/home/data/models/selected_offer_model.dart';
import 'package:equatable/equatable.dart';

enum EventPrivacy { private, public }

class EventDetailsModel extends Equatable {
  final String id; // <-- 1. ADD A UNIQUE ID

  final String eventName;
  final DateTime eventDate;
  final EventPrivacy privacy;
  final String? eventType; // <-- FIX #1: Must be nullable
  final String location;
  final String description;
  final double price;
  final String? imagePath;
  final List<SelectedOfferModel> selectedOffers; // <-- NEW FIELD

  const EventDetailsModel({
    required this.id, // <-- 2. ADD TO CONSTRUCTOR

    required this.eventName,
    required this.eventDate,
    required this.privacy,
    required this.eventType,
    required this.location,
    required this.description,
    required this.price,
    this.imagePath,
    required this.selectedOffers, // <-- NEW
  });

  // Factory for the initial empty state of the form
  factory EventDetailsModel.initial() {
    return EventDetailsModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),

      eventName: '',
      eventDate: DateTime.now(),
      privacy: EventPrivacy.private,
      eventType: null,
      location: '',
      description: '',
      price: 0.0,
      imagePath: null,
      selectedOffers: const [], // <-- NEW
    );
  }

  // Helper to easily create a new state with updated values
  EventDetailsModel copyWith({
    String? id, // <-- 4. ADD TO copyWith

    String? eventName,
    DateTime? eventDate,
    EventPrivacy? privacy,
    String? eventType, // <-- FIX #2: Correct parameter
    String? location,
    String? description,
    double? price,
    String? imagePath,
    List<SelectedOfferModel>? selectedOffers, // <-- NEW
  }) {
    return EventDetailsModel(
      id: id ?? this.id, // <-- 5. UPDATE in copyWith

      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      privacy: privacy ?? this.privacy,
      eventType: eventType ?? this.eventType,
      location: location ?? this.location,
      description: description ?? this.description,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      selectedOffers: selectedOffers ?? this.selectedOffers, // <-- NEW
    );
  }

  @override
  List<Object?> get props => [
        id,
        eventName,
        eventDate,
        privacy,
        eventType,
        location,
        description,
        price,
        imagePath,
        selectedOffers
      ];
}
