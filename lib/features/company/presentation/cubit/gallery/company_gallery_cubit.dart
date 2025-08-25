import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/repositories/company_repository.dart';
import '../../../data/models/gallery_image_model.dart';

// States
abstract class CompanyGalleryState extends Equatable {
  const CompanyGalleryState();
  @override
  List<Object?> get props => [];
}

class CompanyGalleryInitial extends CompanyGalleryState {}
class CompanyGalleryLoading extends CompanyGalleryState {}

class CompanyGalleryLoaded extends CompanyGalleryState {
  final List<GalleryImageModel> images;
  const CompanyGalleryLoaded({required this.images});
  @override
  List<Object?> get props => [images];
}

class CompanyGalleryError extends CompanyGalleryState {
  final String message;
  const CompanyGalleryError({required this.message});
  @override
  List<Object?> get props => [message];
}

class CompanyGalleryUploading extends CompanyGalleryState {}
class CompanyGalleryDeleting extends CompanyGalleryState {}

// Cubit
class CompanyGalleryCubit extends Cubit<CompanyGalleryState> {
  final CompanyRepository repository;
  List<GalleryImageModel> _currentImages = [];

  CompanyGalleryCubit({required this.repository}) : super(CompanyGalleryInitial());

  void loadImages(List<GalleryImageModel> images) {
    _currentImages = images;
    emit(CompanyGalleryLoaded(images: images));
  }

  Future<void> addImages({
    required int companyId,
    required List<File> images,
  }) async {
    try {
      emit(CompanyGalleryUploading());
      final newImages = await repository.addToGallery(
        companyId: companyId,
        images: images,
      );
      _currentImages.addAll(newImages);
      emit(CompanyGalleryLoaded(images: List.from(_currentImages)));
    } catch (e) {
      emit(CompanyGalleryError(message: e.toString()));
      // Restore previous state
      emit(CompanyGalleryLoaded(images: List.from(_currentImages)));
    }
  }

  Future<void> removeImage(int imageId) async {
    try {
      emit(CompanyGalleryDeleting());
      await repository.removeFromGallery(imageId);
      _currentImages.removeWhere((image) => image.id == imageId);
      emit(CompanyGalleryLoaded(images: List.from(_currentImages)));
    } catch (e) {
      emit(CompanyGalleryError(message: e.toString()));
      // Restore previous state
      emit(CompanyGalleryLoaded(images: List.from(_currentImages)));
    }
  }
}