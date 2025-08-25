import 'dart:io';
import '../../domain/repositories/company_repository.dart';
import '../datasources/company_api_datasource.dart';
import '../models/company_profile_model.dart';
import '../models/gallery_image_model.dart';
import '../models/company_event_model.dart';
import '../models/company_statistics_model.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyApiDatasource apiDatasource;

  CompanyRepositoryImpl({required this.apiDatasource});

  @override
  Future<CompanyProfileModel> getProfile(int companyId) async {
    try {
      final response = await apiDatasource.getProfile(companyId);
      return CompanyProfileModel.fromJson(response['company']);
    } catch (e) {
      throw Exception('Failed to fetch company profile: ${e.toString()}');
    }
  }

  @override
  Future<CompanyProfileModel> updateProfile({
    required int companyId,
    String? name,
    String? email,
    String? description,
    List<String>? specializations,
    File? profileImage,
  }) async {
    try {
      final response = await apiDatasource.updateProfile(
        companyId: companyId,
        name: name,
        email: email,
        description: description,
        specializations: specializations,
        profileImage: profileImage,
      );
      return CompanyProfileModel.fromJson(response['company']);
    } catch (e) {
      throw Exception('Failed to update company profile: ${e.toString()}');
    }
  }

  @override
  Future<List<GalleryImageModel>> addToGallery({
    required int companyId,
    required List<File> images,
  }) async {
    try {
      final response = await apiDatasource.addToGallery(
        companyId: companyId,
        images: images,
      );
      final List<dynamic> imagesList = response['images'];
      return imagesList.map((json) => GalleryImageModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to add images to gallery: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFromGallery(int imageId) async {
    try {
      await apiDatasource.removeFromGallery(imageId);
    } catch (e) {
      throw Exception('Failed to remove image from gallery: ${e.toString()}');
    }
  }

  @override
  Future<CompanyEventModel> createEvent({
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
      final response = await apiDatasource.createEvent(
        title: title,
        description: description,
        dateTime: dateTime,
        location: location,
        image: image,
        ticketPrice: ticketPrice,
        capacity: capacity,
        category: category,
      );
      // The Laravel API might return 'request' or 'event' - let's check both
      final eventData = response['event'] ?? response['request'];
      return CompanyEventModel.fromJson(eventData);
    } catch (e) {
      throw Exception('Failed to create event: ${e.toString()}');
    }
  }

  @override
  Future<List<CompanyEventModel>> getEvents() async {
    try {
      final response = await apiDatasource.getEvents();
      // The API datasource returns Map<String, dynamic>
      final eventsData = response['events'] ?? response['data'] ?? response;
      
      List<dynamic> eventsList = [];
      if (eventsData is List) {
        eventsList = List<dynamic>.from(eventsData);
      }
      return eventsList.map((json) => CompanyEventModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch company events: ${e.toString()}');
    }
  }

  @override
  Future<CompanyEventModel> getEvent(int eventId) async {
    try {
      final response = await apiDatasource.getEvent(eventId);
      return CompanyEventModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch event: ${e.toString()}');
    }
  }

  @override
  Future<CompanyEventModel> updateEvent({
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
      final response = await apiDatasource.updateEvent(
        eventId: eventId,
        title: title,
        description: description,
        dateTime: dateTime,
        location: location,
        image: image,
        ticketPrice: ticketPrice,
        capacity: capacity,
        category: category,
      );
      return CompanyEventModel.fromJson(response['event']);
    } catch (e) {
      throw Exception('Failed to update event: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteEvent(int eventId) async {
    try {
      await apiDatasource.deleteEvent(eventId);
    } catch (e) {
      throw Exception('Failed to delete event: ${e.toString()}');
    }
  }

  @override
  Future<CompanyStatisticsModel> getStatistics() async {
    try {
      final response = await apiDatasource.getStatistics();
      return CompanyStatisticsModel.fromJson(response['statistics']);
    } catch (e) {
      throw Exception('Failed to fetch company statistics: ${e.toString()}');
    }
  }
}