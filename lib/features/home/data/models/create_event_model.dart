import 'package:equatable/equatable.dart';

enum EventPrivacy { private, public }

class CreateEventModel extends Equatable {
  final String eventName;
  final DateTime eventDate;
  final EventPrivacy privacy;
  final Set<String> eventTypes;
  final String location;

  const CreateEventModel({
    required this.eventName,
    required this.eventDate,
    required this.privacy,
    required this.eventTypes,
    required this.location,
  });

  factory CreateEventModel.initial() {
    return CreateEventModel(
      eventName: '',
      eventDate: DateTime.now(),
      privacy: EventPrivacy.private,
      eventTypes: const {},
      location: '',
    );
  }

  CreateEventModel copyWith({
    String? eventName,
    DateTime? eventDate,
    EventPrivacy? privacy,
    Set<String>? eventTypes,
    String? location,
  }) {
    return CreateEventModel(
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      privacy: privacy ?? this.privacy,
      eventTypes: eventTypes ?? this.eventTypes,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props =>
      [eventName, eventDate, privacy, eventTypes, location];
}
