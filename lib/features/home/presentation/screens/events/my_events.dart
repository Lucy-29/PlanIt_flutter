import 'package:ems_1/common/widgets/event_card.dart';
import 'package:ems_1/features/home/data/models/create_event_model.dart';
import 'package:ems_1/features/home/presentation/cubit/my_event/my_event_cubit.dart';
import 'package:ems_1/features/home/presentation/screens/create_event/create_event_screen.dart';
import 'package:ems_1/features/home/presentation/screens/create_event/my_event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart'; // Your UI Card Model

class MyEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listen to the MyEventsCubit for changes
    return BlocBuilder<MyEventCubit, MyEventState>(
      builder: (context, state) {
        if (state.myEvents.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(children: [
              Image.asset(
                "assets/images/upComingEvents.png",
                height: 350,
                width: 350,
              ),
              const SizedBox(height: 16),
              const Text("You haven't created any events yet.",
                  style: TextStyle(fontSize: 18)),
            ]),
          );
        }

        // List of created events
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: state.myEvents.length,
          itemBuilder: (context, i) {
            final event = state.myEvents[i];

            return MyEventCard(
              createEventModel: event,
              onEdit: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CreateEventScreen(eventToEdit: event)));
              },
              onDelete: () {
                showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(actions: [
                          TextButton(
                              onPressed: () {
                                context.read<MyEventCubit>().deleteEvent(event);
                                Navigator.of(dialogContext).pop();
                              },
                              child: Text("Delete"))
                        ]));
              },
            );
          },
        );
      },
    );
  }
}
