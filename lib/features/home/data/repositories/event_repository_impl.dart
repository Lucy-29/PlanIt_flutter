import 'package:intl/intl.dart';
import 'package:ems_1/features/home/data/models/event_details_model.dart';
import 'package:ems_1/features/home/data/models/event_status_model.dart';
import 'package:ems_1/features/home/data/datasources/event_api_datasource.dart';
import 'package:ems_1/features/home/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventApiDatasource apiDatasource;

  EventRepositoryImpl({required this.apiDatasource});

  @override
  Future<EventDetailsModel> createEvent(EventDetailsModel eventDetails) async {
    // 1. STRIP THE EMOJI FROM EVENT TYPE
    String eventTypeWithoutEmoji = eventDetails.eventType ?? '';
    if (eventTypeWithoutEmoji.contains(' ')) {
      eventTypeWithoutEmoji = eventTypeWithoutEmoji.substring(
          0, eventTypeWithoutEmoji.lastIndexOf(' '));
    }

    // 2. PREPARE DATA TO MATCH LARAVEL API EXACTLY
    final Map<String, dynamic> data = {
      'title': eventDetails.eventName,
      'description': eventDetails.description, // Always send description, even if empty
      'date': DateFormat('yyyy-MM-dd').format(eventDetails.eventDate),
      'time': DateFormat('hh:mm a').format(eventDetails.eventDate).toUpperCase(), // Laravel expects 'h:i A' format (02:30 PM)
      'is_public': eventDetails.privacy == EventPrivacy.public ? 'public' : 'private',
      'type': eventTypeWithoutEmoji,
      'location': eventDetails.location,
      'price': eventDetails.price, // Always send price for both public and private events
    };

    // Add offers if any are selected
    if (eventDetails.selectedOffers.isNotEmpty) {
      data['offers'] = eventDetails.selectedOffers.map((offer) => offer.offerId).toList();
    }

    // DEBUG: Print what we're sending to the API
    print("🚀 DEBUG - Data being sent to API:");
    print("📝 Title: ${data['title']}");
    print("📝 Description: '${data['description']}' (length: ${data['description'].toString().length})");
    print("💰 Price: ${data['price']} (type: ${data['price'].runtimeType})");
    print("🔒 Privacy: ${data['is_public']}");
    print("📅 Date: ${data['date']}");
    print("⏰ Time: ${data['time']}");
    print("📍 Location: ${data['location']}");
    print("🎯 Type: ${data['type']}");
    print("🔗 Full data: $data");

    // 3. CALL THE API
    final responseData = await apiDatasource.createEvent(data);

    // DEBUG: Print what the API returns
    print("🔙 DEBUG - API Response:");
    print("📦 Full response: $responseData");
    
    // 4. PARSE RESPONSE - Laravel returns the event directly in 'event' key
    if (responseData.containsKey('event') && responseData['event'] != null) {
      final createdEventJson = responseData['event'];
      print("✅ DEBUG - Created event from API:");
      print("📝 API returned description: '${createdEventJson['description']}'");
      print("💰 API returned price: '${createdEventJson['price']}'");
      print("🆔 API returned ID: '${createdEventJson['id']}'");
      print("🔗 Full event JSON: $createdEventJson");
      
      return eventDetails.copyWith(id: createdEventJson['id'].toString());
    } else {
      print("❌ DEBUG - Server response missing 'event' key");
      throw Exception('Server response did not contain event data.');
    }
  }

  @override
  Future<List<EventStatusModel>> getUserEvents() async {
    try {
      final responseData = await apiDatasource.getUserEvents();
      
      // DEBUG: Print the raw response to see what Laravel is sending
      print("🔍 DEBUG - Raw API Response: $responseData");
      
      // Parse the response - expecting a list of events
      if (responseData.containsKey('events') && responseData['events'] is List) {
        final eventsList = responseData['events'] as List<dynamic>;
        print("🔍 DEBUG - Found ${eventsList.length} events in 'events' key");
        return eventsList
            .map((eventJson) => EventStatusModel.fromJson(eventJson as Map<String, dynamic>))
            .toList();
      } else if (responseData.containsKey('data') && responseData['data'] is List) {
        final eventsList = responseData['data'] as List<dynamic>;
        print("🔍 DEBUG - Found ${eventsList.length} events in 'data' key");
        return eventsList
            .map((eventJson) => EventStatusModel.fromJson(eventJson as Map<String, dynamic>))
            .toList();
      } else if (responseData is List) {
        // Direct list response
        final eventsList = responseData as List<dynamic>;
        print("🔍 DEBUG - Found ${eventsList.length} events in direct list");
        return eventsList
            .map((eventJson) => EventStatusModel.fromJson(eventJson as Map<String, dynamic>))
            .toList();
      } else {
        print("🔍 DEBUG - Unexpected response format: ${responseData.runtimeType}");
        return [];
      }
    } catch (e) {
      print("❌ Error fetching user events: $e");
      throw Exception('Failed to fetch user events: $e');
    }
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    try {
      print("🗑️ DEBUG - Attempting to delete event with ID: $eventId");
      final response = await apiDatasource.deleteEvent(eventId);
      print("🗑️ DEBUG - Delete response: $response");
    } catch (e) {
      print("❌ Error deleting event: $e");
      throw Exception('Failed to delete event: $e');
    }
  }
}
