import 'dart:io';

import 'package:ems_1/features/auth/data/models/base_user_model.dart';
import 'package:ems_1/features/home/domain/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(const ProfileState());

  // --- ACTIONS ---

  /// Fetches the user's profile data from the server.
  /// This should be called when the profile screen is first loaded.
  Future<void> loadUserProfile(String userId) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = await _profileRepository.getUserProfile(userId);
      emit(state.copyWith(status: ProfileStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        errorMessage: 'Failed to load profile. Please try again.',
      ));
    }
  }

  /// Submits the updated profile data to the server.
  /// The `userId` is taken from the current user data in the state.
  Future<void> updateUserProfile({
    required String name,
    required String email,
    File? pickedImage,
  }) async {
    if (state.user == null) return; // Safety check

    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      // Call the repository to perform the update
      final updatedUser = await _profileRepository.updateUserProfile(
        userId: state.user!.id.toString(),
        name: name,
        email: email,
        profileImage: pickedImage,
        // We'll leave the password part out for now to keep the UI simple,
        // but it could be added here.
      );

      // On success, update the state with the new user data
      emit(state.copyWith(status: ProfileStatus.success, user: updatedUser));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        errorMessage:
            e.toString(), // Pass the specific error message from the repo
      ));
    }
  }
}
