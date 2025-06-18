import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ems_1/features/auth/data/models/service_item_model.dart';

part 'service_selection_state.dart';

class ServiceSelectionCubit extends Cubit<ServiceSelectionState> {
  ServiceSelectionCubit(List<ServiceItemModel> allServices)
      : super(ServiceSelectionState(
          allServices: allServices,
          selectedServices: const [],
        ));

  void toggleServiceSelection(ServiceItemModel service) {
    final currentSelection =
        List<ServiceItemModel>.from(state.selectedServices);
    if (currentSelection.contains(service)) {
      currentSelection.remove(service);
    } else {
      currentSelection.add(service);
    }
    emit(state.serviceUpdate(selectedServices: currentSelection));
  }
}
