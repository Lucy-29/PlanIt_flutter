import 'package:bloc/bloc.dart';
import 'package:ems_1/features/home/data/models/create_event_model.dart';
import 'package:equatable/equatable.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit()
      : super(CreateEventState(eventModel: CreateEventModel.initial()));

  void eventNameChanged(String name) {
    emit(
        state.copyWith(eventModel: state.eventModel.copyWith(eventName: name)));
  }

  void eventDateChanged(DateTime date) {
    emit(
        state.copyWith(eventModel: state.eventModel.copyWith(eventDate: date)));
  }

  void eventTimeChanged({required int hour, required int minute}) {
    final oldDate = state.eventModel.eventDate;
    final newDate =
        DateTime(oldDate.year, oldDate.month, oldDate.day, hour, minute);
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(eventDate: newDate)));
  }

  void eventPrivacyChanged(EventPrivacy privacy) {
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(privacy: privacy)));
  }

  void eventTypeToggled(String type) {
    final currentTypes = Set<String>.from(state.eventModel.eventTypes);
    currentTypes.contains(type)
        ? currentTypes.remove(type)
        : currentTypes.add(type);
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(eventTypes: currentTypes)));
  }

  void locationChanged(String location) {
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(location: location)));
  }

  void createEvent() {
    print("--- CREATING EVENT ---");
    print("Name: ${state.eventModel.eventName}");
    print("Date & Time: ${state.eventModel.eventDate}");
    print("Privacy: ${state.eventModel.privacy}");
    print("Types: ${state.eventModel.eventTypes}");
    print("Location: ${state.eventModel.location}");
    print("----------------------");
  }
}
