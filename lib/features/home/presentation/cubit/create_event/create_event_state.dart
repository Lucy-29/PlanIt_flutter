part of 'create_event_cubit.dart';

// An enum to represent the form's submission status
enum FormSubmissionStatus { initial, submitting, success, failure }

class CreateEventState extends Equatable {
  final EventDetailsModel eventModel;
  final bool isFormValid;
  // 👇 --- ADD THIS NEW FIELD --- 👇
  final FormSubmissionStatus submissionStatus;

  const CreateEventState({
    required this.eventModel,
    required this.isFormValid,
    this.submissionStatus = FormSubmissionStatus.initial, // Default to initial
  });

  CreateEventState copyWith({
    EventDetailsModel? eventModel,
    bool? isFormValid,
    FormSubmissionStatus? submissionStatus, // Allow updating the status
  }) {
    return CreateEventState(
      eventModel: eventModel ?? this.eventModel,
      isFormValid: isFormValid ?? this.isFormValid,
      submissionStatus:
          submissionStatus ?? this.submissionStatus, // Update the status
    );
  }

  @override
  List<Object?> get props => [eventModel, isFormValid, submissionStatus];
}
