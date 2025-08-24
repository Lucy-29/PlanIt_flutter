part of 'my_event_cubit.dart';

class MyEventState extends Equatable {
  final List<EventStatusModel> myEvents;
  final bool isLoading;
  final String? error;

  const MyEventState({
    this.myEvents = const [],
    this.isLoading = false,
    this.error,
  });

  MyEventState copyWith({
    List<EventStatusModel>? myEvents,
    bool? isLoading,
    String? error,
  }) {
    return MyEventState(
      myEvents: myEvents ?? this.myEvents,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [myEvents, isLoading, error];
}
