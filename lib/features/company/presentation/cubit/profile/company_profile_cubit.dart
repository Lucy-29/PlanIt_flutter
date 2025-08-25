import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/company_repository.dart';
import 'company_profile_state.dart';

class CompanyProfileCubit extends Cubit<CompanyProfileState> {
  final CompanyRepository repository;

  CompanyProfileCubit({required this.repository}) : super(CompanyProfileInitial());

  Future<void> loadProfile(int companyId) async {
    try {
      emit(CompanyProfileLoading());
      final profile = await repository.getProfile(companyId);
      emit(CompanyProfileLoaded(profile: profile));
    } catch (e) {
      emit(CompanyProfileError(message: e.toString()));
    }
  }

  Future<void> updateProfile({
    required int companyId,
    String? name,
    String? email,
    String? description,
    List<String>? specializations,
    File? profileImage,
  }) async {
    try {
      emit(CompanyProfileUpdating());
      final updatedProfile = await repository.updateProfile(
        companyId: companyId,
        name: name,
        email: email,
        description: description,
        specializations: specializations,
        profileImage: profileImage,
      );
      emit(CompanyProfileUpdated(profile: updatedProfile));
      // Also emit loaded state to show updated data
      emit(CompanyProfileLoaded(profile: updatedProfile));
    } catch (e) {
      emit(CompanyProfileError(message: e.toString()));
    }
  }
}