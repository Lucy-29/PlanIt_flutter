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
    final eventDate = DateFormat('EEE, MMM d • h:mm a').format(DateTime.parse('${event.date} ${event.time}'));
    final backgroundColor = _getColorForEventType(event.eventType);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EventStatusDetailsScreen(event: event),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImage(),
              const SizedBox(width: 12),
              Expanded(
                child: buildInfo(eventDate),
              ),
              buildFavoriteIcon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.event,
          size: 30,
          color: Colors.grey.shade500,
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

  Widget buildInfo(String eventDate) {
    final actualStatus = _getActualStatus();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eventDate,
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
              Icons.event_available_outlined,
              size: 16,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                event.eventType ?? 'No Type',
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
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _getStatusColor(actualStatus),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                actualStatus.name.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: event.privacy == 'private' ? Colors.orange : Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    event.privacy == 'private' ? Icons.lock : Icons.public,
                    size: 10,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    (event.privacy ?? 'public').toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (event.price != null) ...[
          const SizedBox(height: 4),
          Text(
            '\$ ${event.price!.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
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
}