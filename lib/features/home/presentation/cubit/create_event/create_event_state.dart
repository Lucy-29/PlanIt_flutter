part of 'create_event_cubit.dart';

class CreateEventState extends Equatable {
  // Use the correct EventModel here
  final CreateEventModel eventModel;

  // This boolean will control if the "CREATE EVENT" button is enabled
  final bool isFormValid;

  const CreateEventState({
    required this.eventModel,
    required this.isFormValid,
  });

  // Helper method to create a new state with updated values
  CreateEventState copyWith({
    CreateEventModel? eventModel,
    bool? isFormValid,
  }) {
    return CreateEventState(
      eventModel: eventModel ?? this.eventModel,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [eventModel, isFormValid];
}
