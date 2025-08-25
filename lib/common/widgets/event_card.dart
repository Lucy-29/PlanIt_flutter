import 'dart:ui';
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:ems_1/features/home/presentation/screens/event_details_screen.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final EventCardModel eventCardModel;
  final Function(EventCardModel)? onFavoriteToggle;

  const EventCard({
    required this.eventCardModel,
    super.key,
    this.onFavoriteToggle,
  });

  Color _getColorForEventType(String type) {
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

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getColorForEventType(eventCardModel.eventType);

    return Container(
      margin: const EdgeInsets.all(5),
      width: 250,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          buildImage(context),
          const SizedBox(height: 5),
          buildInfo(),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EventDetailsScreen(eventCardModel: eventCardModel)),
                );
              },
              child: Image.network(
                eventCardModel.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 15,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  eventCardModel.date.substring(0, 2),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xff206173)),
                ),
                Text(
                  eventCardModel.date.substring(3),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xff206173)),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 15,
          right: 15,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Material(
                color: Colors.transparent, // مهم ليستقبل الضغط
                child: IconButton(
                  onPressed: () {
                    if (onFavoriteToggle != null) {
                      onFavoriteToggle!(eventCardModel);
                    }
                  },
                  icon: Icon(
                    eventCardModel.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: eventCardModel.isFavorite
                        ? Color(0xffD99A9A)
                        : const Color(0xffD99A9A),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eventCardModel.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              const Icon(Icons.event_available_outlined),
              const SizedBox(width: 4),
              Text(
                eventCardModel.eventType,
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  eventCardModel.location,
                  style: const TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              // onPressed: onEdit,
              onPressed: () {},

              icon: const Icon(Icons.edit, size: 16),
              label: const Text('Edit', style: TextStyle(fontSize: 12)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                foregroundColor: Colors.blue.shade700,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton.icon(
              // onPressed: onDelete,
              onPressed: () {},

              icon: const Icon(Icons.delete, size: 16),
              label: const Text('Delete', style: TextStyle(fontSize: 12)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red.shade700,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
