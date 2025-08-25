import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../cubit/profile/company_profile_cubit.dart';
import '../cubit/profile/company_profile_state.dart';
import '../../../auth/presentation/cubit/auth/auth_cubit.dart';
import 'company_gallery_screen.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    final authState = context.read<AuthCubit>().state;
    if (authState is Authenticated) {
      final companyId = authState.user.id;
      context.read<CompanyProfileCubit>().loadProfile(companyId);
    }
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        _updateProfile();
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    }
  }

  void _updateProfile() {
    final authState = context.read<AuthCubit>().state;
    if (authState is Authenticated) {
      final companyId = authState.user.id;
      print('Profile Screen: Updating profile for company ID: $companyId');
      print('Profile Screen: Name: ${_companyNameController.text}');
      print('Profile Screen: Email: ${_emailController.text}');
      print('Profile Screen: Description: ${_descriptionController.text}');
      
      context.read<CompanyProfileCubit>().updateProfile(
        companyId: companyId,
        name: _companyNameController.text.isNotEmpty ? _companyNameController.text : null,
        email: _emailController.text.isNotEmpty ? _emailController.text : null,
        description: _descriptionController.text.isNotEmpty ? _descriptionController.text : null,
        profileImage: _selectedImage,
      );
    } else {
      print('Profile Screen: No authenticated user found!');
    }
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

  Widget _buildProfileImage(String? imageUrl) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade300, width: 2),
        ),
        child: _selectedImage != null 
            ? ClipOval(
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                ),
              )
            : imageUrl != null 
                ? ClipOval(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
                    ),
                  )
                : _buildPlaceholderImage(),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.orange.shade400, Colors.red.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.business,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSpecializationChips(List<String>? specializations) {
    if (specializations == null || specializations.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: specializations.map((specialization) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            specialization,
            style: TextStyle(
              color: Colors.green.shade700,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Your Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: BlocConsumer<CompanyProfileCubit, CompanyProfileState>(
        listener: (context, state) {
          if (state is CompanyProfileError) {
            _showError(state.message);
          } else if (state is CompanyProfileUpdated) {
            _showSuccess('Profile updated successfully');
            setState(() {
              _selectedImage = null; // Reset selected image after update
            });
          }
        },
        builder: (context, state) {
          if (state is CompanyProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CompanyProfileLoaded || state is CompanyProfileUpdated) {
            final profile = state is CompanyProfileLoaded 
                ? state.profile 
                : (state as CompanyProfileUpdated).profile;

            // Populate text controllers if they're empty
            if (_companyNameController.text.isEmpty) {
              _companyNameController.text = profile.name;
            }
            if (_emailController.text.isEmpty) {
              _emailController.text = profile.email;
            }
            if (_descriptionController.text.isEmpty && profile.description != null) {
              _descriptionController.text = profile.description!;
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Profile Image
                  _buildProfileImage(profile.profileImage),
                  const SizedBox(height: 16),
                  
                  // Company Name
                  Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Rating Stars (placeholder for now)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Icon(
                        index < 3 ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                        size: 24,
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  
                  // Specialization Chips
                  _buildSpecializationChips(profile.specializations),
                  const SizedBox(height: 24),
                  
                  // Form Fields
                  _buildTextField(
                    controller: _companyNameController,
                    label: 'company name',
                    hintText: 'Enter company name',
                  ),
                  
                  _buildTextField(
                    controller: _emailController,
                    label: 'email',
                    hintText: 'Enter email address',
                  ),
                  
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'about us',
                    hintText: 'company description ........',
                    maxLines: 4,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Update Profile Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Update Profile',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Gallery Section - Clean Design
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: profile.gallery != null && profile.gallery!.isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: profile.gallery!.length,
                                  itemBuilder: (context, index) {
                                    final image = profile.gallery![index];
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      margin: const EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(image.imagePath),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    'No gallery images yet',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Gallery Edit Icon
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CompanyGalleryScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.orange.shade200,
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.orange.shade600,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          if (state is CompanyProfileError) {
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
                    'Failed to load profile',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: TextStyle(color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadProfile,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}