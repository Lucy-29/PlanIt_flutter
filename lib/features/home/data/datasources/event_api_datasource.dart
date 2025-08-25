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
      print("🔍 DEBUG - Making request to /user/events");
      final response = await dio.get('/user/events');
      print("✅ DEBUG - Successfully got user events: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      print("❌ DEBUG - DioException details:");
      print("   Status Code: ${e.response?.statusCode}");
      print("   Response Data: ${e.response?.data}");
      print("   Request Path: ${e.requestOptions.path}");
      print("   Headers: ${e.requestOptions.headers}");
      
      if (e.response?.statusCode == 401) {
        throw Exception('Authentication required. Please log in again.');
      } else if (e.response?.statusCode == 404) {
        throw Exception('User events endpoint not found. Check your API.');
      } else {
        final errorMessage = e.response?.data?['message'] ??
            'Failed to fetch user events.';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print("❌ DEBUG - Other error: $e");
      throw Exception('Network error: $e');
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
