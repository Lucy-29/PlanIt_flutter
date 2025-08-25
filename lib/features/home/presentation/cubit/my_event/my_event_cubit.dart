import 'package:ems_1/features/home/data/models/event_details_model.dart';
import 'package:ems_1/features/home/data/models/event_status_model.dart';
import 'package:ems_1/features/home/domain/repositories/event_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_event_state.dart';

class MyEventCubit extends Cubit<MyEventState> {
  final EventRepository _eventRepository;

  MyEventCubit(this._eventRepository) : super(const MyEventState());

  // Load events from API
  Future<void> loadMyEvents() async {
    emit(state.copyWith(isLoading: true, error: null));
    
    try {
      final events = await _eventRepository.getUserEvents();
      emit(state.copyWith(
        myEvents: events, 
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false, 
        error: e.toString(),
      ));
    }
  }

  // Add event locally (for immediate UI update after creation)
  void addEvent(EventDetailsModel newEvent) {
    // Convert to EventStatusModel for consistency
    // Business logic: Public events without offers are auto-approved
    final eventStatusValue = (newEvent.privacy == EventPrivacy.public && newEvent.selectedOffers.isEmpty) 
        ? EventStatus.approved 
        : EventStatus.pending;
    
    final eventStatus = EventStatusModel(
      eventId: newEvent.id,
      status: eventStatusValue,
      title: newEvent.eventName,
      date: newEvent.eventDate.toString().split(' ')[0],
      time: '${newEvent.eventDate.hour}:${newEvent.eventDate.minute.toString().padLeft(2, '0')}',
      description: newEvent.description,
      price: newEvent.privacy == EventPrivacy.public ? newEvent.price : null,
      eventType: newEvent.eventType,
      privacy: newEvent.privacy.name,
      location: newEvent.location,
      organizerName: null, // Will be populated when we refresh from API
      invitationCode: null,
      offers: [], // Will be populated when we refresh from API
    );
    
    final updatedList = List<EventStatusModel>.from(state.myEvents)
      ..insert(0, eventStatus); // Add to beginning
    emit(state.copyWith(myEvents: updatedList));
  }

  // Delete event via API
  Future<void> deleteEvent(EventStatusModel eventToDelete) async {
    try {
      await _eventRepository.deleteEvent(eventToDelete.eventId);
      
      // Remove from local state
      final updatedList = List<EventStatusModel>.from(state.myEvents)
        ..removeWhere((event) => event.eventId == eventToDelete.eventId);
      emit(state.copyWith(myEvents: updatedList));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to delete event: $e'));
    }
  }

  // Edit event (for backward compatibility)
  void editEvent(EventDetailsModel updatedEvent) {
    // Convert to EventStatusModel for consistency
    // Business logic: Public events without offers are auto-approved
    final eventStatusValue = (updatedEvent.privacy == EventPrivacy.public && updatedEvent.selectedOffers.isEmpty) 
        ? EventStatus.approved 
        : EventStatus.pending;
    
    final eventStatus = EventStatusModel(
      eventId: updatedEvent.id,
      status: eventStatusValue,
      title: updatedEvent.eventName,
      date: updatedEvent.eventDate.toString().split(' ')[0],
      time: '${updatedEvent.eventDate.hour}:${updatedEvent.eventDate.minute.toString().padLeft(2, '0')}',
      description: updatedEvent.description,
      price: updatedEvent.privacy == EventPrivacy.public ? updatedEvent.price : null,
      eventType: updatedEvent.eventType,
      privacy: updatedEvent.privacy.name,
      location: updatedEvent.location,
      organizerName: null, // Will be populated when we refresh from API
      invitationCode: null,
      offers: [], // Will be populated when we refresh from API
    );
    
    // Find and replace the event
    final index = state.myEvents.indexWhere((event) => event.eventId == updatedEvent.id);
    if (index != -1) {
      final updatedList = List<EventStatusModel>.from(state.myEvents);
      updatedList[index] = eventStatus;
      emit(state.copyWith(myEvents: updatedList));
    }
  }

  // Refresh events from API
  Future<void> refreshEvents() async {
    await loadMyEvents();
  }
}
