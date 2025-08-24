import 'package:bloc/bloc.dart';
import 'package:ems_1/features/home/data/models/event_details_model.dart';
import 'package:ems_1/features/home/domain/repositories/event_repository.dart'; // Import the repository
import 'package:ems_1/features/home/data/models/selected_offer_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  // 1. ADD THE REPOSITORY DEPENDENCY
  final EventRepository _eventRepository;

  CreateEventCubit({
    required EventRepository eventRepository, // Inject it via the constructor
    EventDetailsModel? initialEvent,
  })  : _eventRepository = eventRepository, // Assign it to the private field
        super(CreateEventState(
            eventModel: initialEvent ?? EventDetailsModel.initial(),
            isFormValid: false)) {
    // This part from your old cubit is correct and remains.
    if (initialEvent != null) {
      _validateForm();
    }
  }

  // --- FORM FIELD UPDATE METHODS (FROM YOUR OLD CUBIT - NO CHANGES NEEDED) ---
  // All these methods are perfect. They manage the local form state.

  void eventNameChanged(String name) {
    emit(
        state.copyWith(eventModel: state.eventModel.copyWith(eventName: name)));
    _validateForm();
  }

  void eventDateChanged(DateTime date) {
    print("🔍 DEBUG - CreateEventCubit: eventDateChanged called with: $date");
    emit(
        state.copyWith(eventModel: state.eventModel.copyWith(eventDate: date)));
    print("🔍 DEBUG - CreateEventCubit: state updated, new eventDate: ${state.eventModel.eventDate}");
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

  void eventTypeToggled(String type) {
    if (state.eventModel.eventType == type) {
      emit(state.copyWith(
          eventModel: state.eventModel.copyWith(eventType: null)));
    } else {
      emit(state.copyWith(
          eventModel: state.eventModel.copyWith(eventType: type)));
    }
    _validateForm();
  }

  void locationChanged(String location) {
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(location: location)));
    _validateForm();
  }

  void descriptionChanged(String description) {
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(description: description)));
    _validateForm();
  }

  void priceChanged(String priceString) {
    final price = double.tryParse(priceString) ?? 0.0;
    emit(state.copyWith(eventModel: state.eventModel.copyWith(price: price)));
    _validateForm();
  }

  Future<void> pickImage() async {
    // Your pickImage method is perfect and remains.
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(state.copyWith(
            eventModel: state.eventModel.copyWith(imagePath: pickedFile.path)));
      }
    } catch (e) {
      print("Image picking error: $e");
    }
  }

  void offerSelected(SelectedOfferModel offer) {
    if (state.eventModel.selectedOffers.any((o) => o.offerId == offer.offerId))
      return;
    final updatedList =
        List<SelectedOfferModel>.from(state.eventModel.selectedOffers)
          ..add(offer);
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(selectedOffers: updatedList)));
  }

  void offerRemoved(SelectedOfferModel offerToRemove) {
    final updatedList =
        List<SelectedOfferModel>.from(state.eventModel.selectedOffers)
          ..remove(offerToRemove);
    emit(state.copyWith(
        eventModel: state.eventModel.copyWith(selectedOffers: updatedList)));
  }

  // --- VALIDATION (FROM YOUR OLD CUBIT - NO CHANGES NEEDED) ---
  void _validateForm() {
    // Your validation logic is correct and remains.
    final event = state.eventModel;
    final bool isPriceValid = (event.privacy == EventPrivacy.private) ||
        (event.privacy == EventPrivacy.public && event.price > 0.0);
    final bool isValid = event.eventName.trim().isNotEmpty &&
        event.location.trim().isNotEmpty &&
        event.description.trim().isNotEmpty &&
        event.eventType != null &&
        isPriceValid;
    emit(state.copyWith(isFormValid: isValid));
  }

  // --- API SUBMISSION (THE NEW METHOD) ---
  // This is the new logic that replaces your old `createEvent()` method.
  Future<void> submitEvent() async {
    _validateForm();
    if (!state.isFormValid) {
      print("Form is not valid. Submission aborted.");
      return;
    }

    emit(state.copyWith(submissionStatus: FormSubmissionStatus.submitting));

    try {
      final createdEvent = await _eventRepository.createEvent(state.eventModel);
      
      emit(state.copyWith(
        submissionStatus: FormSubmissionStatus.success,
        eventModel: createdEvent,
      ));
    } catch (e) {
      print("Error submitting event: $e");
      emit(state.copyWith(submissionStatus: FormSubmissionStatus.failure));
    }
  }
}
