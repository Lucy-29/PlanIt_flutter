import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/approval_status_model.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'approval_state.dart';

class ApprovalCubit extends Cubit<ApprovalState> {
  final AuthRepository _authRepository;

  ApprovalCubit(this._authRepository) : super(ApprovalInitial());

  Future<void> checkStatus(String email) async {
    emit(ApprovalLoading());
    try {
      final statusModel =
          await _authRepository.checkApprovalStatus(email: email);

      if (statusModel.status == 'approved') {
        emit(ApprovalStatusApproved(statusModel));
      } else if (statusModel.status == 'pending') {
        emit(ApprovalStatusPending(statusModel));
      } else {
        emit(const ApprovalFailure(
            'Your registration could not be found. Please contact support.'));
      }
    } catch (e) {
      emit(ApprovalFailure(e.toString()));
    }
  }
}
