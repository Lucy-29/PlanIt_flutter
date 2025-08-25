import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../cubit/gallery/company_gallery_cubit.dart';
import '../cubit/profile/company_profile_cubit.dart';
import '../cubit/profile/company_profile_state.dart';
import '../../../auth/presentation/cubit/auth/auth_cubit.dart';

class CompanyGalleryScreen extends StatefulWidget {
  const CompanyGalleryScreen({super.key});

  @override
  State<CompanyGalleryScreen> createState() => _CompanyGalleryScreenState();
}

class _CompanyGalleryScreenState extends State<CompanyGalleryScreen> {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadGallery();
  }

  void _loadGallery() {
    final authState = context.read<AuthCubit>().state;
    if (authState is Authenticated) {
      final companyId = authState.user.id;
      context.read<CompanyProfileCubit>().loadProfile(companyId);
    }
  }

  Future<void> _addImages() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (images.isNotEmpty) {
        final authState = context.read<AuthCubit>().state;
        if (authState is Authenticated) {
          final companyId = authState.user.id;
          final imageFiles = images.map((image) => File(image.path)).toList();
          
          if (mounted) {
            context.read<CompanyGalleryCubit>().addImages(
              companyId: companyId,
              images: imageFiles,
            );
          }
        }
      }
    } catch (e) {
      _showError('Failed to pick images: $e');
    }
  }

  void _removeImage(int imageId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Image'),
          content: const Text('Are you sure you want to remove this image from your gallery?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<CompanyGalleryCubit>().removeImage(imageId);
              },
              child: Text(
                'Remove',
                style: TextStyle(color: Colors.red.shade600),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildAddImageButton() {
    return GestureDetector(
      onTap: _addImages,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: Colors.orange.shade600,
                size: 30,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add Images',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryImage(String imageUrl, int imageId) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => _removeImage(imageId),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.red.shade600,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Gallery'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        actions: [
          IconButton(
            onPressed: _addImages,
            icon: const Icon(Icons.add_photo_alternate),
          ),
        ],
      ),
      body: BlocConsumer<CompanyGalleryCubit, CompanyGalleryState>(
        listener: (context, state) {
          if (state is CompanyGalleryError) {
            _showError(state.message);
          } else if (state is CompanyGalleryLoaded) {
            _showSuccess('Gallery updated successfully');
          }
        },
        builder: (context, galleryState) {
          return BlocBuilder<CompanyProfileCubit, CompanyProfileState>(
            builder: (context, profileState) {
              if (profileState is CompanyProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (profileState is CompanyProfileLoaded || 
                  profileState is CompanyProfileUpdated) {
                final profile = profileState is CompanyProfileLoaded 
                    ? profileState.profile 
                    : (profileState as CompanyProfileUpdated).profile;

                // Initialize gallery with profile data if not already loaded
                if (galleryState is CompanyGalleryInitial && profile.gallery != null && profile.gallery!.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<CompanyGalleryCubit>().loadImages(profile.gallery!);
                  });
                }

                List<dynamic> galleryImages = [];
                if (galleryState is CompanyGalleryLoaded) {
                  galleryImages = galleryState.images;
                } else if (profile.gallery != null) {
                  galleryImages = profile.gallery!.cast<dynamic>();
                }

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Gallery',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Showcase your work and attract more customers',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      if (galleryState is CompanyGalleryUploading || 
                          galleryState is CompanyGalleryDeleting)
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                galleryState is CompanyGalleryUploading 
                                    ? 'Uploading images...' 
                                    : 'Removing image...',
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1,
                          ),
                          itemCount: galleryImages.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return _buildAddImageButton();
                            }
                            
                            final imageIndex = index - 1;
                            final image = galleryImages[imageIndex];
                            
                            String imageUrl = '';
                            int imageId = 0;
                            
                            if (image is Map<String, dynamic>) {
                              imageUrl = image['image_url'] ?? '';
                              imageId = image['id'] ?? 0;
                            } else {
                              imageUrl = image.imageUrl ?? '';
                              imageId = image.id ?? 0;
                            }
                            
                            return _buildGalleryImage(imageUrl, imageId);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (profileState is CompanyProfileError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load gallery',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profileState.message,
                        style: TextStyle(color: Colors.grey.shade600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadGallery,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}