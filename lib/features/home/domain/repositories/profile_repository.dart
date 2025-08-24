import 'dart:io';
import 'package:ems_1/features/auth/data/models/base_user_model.dart'; // Reusing your existing, powerful user model

abstract class ProfileRepository {
  // Fetches the full, up-to-date user profile from the server.
  Future<BaseUserModel> getUserProfile(String userId);

  // Updates the user profile. Can include a name, email, new password, and a profile image.
  Future<BaseUserModel> updateUserProfile({
    required String userId,
    required String name,
    required String email,
    String? password, // Password is optional and only sent if changed
    File? profileImage,
  });
}
