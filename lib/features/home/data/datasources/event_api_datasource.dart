import 'package:dio/dio.dart';

class EventApiDatasource {
  final Dio dio;

  EventApiDatasource({required this.dio});

  Future<Map<String, dynamic>> createEvent(
      Map<String, dynamic> eventData) async {
    try {
      final response = await dio.post(
        '/events',
        data: eventData,
      );
      return response.data;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ??
          'Failed to create event. An unknown error occurred.';
      print("API Error during event creation: ${e.response?.data}");
      throw Exception(errorMessage);
    }
  }

  // Get provider event requests (for providers to approve/reject)
  Future<Map<String, dynamic>> getProviderRequests() async {
    try {
      final response = await dio.get('/provider/requests');
      return response.data;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ??
          'Failed to fetch provider requests.';
      print("API Error fetching provider requests: ${e.response?.data}");
      throw Exception(errorMessage);
    }
  }

  // Provider responds to event request (approve/reject)
  Future<Map<String, dynamic>> respondToEventRequest(
      String eventId, String status) async {
    try {
      final response = await dio.put(
        '/events/$eventId/respond',
        data: {'status': status}, // 'approved' or 'rejected'
      );
      return response.data;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ??
          'Failed to respond to event request.';
      print("API Error responding to event: ${e.response?.data}");
      throw Exception(errorMessage);
    }
  }

  // Get user's created events
  Future<Map<String, dynamic>> getUserEvents() async {
    try {
      final response = await dio.get('/user/events');
      return response.data;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ??
          'Failed to fetch user events.';
      print("API Error fetching user events: ${e.response?.data}");
      throw Exception(errorMessage);
    }
  }

  // Delete user event
  Future<Map<String, dynamic>> deleteEvent(String eventId) async {
    try {
      final response = await dio.delete('/events/$eventId');
      return response.data;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ??
          'Failed to delete event.';
      print("API Error deleting event: ${e.response?.data}");
      throw Exception(errorMessage);
    }
  }
}
