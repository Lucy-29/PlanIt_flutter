// ... imports
import 'package:ems_1/features/home/data/models/create_event_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_event_state.dart';

class MyEventCubit extends Cubit<MyEventState> {
  MyEventCubit() : super(const MyEventState(myEvents: []));

  void addEvent(CreateEventModel newEvent) {
    final updatedList = List<CreateEventModel>.from(state.myEvents)
      ..add(newEvent);
    emit(MyEventState(myEvents: updatedList));
  }

  void deleteEvent(CreateEventModel eventToDelete) {
    // We now delete by checking the unique ID
    final updatedList = List<CreateEventModel>.from(state.myEvents)
      ..removeWhere((event) => event.id == eventToDelete.id);
    emit(MyEventState(myEvents: updatedList));
  }

  void editEvent(CreateEventModel updatedEvent) {
    // The edit method now only needs the updated event.
    // It finds the event to replace by its unique ID.
    final index =
        state.myEvents.indexWhere((event) => event.id == updatedEvent.id);
    if (index != -1) {
      final updatedList = List<CreateEventModel>.from(state.myEvents);
      updatedList[index] = updatedEvent;
      emit(MyEventState(myEvents: updatedList));
    }
  }
}
