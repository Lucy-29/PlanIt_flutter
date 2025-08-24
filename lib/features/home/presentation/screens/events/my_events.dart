import 'package:ems_1/features/home/presentation/cubit/my_event/my_event_cubit.dart';
import 'package:ems_1/features/home/data/models/event_status_model.dart';
import 'package:ems_1/features/home/presentation/screens/events/my_event_status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyEvents extends StatefulWidget {
  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  void initState() {
    super.initState();
    // Load events when screen opens
    context.read<MyEventCubit>().loadMyEvents();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyEventCubit, MyEventState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<MyEventCubit>().loadMyEvents(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

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

        // List of events using MyEventStatusCard
        return RefreshIndicator(
          onRefresh: () => context.read<MyEventCubit>().refreshEvents(),
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.myEvents.length,
            itemBuilder: (context, i) {
              final event = state.myEvents[i];

              return MyEventStatusCard(
                event: event,
                onEdit: () {
                  // TODO: Navigate to edit screen
                  print('Edit event: ${event.title}');
                },
                onDelete: () => _showDeleteDialog(context, event),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(EventStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case EventStatus.approved:
        color = Colors.green;
        text = 'Approved';
        break;
      case EventStatus.rejected:
        color = Colors.red;
        text = 'Rejected';
        break;
      case EventStatus.pending:
      default:
        color = Colors.orange;
        text = 'Pending';
    }
    
    return Chip(
      label: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
      backgroundColor: color,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildOfferStatusChip(String status) {
    Color color;
    
    switch (status.toLowerCase()) {
      case 'approved':
        color = Colors.green;
        break;
      case 'rejected':
        color = Colors.red;
        break;
      case 'pending':
      default:
        color = Colors.orange;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, event) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Event'),
        content: Text('Are you sure you want to delete "${event.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<MyEventCubit>().deleteEvent(event);
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
