part of 'create_event_cubit.dart';

class CreateEventState extends Equatable {
  final CreateEventModel eventModel;

  const CreateEventState({required this.eventModel});

  CreateEventState copyWith({CreateEventModel? eventModel}) {
    return CreateEventState(eventModel: eventModel ?? this.eventModel);
  }

  @override
  List<Object?> get props => [eventModel];
}
