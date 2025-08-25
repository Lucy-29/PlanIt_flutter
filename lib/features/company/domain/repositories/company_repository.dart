import 'dart:io';
import '../../../company/data/models/company_profile_model.dart';
import '../../../company/data/models/gallery_image_model.dart';
import '../../../company/data/models/company_event_model.dart';
import '../../../company/data/models/company_statistics_model.dart';

abstract class CompanyRepository {
  // Profile Management
  Future<CompanyProfileModel> getProfile(int companyId);
  Future<CompanyProfileModel> updateProfile({
    required int companyId,
    String? name,
    String? email,
    String? description,
    List<String>? specializations,
    File? profileImage,
  });

  // Gallery Management
  Future<List<GalleryImageModel>> addToGallery({
    required int companyId,
    required List<File> images,
  });
  Future<void> removeFromGallery(int imageId);

  // Event Management
  Future<CompanyEventModel> createEvent({
    required String title,
    required String description,
    required DateTime dateTime,
    required String location,
    File? image,
    required double ticketPrice,
    required int capacity,
    required String category,
  });
  Future<List<CompanyEventModel>> getEvents();
  Future<CompanyEventModel> getEvent(int eventId);
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
  });
  Future<void> deleteEvent(int eventId);

  // Statistics
  Future<CompanyStatisticsModel> getStatistics();
}