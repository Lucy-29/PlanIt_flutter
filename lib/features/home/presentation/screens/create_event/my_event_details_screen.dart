import 'package:ems_1/features/home/data/models/create_event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyEventDetailsScreen extends StatelessWidget {
  final CreateEventModel event;

  const MyEventDetailsScreen({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(event.eventName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // // Example Banner Image
            // Container(
            //   height: 200,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade300,
            //     borderRadius: BorderRadius.circular(16),
            //     image: const DecorationImage(
            //       image: NetworkImage(
            //           'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1200'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 24),

            // --- Event Info Section ---
            Text(event.eventName,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Chip(
              // Display the privacy status clearly
              label: Text(event.privacy == EventPrivacy.private
                  ? 'This is a private event'
                  : 'This is a public event'),
              backgroundColor: theme.primaryColor.withOpacity(0.1),
              side: BorderSide.none,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.calendar_today,
                DateFormat('E, MMMM dd, yyyy').format(event.eventDate)),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.access_time,
                DateFormat('hh:mm a').format(event.eventDate)),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.location_on_outlined, event.location),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.price_check_outlined,
                'Ticket Price: \$${event.price.toStringAsFixed(2)}'),

            const Divider(height: 48),

            // --- Description Section ---
            Text("About this event",
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(
              event.description.isEmpty
                  ? "No description provided."
                  : event.description,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade700),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
