import 'package:equatable/equatable.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart';

abstract class CalendarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final List<EventCardModel> events;

  CalendarLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class CalendarError extends CalendarState {
  final String message;

  CalendarError(this.message);

  @override
  List<Object?> get props => [message];
}
