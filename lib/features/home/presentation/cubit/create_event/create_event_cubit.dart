import 'package:bloc/bloc.dart';
import 'package:ems_1/features/home/data/models/create_event_model.dart';
import 'package:ems_1/features/home/data/models/selected_provider_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit({CreateEventModel? initialEvent})
      : super(CreateEventState(
            eventModel: initialEvent ?? CreateEventModel.initial(),
            isFormValid: false)) {
    // Immediately validate the form if we are in edit mode
    if (initialEvent != null) {
      _validateForm();
    }
  }
  void eventNameChanged(String name) {
    emit(
        state.copyWith(eventModel: state.eventModel.copyWith(eventName: name)));
    _validateForm(); // Check validation after every change
  }

  void eventDateChanged(DateTime date) {
    emit(
        state.copyWith(eventModel: state.eventModel.copyWith(eventDate: date)));
    // Date changes don't affect form validity in this case, so no validation call.
  }

  void eventTimeChanged({required int hour, required int minute}) {
    final oldDate = state.eventModel.eventDate;
    final newDate =
        DateTime(oldDate.year, oldDate.month, oldDate.day, hour, minute);
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(eventDate: newDate)));
  }

  void eventPrivacyChanged(EventPrivacy privacy) {
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(privacy: privacy)));
  }

  // UPDATED: Logic to enforce selecting only ONE event type
  void eventTypeToggled(String type) {
    // If the currently selected type is the one the user just tapped...
    if (state.eventModel.eventType == type) {
      // ...deselect it by setting it to null.
      emit(state.copyWith(
          eventModel: state.eventModel.copyWith(eventType: null)));
    } else {
      // Otherwise, select the new type.
      emit(state.copyWith(
          eventModel: state.eventModel.copyWith(eventType: type)));
    }
    _validateForm();
  }

  void locationChanged(String location) {
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(location: location)));
    _validateForm(); // Check validation
  }

  void descriptionChanged(String description) {
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(description: description)));
    _validateForm(); // Check validation
  }

  void priceChanged(String priceString) {
    final price = double.tryParse(priceString) ?? 0.0;
    emit(state.copyWith(eventModel: state.eventModel.copyWith(price: price)));
    // Price doesn't affect form validity, so no validation call.
    _validateForm();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(state.copyWith(
            eventModel: state.eventModel.copyWith(imagePath: pickedFile.path)));
      }
    } catch (e) {
      // Handle potential errors, e.g., if user denies permissions
      print("Image picking error: $e");
    }
  }

  // --- Private Helper Method for Validation ---

  void _validateForm() {
    final event = state.eventModel;
    final bool isPriceValid = event.price > 0.0;

    // Check if all required text fields are not empty and an event type is selected.
    final bool isValid = event.eventName.trim().isNotEmpty &&
        event.location.trim().isNotEmpty &&
        event.description.trim().isNotEmpty &&
        event.eventType != null &&
        isPriceValid;

    // Emit a new state with the updated validation status.
    emit(state.copyWith(isFormValid: isValid));
  }

  void providersSelected(List<SelectedProviderModel> providers) {
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(selectedProviders: providers)));
  }

  // 👇 ADD THIS METHOD TO REMOVE A PROVIDER
  void providerRemoved(SelectedProviderModel providerToRemove) {
    final updatedList =
        List<SelectedProviderModel>.from(state.eventModel.selectedProviders)
          ..remove(providerToRemove);
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(selectedProviders: updatedList)));
  }

  // --- Final Action Method ---

  CreateEventModel createEvent() {
    // This method simply returns the final, valid state of the event model.
    // The UI is responsible for calling this and passing it to the next cubit.
    print("Event details compiled, returning model...");
    return state.eventModel;
  }
}
