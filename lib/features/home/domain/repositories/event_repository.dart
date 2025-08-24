import 'package:ems_1/features/home/data/models/event_details_model.dart';
import 'package:ems_1/features/home/data/models/event_status_model.dart';

abstract class EventRepository {
  Future<EventDetailsModel> createEvent(EventDetailsModel eventDetails);
  Future<List<EventStatusModel>> getUserEvents();
  Future<void> deleteEvent(String eventId);
}
