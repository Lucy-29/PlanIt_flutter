part of 'approval_cubit.dart';

abstract class ApprovalState extends Equatable {
  const ApprovalState();
  @override
  List<Object> get props => [];
}

class ApprovalInitial extends ApprovalState {}

class ApprovalLoading extends ApprovalState {}

class ApprovalStatusPending extends ApprovalState {
  final ApprovalStatusModel status;
  const ApprovalStatusPending(this.status);
  @override
  List<Object> get props => [status];
}

class ApprovalStatusApproved extends ApprovalState {
  final ApprovalStatusModel status;
  const ApprovalStatusApproved(this.status);
  @override
  List<Object> get props => [status];
}

class ApprovalFailure extends ApprovalState {
  final String error;
  const ApprovalFailure(this.error);
  @override
  List<Object> get props => [error];
}
