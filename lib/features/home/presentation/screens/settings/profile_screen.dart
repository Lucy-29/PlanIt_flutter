import 'dart:io';

import 'package:ems_1/core/service_locator/service_locator.dart';
import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:ems_1/features/home/domain/repositories/profile_repository.dart';
import 'package:ems_1/features/home/presentation/cubit/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We get the current user's ID from the global AuthCubit.
    final authState = context.read<AuthCubit>().state;
    if (authState is! Authenticated) {
      // This is a safety net. This screen should not be accessible
      // if the user is not authenticated.
      return const Scaffold(body: Center(child: Text("User not found")));
    }

    // Provide the ProfileCubit to the screen.
    return BlocProvider(
      create: (context) =>
          ProfileCubit(profileRepository: sl<ProfileRepository>())
            // Immediately trigger the initial data load.
            ..loadUserProfile(authState.user.id.toString()),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // BlocListener is for "side effects" that shouldn't happen during a build.
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.success && state.user != null) {
          // On initial load OR after a successful update, update the text fields.
          _nameController.text = state.user!.name;
          _emailController.text = state.user!.email;

          // **THE HANDOFF**: After a successful update, tell the global AuthCubit
          // about the new user details so the whole app is aware of the change.
          context.read<AuthCubit>().updateAuthenticatedUser(state.user!);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: Colors.green),
          );
        }
        if (state.status == ProfileStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(state.errorMessage ?? 'An unknown error occurred'),
                backgroundColor: Colors.red),
          );
        }
      },
      // BlocBuilder rebuilds the UI based on the state.
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          // If the profile is loading for the first time, show a centered spinner.
          if (state.status == ProfileStatus.loading && state.user == null) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }

          // If there is no user data (e.g., initial state or error on load), show empty screen.
          if (state.user == null) {
            return Scaffold(
                appBar: AppBar(title: const Text('Profile')),
                body:
                    const Center(child: Text('Could not load profile data.')));
          }

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: theme.scaffoldBackgroundColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: theme.appBarTheme.titleTextStyle?.color),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              title: Text('Profile', style: theme.appBarTheme.titleTextStyle),
            ),
            body: AbsorbPointer(
              // Disable UI interactions while an update is in progress
              absorbing: state.status == ProfileStatus.loading,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 20.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _pickedImage != null
                                ? FileImage(_pickedImage!) as ImageProvider
                                : (state.user?.profileImageUrl != null
                                    ? NetworkImage(state.user!.profileImageUrl!)
                                    : const AssetImage(
                                            'assets/images/avatar2.jpg')
                                        as ImageProvider),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text('Change Image'),
                        ),
                        const SizedBox(height: 30),
                        _buildProfileTextField(
                            label: 'Username', controller: _nameController),
                        const SizedBox(height: 16),
                        _buildProfileTextField(
                            label: 'Email', controller: _emailController),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('CANCEL'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF9FB3B5),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ProfileCubit>().updateUserProfile(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      pickedImage: _pickedImage,
                                    );
                              },
                              child: const Text('DONE'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Show a loading overlay during updates
                  if (state.status == ProfileStatus.loading)
                    Container(
                      color: Colors.black.withOpacity(0.3),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Your _buildProfileTextField helper method is perfect and does not need to be changed.
  Widget _buildProfileTextField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[700]
                : Colors.grey[300],
            suffixIcon: const Icon(Icons.edit, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF206173), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
