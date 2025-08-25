import 'package:dio/dio.dart';
import 'dart:io';

class CompanyApiDatasource {
  final Dio dio;

  CompanyApiDatasource({required this.dio});

  // Profile Management
  Future<Map<String, dynamic>> getProfile(int companyId) async {
    try {
      print('Calling: GET /company/profile/$companyId');
      final response = await dio.get('/company/profile/$companyId');
      print('Profile response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('Profile error: ${e.response?.data}');
      final errorMessage = e.response?.data?['message'] ?? 
          'Failed to fetch company profile';
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    required int companyId,
    String? name,
    String? email, 
    String? description,
    List<String>? specializations,
    File? profileImage,
  }) async {
    try {
      print('Updating company profile for ID: $companyId');
      print('Data: name=$name, email=$email, description=$description, specializations=$specializations');
      
      FormData formData = FormData();
      
      // Add _method override for Laravel compatibility (like user profile)
      formData.fields.add(const MapEntry('_method', 'PUT'));
      
      if (name != null) formData.fields.add(MapEntry('name', name));
      if (email != null) formData.fields.add(MapEntry('email', email));
      if (description != null) formData.fields.add(MapEntry('description', description));
      if (specializations != null) {
        for (int i = 0; i < specializations.length; i++) {
          formData.fields.add(MapEntry('specializations[$i]', specializations[i]));
        }
      }
      if (profileImage != null) {
        formData.files.add(MapEntry(
          'profile_image',
          await MultipartFile.fromFile(profileImage.path),
        ));
      }

      print('Calling: POST /company/profile/$companyId with ${formData.fields.length} fields (using _method=PUT)');
      
      // Use POST with _method override (like user profile)
      final response = await dio.post(
        '/company/profile/$companyId', 
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      
      print('Update response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('Profile update error: ${e.response?.data}');
      print('Status code: ${e.response?.statusCode}');
      final errorMessage = e.response?.data?['message'] ?? 
          'Failed to update company profile';
      throw Exception(errorMessage);
    }
  }

  // Gallery Management
  Future<Map<String, dynamic>> addToGallery({
    required int companyId,
    required List<File> images,
  }) async {
    try {
      FormData formData = FormData();
      
      for (int i = 0; i < images.length; i++) {
        formData.files.add(MapEntry(
          'images[$i]',
          await MultipartFile.fromFile(images[i].path),
        ));
      }

      final response = await dio.post('/company/gallery/$companyId', data: formData);
      return response.data;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? 
          'Failed to upload images to gallery';
      throw Exception(errorMessage);
    }
  }

  Future<void> removeFromGallery(int imageId) async {
    try {
      await dio.delete('/company/gallery/$imageId');
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? 
          'Failed to remove image from gallery';
      throw Exception(errorMessage);
    }
  }

  // Event Management
  Future<Map<String, dynamic>> createEvent({
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
      FormData formData = FormData.fromMap({
        'title': title,
        'description': description,
        'date_time': dateTime.toIso8601String(),
        'location': location,
        'ticket_price': ticketPrice,
        'capacity': capacity,
        'category': category,
      });

      if (image != null) {
        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(image.path),
        ));
      }

      print('Calling: POST /company/events with data: ${{
        'title': title,
        'description': description,
        'date_time': dateTime.toIso8601String(),
        'location': location,
        'ticket_price': ticketPrice,
        'capacity': capacity,
        'category': category,
      }}');
      
      final response = await dio.post('/company/events', data: formData);
      print('Create event response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('Create event error: ${e.response?.data}');
      print('Full error: ${e.toString()}');
      final errorMessage = e.response?.data?['message'] ?? 
          'Failed to create event';
      throw Exception(errorMessage);
    }
  }

  Future<List<dynamic>> getEvents() async {
    try {
      print('Calling: GET /company/events');
      final response = await dio.get('/company/events');
      print('Events response: ${response.data}');
      
      // Handle different response formats
      if (response.data is List) {
        return response.data as List<dynamic>;
      } else if (response.data is Map && response.data.containsKey('events')) {
        return response.data['events'] as List<dynamic>;
      } else {
        return response.data as List<dynamic>;
      }
    } on DioException catch (e) {
      print('Events error: ${e.response?.data}');
      print('Full error: ${e.toString()}');
      final errorMessage = e.response?.data?['message'] ?? 
          'Failed to fetch company events';
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> getEvent(int eventId) async {
    try {
      final response = await dio.get('/company/events/$eventId');
      return response.data;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? 
          'Failed to fetch event';
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> updateEvent({
    required int eventId,
    String? title,
    String? description,
    DateTime? dateTime,
    String? location,
    File? image,
    double? ticketPrice,
    int? capacity,
    String? category,
  }) async {
    try {
      FormData formData = FormData();
      
      if (title != null) formData.fields.add(MapEntry('title', title));
      if (description != null) formData.fields.add(MapEntry('description', description));
      if (dateTime != null) formData.fields.add(MapEntry('date_time', dateTime.toIso8601String()));
      if (location != null) formData.fields.add(MapEntry('location', location));
      if (ticketPrice != null) formData.fields.add(MapEntry('ticket_price', ticketPrice.toString()));
      if (capacity != null) formData.fields.add(MapEntry('capacity', capacity.toString()));
      if (category != null) formData.fields.add(MapEntry('category', category));
      
      if (image != null) {
        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(image.path),
        ));
      }

      final response = await dio.put('/company/events/$eventId', data: formData);
      return response.data;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? 
          'Failed to update event';
      throw Exception(errorMessage);
    }
  }

  Future<void> deleteEvent(int eventId) async {
    try {
      await dio.delete('/company/events/$eventId');
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? 
          'Failed to delete event';
      throw Exception(errorMessage);
    }
  }

  // Statistics
  Future<Map<String, dynamic>> getStatistics() async {
    try {
      print('Calling: GET /company/statistics');
      final response = await dio.get('/company/statistics');
      print('Statistics response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('Statistics error: ${e.response?.data}');
      print('Full error: ${e.toString()}');
      final errorMessage = e.response?.data?['message'] ?? 
          'Failed to fetch company statistics';
      throw Exception(errorMessage);
    }
  }
}