part of 'my_event_cubit.dart';

class MyEventState extends Equatable {
  // Use the final, correct model name
  final List<CreateEventModel> myEvents;

  const MyEventState({required this.myEvents});

  @override
  List<Object> get props => [myEvents];
}
