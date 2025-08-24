import 'dart:io';

import 'package:ems_1/core/service_locator/service_locator.dart';
import 'package:ems_1/features/home/data/models/selected_offer_model.dart';
import 'package:ems_1/features/home/presentation/screens/create_event/selected_offer_card.dart';
import 'package:ems_1/features/home/presentation/screens/service_providers_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:ems_1/features/home/data/models/event_details_model.dart';
import 'package:ems_1/features/home/domain/repositories/event_repository.dart';
import 'package:ems_1/features/home/presentation/cubit/create_event/create_event_cubit.dart';
import 'package:ems_1/features/home/presentation/cubit/my_event/my_event_cubit.dart';

class CreateEventScreen extends StatelessWidget {
  final EventDetailsModel? eventToEdit;

  const CreateEventScreen({super.key, this.eventToEdit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateEventCubit(
        eventRepository: sl<EventRepository>(), // Inject the repository
        initialEvent: eventToEdit,
      ),
      child: CreateEventView(isEditing: eventToEdit != null),
    );
  }
}

class CreateEventView extends StatefulWidget {
  final bool isEditing;
  const CreateEventView({super.key, required this.isEditing});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  // --- Controllers ---
  final _eventNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  // --- Static Data ---
  final List<String> eventTypes = [
    'Creative & Cultural 🎨',
    'Social Celebrations 🎉',
    'Music & Performance 🎵',
    'Wellness & Lifestyle 🧘',
    'Entertainment & Fun 🎮',
    'Media & Content 📺',
    'Educational & Academic 🎓',
    'Training & Development 📚',
  ];

  @override
  void initState() {
    super.initState();
    // Pre-fill form fields if we are in "Edit" mode
    if (widget.isEditing) {
      final initialEvent = context.read<CreateEventCubit>().state.eventModel;
      _eventNameController.text = initialEvent.eventName;
      _locationController.text = initialEvent.location;
      _descriptionController.text = initialEvent.description;
      _priceController.text = initialEvent.price.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _showDatePicker(BuildContext context, DateTime currentDate) {
    print("🔍 DEBUG - Opening date picker with currentDate: $currentDate");
    
    final now = DateTime.now();
    final minimumDate = DateTime(now.year, now.month, now.day); // Today at midnight
    final maximumDate = DateTime(now.year + 1, now.month, now.day); // 1 year from now
    
    // Ensure initialDateTime is not before minimumDate
    final initialDateTime = currentDate.isBefore(minimumDate) ? minimumDate : currentDate;
    
    print("🔍 DEBUG - minimumDate: $minimumDate");
    print("🔍 DEBUG - initialDateTime: $initialDateTime");
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: CupertinoDatePicker(
            initialDateTime: initialDateTime,
            mode: CupertinoDatePickerMode.date,
            minimumDate: minimumDate,
            maximumDate: maximumDate,
            onDateTimeChanged: (newDate) {
              print("🔍 DEBUG - Date picker changed to: $newDate");
              context.read<CreateEventCubit>().eventDateChanged(newDate);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fieldFillColor = theme.brightness == Brightness.light
        ? Colors.grey.shade300
        : Colors.grey.shade600;
    final fieldDecoration = InputDecoration(
      fillColor: fieldFillColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(widget.isEditing ? 'Edit Your Event' : 'Create Your Event'),
      ),
      // BlocListener handles "side effects" like showing snackbars and navigating
      body: BlocListener<CreateEventCubit, CreateEventState>(
        listener: (context, state) {
          if (state.submissionStatus == FormSubmissionStatus.success) {
            // Get the final event data from the state
            final finalEvent = state.eventModel;

            if (widget.isEditing) {
              context.read<MyEventCubit>().editEvent(finalEvent);
            } else {
              context.read<MyEventCubit>().addEvent(finalEvent);
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(widget.isEditing
                      ? 'Event Updated Successfully!'
                      : finalEvent.selectedOffers.isNotEmpty
                          ? 'Event Created! Waiting for provider approval...'
                          : 'Event Created Successfully!')),
            );
            Navigator.of(context).pop(); // Go back after success
          }
          if (state.submissionStatus == FormSubmissionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Submission Failed. Please try again.'),
                  backgroundColor: Colors.red),
            );
          }
        },
        // BlocBuilder rebuilds the UI based on state changes (e.g., button state, image preview)
        child: BlocBuilder<CreateEventCubit, CreateEventState>(
          builder: (context, state) {
            final event = state.eventModel;

            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                // All form field widgets
                _buildSectionTitle('EVENT PICTURE (OPTIONAL)', theme),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => context.read<CreateEventCubit>().pickImage(),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: fieldFillColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: event.imagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(File(event.imagePath!),
                                fit: BoxFit.cover))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(Icons.add_a_photo_outlined,
                                    size: 40, color: theme.hintColor),
                                const SizedBox(height: 8),
                                Text("Add a cover picture",
                                    style: TextStyle(color: theme.hintColor)),
                              ]),
                  ),
                ),

                const SizedBox(height: 24),
                _buildSectionTitle('EVENT NAME', theme),
                const SizedBox(height: 8),
                TextField(
                    controller: _eventNameController,
                    decoration: fieldDecoration.copyWith(
                        hintText: 'choose event name...'),
                    onChanged: (value) => context
                        .read<CreateEventCubit>()
                        .eventNameChanged(value)),

                const SizedBox(height: 24),
                _buildSectionTitle('EVENT DATE', theme),
                const SizedBox(height: 8),
                GestureDetector(
                    onTap: () => _showDatePicker(context, event.eventDate),
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                            color: fieldFillColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Text(
                                DateFormat('MMMM dd, yyyy')
                                    .format(event.eventDate),
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(fontSize: 16))))),

                const SizedBox(height: 24),
                _buildSectionTitle('EVENT TIME', theme),
                const SizedBox(height: 8),
                _buildTimePicker(
                    context, event.eventDate, theme, fieldFillColor),

                const SizedBox(height: 24),
                _buildSectionTitle('EVENT PRIVACY', theme),
                const SizedBox(height: 8),
                _buildPrivacyToggle(
                    context, event.privacy, theme, fieldFillColor),

                const SizedBox(height: 24),
                _buildSectionTitle('EVENT TYPE', theme),
                const SizedBox(height: 8),
                Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: eventTypes.map((type) {
                      final isSelected = event.eventType == type;
                      return ChoiceChip(
                          label: Text(type),
                          selected: isSelected,
                          onSelected: (_) => context
                              .read<CreateEventCubit>()
                              .eventTypeToggled(type),
                          selectedColor: theme.primaryColor.withOpacity(0.3),
                          backgroundColor: fieldFillColor,
                          pressElevation: 0,
                          labelStyle: theme.textTheme.bodyMedium,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: isSelected
                                      ? theme.primaryColor
                                      : Colors.transparent,
                                  width: 1.5)));
                    }).toList()),

                const SizedBox(height: 24),
                _buildSectionTitle('EVENT LOCATION', theme),
                const SizedBox(height: 8),
                TextField(
                    controller: _locationController,
                    decoration: fieldDecoration.copyWith(
                        hintText: 'place name',
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                                'assets/images/eventlocation.png',
                                width: 24,
                                height: 24))),
                    onChanged: (value) => context
                        .read<CreateEventCubit>()
                        .locationChanged(value)),

                const SizedBox(height: 24),
                _buildSectionTitle('DESCRIPTION', theme),
                const SizedBox(height: 8),
                TextField(
                    controller: _descriptionController,
                    decoration: fieldDecoration.copyWith(
                        hintText: 'Enter event description...'),
                    onChanged: (value) => context
                        .read<CreateEventCubit>()
                        .descriptionChanged(value),
                    maxLines: 4),

                const SizedBox(height: 24),
                _buildSectionTitle('TICKET PRICE (\$)', theme),
                const SizedBox(height: 8),
                TextField(
                    controller: _priceController,
                    decoration:
                        fieldDecoration.copyWith(hintText: 'Enter Price'),
                    onChanged: (value) =>
                        context.read<CreateEventCubit>().priceChanged(value),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true)),

                const SizedBox(height: 24),
                _buildSectionTitle(
                    'SELECTED OFFERS', theme), // Renamed for clarity
                const SizedBox(height: 8),

                // This button still launches the provider list
                GestureDetector(
                  onTap: () async {
                    // Navigate and wait for a single SelectedOfferModel
                    final selectedOffer =
                        await Navigator.of(context).push<SelectedOfferModel>(
                      MaterialPageRoute(
                        builder: (_) => ServiceProvidersScreen(),
                      ),
                    );

                    // If the user came back with an offer...
                    if (selectedOffer != null) {
                      // ...tell the cubit to ADD it to the list.
                      context
                          .read<CreateEventCubit>()
                          .offerSelected(selectedOffer);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    // Use the same consistent fieldFillColor for the background
                    decoration: BoxDecoration(
                      color: fieldFillColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Offers from Popular Services',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            // Use a color that stands out slightly but is still subtle
                            color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.8),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: theme.hintColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                ListView.separated(
                  itemCount: event.selectedOffers.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final offer = event.selectedOffers[index];
                    // Create a dedicated widget for displaying selected offers
                    return SelectedOfferCard(
                      offer: offer,
                      onRemove: () {
                        context.read<CreateEventCubit>().offerRemoved(offer);
                      },
                    );
                  },
                ),

                const SizedBox(height: 40),

                // Main Action Button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: theme.colorScheme.onPrimary,
                        textStyle: theme.textTheme.labelLarge,
                        disabledBackgroundColor: Colors.grey.shade400),
                    onPressed: state.isFormValid &&
                            state.submissionStatus !=
                                FormSubmissionStatus.submitting
                        ? () => context.read<CreateEventCubit>().submitEvent()
                        : null,
                    child: state.submissionStatus ==
                            FormSubmissionStatus.submitting
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 3))
                        : Text(
                            widget.isEditing ? 'UPDATE EVENT' : 'CREATE EVENT'),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(title,
        style: theme.textTheme.bodySmall?.copyWith(
            color: theme.hintColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8));
  }

  Widget _buildTimePicker(BuildContext context, DateTime currentDate,
      ThemeData theme, Color fieldFillColor) {
    int currentHour24 = currentDate.hour;
    bool isAm = currentHour24 < 12;
    int currentHour12 =
        (currentHour24 == 0 || currentHour24 == 12) ? 12 : currentHour24 % 12;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          color: fieldFillColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          NumberPicker(
              value: currentHour12,
              minValue: 1,
              maxValue: 12,
              itemHeight: 40,
              itemWidth: 50,
              step: 1,
              onChanged: (newHour12) {
                int newHour24;
                if (isAm) {
                  newHour24 = (newHour12 == 12) ? 0 : newHour12;
                } else {
                  newHour24 = (newHour12 == 12) ? 12 : newHour12 + 12;
                }
                context.read<CreateEventCubit>().eventTimeChanged(
                    hour: newHour24, minute: currentDate.minute);
              },
              selectedTextStyle:
                  TextStyle(color: theme.primaryColor, fontSize: 24),
              textStyle: TextStyle(color: theme.hintColor, fontSize: 16)),
          Text(':',
              style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.primaryColor, fontWeight: FontWeight.bold)),
          NumberPicker(
              value: currentDate.minute,
              minValue: 0,
              maxValue: 59,
              step: 1,
              itemHeight: 40,
              itemWidth: 50,
              onChanged: (newMinute) {
                context
                    .read<CreateEventCubit>()
                    .eventTimeChanged(hour: currentHour24, minute: newMinute);
              },
              textMapper: (val) => val.padLeft(2, '0'),
              selectedTextStyle:
                  TextStyle(color: theme.primaryColor, fontSize: 24),
              textStyle: TextStyle(color: theme.hintColor, fontSize: 16)),
          const Spacer(),
          ToggleButtons(
              isSelected: [isAm, !isAm],
              onPressed: (index) {
                final newIsAm = index == 0;
                int newHour24 = currentHour24;
                if (newIsAm && currentHour24 >= 12) {
                  newHour24 -= 12;
                } else if (!newIsAm && currentHour24 < 12) {
                  newHour24 += 12;
                }
                context.read<CreateEventCubit>().eventTimeChanged(
                    hour: newHour24, minute: currentDate.minute);
              },
              children: const [Text('AM'), Text('PM')]),
        ],
      ),
    );
  }

  Widget _buildPrivacyToggle(BuildContext context, EventPrivacy currentPrivacy,
      ThemeData theme, Color fieldFillColor) {
    bool isPrivate = currentPrivacy == EventPrivacy.private;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          color: fieldFillColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(isPrivate ? 'Private Event' : 'Public Event',
              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16)),
          Switch.adaptive(
              value: isPrivate,
              activeColor: theme.primaryColor,
              onChanged: (newValue) {
                final newPrivacy =
                    newValue ? EventPrivacy.private : EventPrivacy.public;
                context
                    .read<CreateEventCubit>()
                    .eventPrivacyChanged(newPrivacy);
              }),
        ],
      ),
    );
  }
}
