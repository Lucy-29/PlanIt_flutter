import 'dart:io';

import 'package:ems_1/features/home/data/models/create_event_model.dart';
import 'package:ems_1/features/home/data/models/selected_provider_model.dart';
import 'package:ems_1/features/home/presentation/cubit/create_event/create_event_cubit.dart';
import 'package:ems_1/features/home/presentation/cubit/my_event/my_event_cubit.dart';
import 'package:ems_1/features/home/presentation/screens/create_event/selected_provider_card.dart';
import 'package:ems_1/features/home/presentation/screens/service_providers_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateEventScreen extends StatelessWidget {
  final CreateEventModel? eventToEdit;

  const CreateEventScreen({super.key, this.eventToEdit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateEventCubit(initialEvent: eventToEdit),
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
  final _eventNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

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
    showModalBottomSheet(
      context: context,
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
            initialDateTime: currentDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (newDate) {
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

    // Define a single, reusable fill color for all input fields
    final fieldFillColor = theme.brightness == Brightness.light
        ? Colors.grey.shade300
        : Colors.grey.shade600;

    // Define a single, reusable decoration for text fields
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
        title: const Text('Create your event'),
      ),
      body: BlocBuilder<CreateEventCubit, CreateEventState>(
        builder: (context, state) {
          final event = state.eventModel;

          // Sync text controllers with the state to handle external updates
          if (_eventNameController.text != event.eventName) {
            _eventNameController.text = event.eventName;
          }
          if (_locationController.text != event.location) {
            _locationController.text = event.location;
          }

          return ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              _buildSectionTitle('EVENT PICTURE (OPTIONAL)', theme),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // This calls the method we already added to the cubit
                  context.read<CreateEventCubit>().pickImage();
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: fieldFillColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: event.imagePath != null
                      // If an image is selected, display it
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(event
                                .imagePath!), // Create a File object from the path
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Text("Could not load image"));
                            },
                          ),
                        )
                      // Otherwise, show the placeholder
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo_outlined,
                                size: 40, color: theme.hintColor),
                            const SizedBox(height: 8),
                            Text("Add a cover picture",
                                style: TextStyle(color: theme.hintColor)),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('EVENT NAME', theme),
              const SizedBox(height: 8),
              TextField(
                controller: _eventNameController,
                decoration: fieldDecoration.copyWith(
                  hintText: 'choose event name...',
                ),
                onChanged: (value) =>
                    context.read<CreateEventCubit>().eventNameChanged(value),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('EVENT DATE', theme),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _showDatePicker(context, event.eventDate),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: fieldFillColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      DateFormat('MMMM dd, yyyy').format(event.eventDate),
                      style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('EVENT TIME', theme),
              const SizedBox(height: 8),
              _buildTimePicker(context, event.eventDate, theme, fieldFillColor),
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
                    onSelected: (_) =>
                        context.read<CreateEventCubit>().eventTypeToggled(type),
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
                          width: 1.5,
                        )),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('EVENT LOCATION', theme),
              const SizedBox(height: 8),
              TextField(
                controller: _locationController,
                decoration: fieldDecoration.copyWith(
                  hintText: 'place name',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/images/eventlocation.png',
                        width: 24, height: 24),
                  ),
                ),
                onChanged: (value) =>
                    context.read<CreateEventCubit>().locationChanged(value),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('DESCRIPTION', theme),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                decoration: fieldDecoration.copyWith(
                    hintText: 'Enter event description...'),
                onChanged: (value) =>
                    context.read<CreateEventCubit>().descriptionChanged(value),
                maxLines: 4, // Make it a larger text box
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('TICKET PRICE (\$)', theme),
              const SizedBox(height: 8),
              TextField(
                controller: _priceController,
                decoration: fieldDecoration.copyWith(hintText: '\$'),
                onChanged: (value) =>
                    context.read<CreateEventCubit>().priceChanged(value),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              TextButton.icon(
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Select Providers'),
                style: TextButton.styleFrom(
                  foregroundColor: theme.primaryColor,
                  textStyle: theme.textTheme.labelLarge,
                ),
                onPressed: () async {
                  // Navigate to the selection screen and WAIT for a result
                  final List<SelectedProviderModel>? selectedProviders =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      // We will update ServiceProvidersScreen next
                      builder: (_) => ServiceProvidersScreen(),
                    ),
                  );

                  // If the user made a selection and came back...
                  if (selectedProviders != null &&
                      selectedProviders.isNotEmpty) {
                    // ...update the cubit's state with the new list
                    context
                        .read<CreateEventCubit>()
                        .providersSelected(selectedProviders);
                  }
                },
              ),
              const SizedBox(height: 8),

              // DISPLAY THE LIST OF SELECTED PROVIDERS
              // This part will only be visible if providers have been selected.
              if (event.selectedProviders.isNotEmpty)
                _buildSectionTitle('SELECTED PROVIDERS', theme),
              const SizedBox(height: 8),

              ListView.separated(
                itemCount: event.selectedProviders.length,
                shrinkWrap: true, // Important for nested lists
                physics:
                    const NeverScrollableScrollPhysics(), // Disables inner scrolling
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final provider = event.selectedProviders[index];
                  // Use a dedicated widget to display the selected provider
                  return SelectedProviderCard(
                    provider: provider,
                    onRemove: () {
                      context
                          .read<CreateEventCubit>()
                          .providerRemoved(provider);
                    },
                  );
                },
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Expanded(
                  //   child: OutlinedButton(
                  //     style: OutlinedButton.styleFrom(
                  //       side: BorderSide(color: theme.primaryColor),
                  //       textStyle: theme.textTheme.labelLarge,
                  //       padding: const EdgeInsets.symmetric(vertical: 14),
                  //     ),
                  //     onPressed: () {},
                  //     child: const Text('SCHEDULE EVENT'),
                  //   ),
                  // ),
                  // const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: theme.colorScheme.onPrimary,
                        textStyle: theme.textTheme.labelLarge,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        disabledBackgroundColor: Colors.grey.shade400,
                      ),
                      onPressed: state.isFormValid
                          ? () {
                              final finalEventDetails = context
                                  .read<CreateEventCubit>()
                                  .createEvent();

                              if (widget.isEditing) {
                                // In EDIT mode, we call editEvent
                                context
                                    .read<MyEventCubit>()
                                    .editEvent(finalEventDetails);
                              } else {
                                // In CREATE mode, we call addEvent
                                context
                                    .read<MyEventCubit>()
                                    .addEvent(finalEventDetails);
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(widget.isEditing
                                        ? 'Event Updated!'
                                        : 'Event Created!')),
                              );
                              Navigator.of(context)
                                  .pop(); // Go back to the previous screen
                            }
                          : null,
                      // The button text changes based on the mode
                      child: Text(
                          widget.isEditing ? 'UPDATE EVENT' : 'CREATE EVENT'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.bodySmall?.copyWith(
          color: theme.hintColor,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8),
    );
  }

  Widget _buildTimePicker(BuildContext context, DateTime currentDate,
      ThemeData theme, Color fieldFillColor) {
    int currentHour24 = currentDate.hour;
    bool isAm = currentHour24 < 12;

    int currentHour12;
    if (currentHour24 == 0) {
      currentHour12 = 12; // Midnight is 12 AM
    } else if (currentHour24 > 12) {
      currentHour12 = currentHour24 - 12; // PM hours
    } else {
      currentHour12 = currentHour24; // AM hours
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: fieldFillColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // --- HOUR PICKER ---
          Row(
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
                textStyle: TextStyle(color: theme.hintColor, fontSize: 16),
              ),

              Text(':',
                  style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.primaryColor, fontWeight: FontWeight.bold)),

              // --- MINUTE PICKER ---
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
                textStyle: TextStyle(color: theme.hintColor, fontSize: 16),
              ),
            ],
          ),

          // SizedBox(width: 50),
          // --- AM/PM TOGGLE ---
          // This widget now gets its styling directly from the AppThemes file
          ToggleButtons(
            isSelected: [isAm, !isAm],
            onPressed: (index) {
              final newIsAm = index == 0;
              int newHour24 = currentHour24;

              // Logic to toggle between AM and PM hours
              if (newIsAm && currentHour24 >= 12) {
                newHour24 -= 12;
              } else if (!newIsAm && currentHour24 < 12) {
                newHour24 += 12;
              }
              context.read<CreateEventCubit>().eventTimeChanged(
                  hour: newHour24, minute: currentDate.minute);
            },
            // All styling (borderRadius, colors, constraints) is now handled by the theme,
            // so we don't need to specify it here.
            children: const [Text('AM'), Text('PM')],
          )
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
        color: fieldFillColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(isPrivate ? 'Private Event' : 'Public Event',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          // Use the adaptive switch for a native look on iOS/Android
          Switch.adaptive(
            value: isPrivate,
            // activeColor: theme.primaryColor,
            activeColor: Theme.of(context).primaryColor,
            activeTrackColor: Colors.grey,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor:
                Colors.grey.shade700, // Use a consistent active color
            onChanged: (newValue) {
              // The new value from the switch directly determines the state
              // newValue == true means the switch is "on", which we map to 'private'
              final newPrivacy =
                  newValue ? EventPrivacy.private : EventPrivacy.public;
              context.read<CreateEventCubit>().eventPrivacyChanged(newPrivacy);
            },
          )
        ],
      ),
    );
  }
}
