import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/repositories/company_repository.dart';
import '../../../data/models/company_statistics_model.dart';

// States
abstract class CompanyStatisticsState extends Equatable {
  const CompanyStatisticsState();
  @override
  List<Object?> get props => [];
}

class CompanyStatisticsInitial extends CompanyStatisticsState {}
class CompanyStatisticsLoading extends CompanyStatisticsState {}

class CompanyStatisticsLoaded extends CompanyStatisticsState {
  final CompanyStatisticsModel statistics;
  const CompanyStatisticsLoaded({required this.statistics});
  @override
  List<Object?> get props => [statistics];
}

class CompanyStatisticsError extends CompanyStatisticsState {
  final String message;
  const CompanyStatisticsError({required this.message});
  @override
  List<Object?> get props => [message];
}

// Cubit
class CompanyStatisticsCubit extends Cubit<CompanyStatisticsState> {
  final CompanyRepository repository;

  CompanyStatisticsCubit({required this.repository}) : super(CompanyStatisticsInitial());

  Future<void> loadStatistics() async {
    try {
      emit(CompanyStatisticsLoading());
      final statistics = await repository.getStatistics();
      emit(CompanyStatisticsLoaded(statistics: statistics));
    } catch (e) {
      emit(CompanyStatisticsError(message: e.toString()));
    }
  }

  void refreshStatistics() {
    loadStatistics();
  }
}