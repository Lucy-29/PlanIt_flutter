import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/repositories/company_repository.dart';
import '../../../data/models/company_event_model.dart';

// States
abstract class CompanyEventsState extends Equatable {
  const CompanyEventsState();
  @override
  List<Object?> get props => [];
}

class CompanyEventsInitial extends CompanyEventsState {}
class CompanyEventsLoading extends CompanyEventsState {}

class CompanyEventsLoaded extends CompanyEventsState {
  final List<CompanyEventModel> events;
  const CompanyEventsLoaded({required this.events});
  @override
  List<Object?> get props => [events];
}

class CompanyEventsError extends CompanyEventsState {
  final String message;
  const CompanyEventsError({required this.message});
  @override
  List<Object?> get props => [message];
}

class CompanyEventsCreating extends CompanyEventsState {}
class CompanyEventsDeleting extends CompanyEventsState {}

// Cubit
class CompanyEventsCubit extends Cubit<CompanyEventsState> {
  final CompanyRepository repository;
  List<CompanyEventModel> _currentEvents = [];

  CompanyEventsCubit({required this.repository}) : super(CompanyEventsInitial());

  Future<void> loadEvents() async {
    try {
      emit(CompanyEventsLoading());
      final events = await repository.getEvents();
      _currentEvents = events;
      emit(CompanyEventsLoaded(events: events));
    } catch (e) {
      emit(CompanyEventsError(message: e.toString()));
    }
  }

  Future<void> createEvent({
    required String title,
    required String description,
    required DateTime dateTime,
    required String location,
    File? image,
    required double ticketPrice,
    required int capacity,
    required String category,
  }) async {
    try {
      emit(CompanyEventsCreating());
      final newEvent = await repository.createEvent(
        title: title,
        description: description,
        dateTime: dateTime,
        location: location,
        image: image,
        ticketPrice: ticketPrice,
        capacity: capacity,
        category: category,
      );
      _currentEvents.insert(0, newEvent);
      emit(CompanyEventsLoaded(events: List.from(_currentEvents)));
    } catch (e) {
      emit(CompanyEventsError(message: e.toString()));
      // Restore previous state
      if (_currentEvents.isNotEmpty) {
        emit(CompanyEventsLoaded(events: List.from(_currentEvents)));
      }
    }
  }

  Future<void> deleteEvent(int eventId) async {
    try {
      emit(CompanyEventsDeleting());
      await repository.deleteEvent(eventId);
      _currentEvents.removeWhere((event) => event.id == eventId);
      emit(CompanyEventsLoaded(events: List.from(_currentEvents)));
    } catch (e) {
      emit(CompanyEventsError(message: e.toString()));
      // Restore previous state
      emit(CompanyEventsLoaded(events: List.from(_currentEvents)));
    }
  }

  void refreshEvents() {
    loadEvents();
  }
}