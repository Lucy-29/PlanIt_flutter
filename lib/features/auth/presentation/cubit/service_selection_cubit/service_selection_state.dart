part of 'service_selection_cubit.dart';

class ServiceSelectionState extends Equatable {
  final List<ServiceItemModel> allServices;
  final List<ServiceItemModel> selectedServices;

  const ServiceSelectionState({
    required this.allServices,
    required this.selectedServices,
  });

  ServiceSelectionState serviceUpdate({
    List<ServiceItemModel>? selectedServices,
  }) {
    return ServiceSelectionState(
      allServices: allServices,
      selectedServices: selectedServices ?? this.selectedServices,
    );
  }

  @override
  List<Object> get props => [allServices, selectedServices];
}
