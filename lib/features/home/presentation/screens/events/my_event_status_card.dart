import 'dart:ui';
import 'package:ems_1/features/home/data/models/event_status_model.dart';
import 'package:ems_1/features/home/presentation/screens/events/event_status_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyEventStatusCard extends StatelessWidget {
  final EventStatusModel event;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MyEventStatusCard({
    super.key,
    required this.event,
    required this.onEdit,
    required this.onDelete,
  });

  Color _getColorForEventType(String? type) {
    if (type == null) return const Color(0xFFbde0c4);

    switch (type) {
      case 'Creative & Cultural 🎨':
        return Colors.purple.shade100;
      case 'Social Celebrations 🎉':
        return Colors.orange.shade100;
      case 'Music & Performance 🎵':
        return Colors.blue.shade100;
      case 'Wellness & Lifestyle 🧘':
        return Colors.green.shade100;
      case 'Entertainment & Fun 🎮':
        return Colors.teal.shade100;
      case 'Media & Content 📺':
        return Colors.red.shade100;
      case 'Educational & Academic 🎓':
        return Colors.indigo.shade100;
      case 'Training & Development 📚':
        return Colors.brown.shade100;
      default:
        return const Color(0xFFbde0c4);
    }
  }

  Color _getStatusColor(EventStatus status) {
    switch (status) {
      case EventStatus.approved:
        return Colors.green;
      case EventStatus.rejected:
        return Colors.red;
      case EventStatus.pending:
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildImage(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: buildInfo(),
                  ),
                  buildFavoriteIcon(),
                ],
              ),
              if (event.price != null) ...[
                const SizedBox(height: 12),
                buildReserveButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade400,
              Colors.blue.shade400,
              Colors.teal.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ),
            ),
            // Event icon
            Center(
              child: Icon(
                Icons.event,
                size: 35,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  EventStatus _getActualStatus() {
    // If event has offers/providers, use the actual status from backend
    if (event.offers.isNotEmpty) {
      return event.status;
    }

    // If no offers/providers, event is automatically approved
    return EventStatus.approved;
  }

  Widget buildInfo() {
    // Safe date formatting
    String formattedDate = _formatEventDate();
    final actualStatus = _getActualStatus();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formattedDate,
          style: TextStyle(
            color: Colors.blue.shade600,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          event.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: 16,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                event.location ?? 'No location',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(actualStatus),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                actualStatus.name.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color:
                    event.privacy == 'private' ? Colors.orange : Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    event.privacy == 'private' ? Icons.lock : Icons.public,
                    size: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    (event.privacy ?? 'public').toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Event Description
        if (event.description.isNotEmpty)
          Text(
            event.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
            // maxLines: 3,
            // overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  String _formatEventDate() {
    try {
      // Handle backend time format (HH:mm:ss)
      String timeStr = event.time;
      if (timeStr.length > 5) {
        timeStr = timeStr.substring(0, 5);
      }

      DateTime dateTime = DateTime.parse('${event.date} $timeStr');
      return DateFormat('EEE, MMM d • h:mm a').format(dateTime);
    } catch (e) {
      return '${event.date} • ${event.time}';
    }
  }

  Widget buildFavoriteIcon() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          // Toggle favorite functionality
        },
        icon: Icon(
          Icons.favorite_border,
          size: 18,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget buildReserveButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Reserve ticket functionality
          print("Reserve ticket for event: ${event.title}");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Reserve Ticket - \$${event.price!.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
