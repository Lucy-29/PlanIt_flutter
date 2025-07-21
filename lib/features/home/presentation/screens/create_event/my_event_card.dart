// import 'package:ems_1/features/home/data/models/create_event_model.dart';
// import 'package:ems_1/features/home/presentation/screens/create_event/my_event_details_screen.dart';
// import 'package:flutter/material.dart';

// class MyEventCard extends StatelessWidget {
//   final CreateEventModel createEventModel;

//   const MyEventCard({
//     super.key,
//     required this.createEventModel,
//   });

//   Color _getColorForEventType(String type) {
//     switch (type) {
//       case 'Creative & Cultural 🎨':
//         return Colors.purple.shade100;
//       case 'Social Celebrations 🎉':
//         return Colors.orange.shade100;
//       case 'Music & Performance 🎵':
//         return Colors.blue.shade100;
//       case 'Wellness & Lifestyle 🧘':
//         return Colors.green.shade100;
//       case 'Entertainment & Fun 🎮':
//         return Colors.teal.shade100;
//       case 'Media & Content 📺':
//         return Colors.red.shade100;
//       case 'Educational & Academic 🎓':
//         return Colors.indigo.shade100;
//       case 'Training & Development 📚':
//         return Colors.brown.shade100;
//       default:
//         return const Color(0xFFbde0c4);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final backgroundColor = _getColorForEventType(createEventModel.eventType!);
//     final theme = Theme.of(context);

//     return Card(
//       color: backgroundColor,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       margin: const EdgeInsets.all(8),
//       child: InkWell(
//         onTap: () {
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (_) => MyEventDetailsScreen(event: createEventModel),
//           ));
//         },
//         borderRadius: BorderRadius.circular(16),
//         child: ListTile(
//           contentPadding: const EdgeInsets.all(10),
//           title: Text(
//             createEventModel.eventName,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 4),
//               Text('Location: ${createEventModel.location}'),
//               Text('Date: ${createEventModel.eventDate}'),
//               Text('Type: ${createEventModel.eventType}'),
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Chip(
//                   avatar: Icon(
//                     createEventModel.privacy == EventPrivacy.private
//                         ? Icons.lock_outline
//                         : Icons.public,
//                     size: 16,
//                     color: theme.primaryColor,
//                   ),
//                   label: Text(
//                     createEventModel.privacy == EventPrivacy.private
//                         ? 'Private'
//                         : 'Public',
//                   ),
//                   backgroundColor:
//                       createEventModel.privacy == EventPrivacy.private
//                           ? Colors.red[300]
//                           : Colors.green[300],
//                   side: BorderSide.none,
//                 ),
//               )
//             ],
//           ),
//           // trailing: Row(
//           //   mainAxisSize: MainAxisSize.min,
//           //   children: [
//           //     IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
//           //     IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
//           //   ],
//           // ),
//         ),
//       ),
//     );
//   }
// }
import 'package:ems_1/features/home/data/models/create_event_model.dart';
import 'package:ems_1/features/home/presentation/screens/create_event/my_event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyEventCard extends StatelessWidget {
  final CreateEventModel createEventModel;

  // These callbacks will be passed in from the list view where the card is used.
  // This decouples the card from the cubit.
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MyEventCard({
    super.key,
    required this.createEventModel,
    required this.onEdit,
    required this.onDelete,
  });

  // Your color helper function is perfect. No changes needed.
  Color _getColorForEventType(String? type) {
    // It's safer to accept a nullable String
    if (type == null)
      return const Color(0xFFbde0c4); // Default color if no type is set

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
  Widget build(BuildContext in_context) {
    // Using 'in_context' to avoid shadowing
    final backgroundColor = _getColorForEventType(createEventModel.eventType);
    final theme = Theme.of(in_context);
    final isPrivate = createEventModel.privacy == EventPrivacy.private;

    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          // The main tap action still navigates to the detailed view
          Navigator.of(in_context).push(MaterialPageRoute(
            builder: (_) => MyEventDetailsScreen(event: createEventModel),
          ));
        },
        borderRadius: BorderRadius.circular(
            15), // Match the Card's shape for a nice ripple effect
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Name
              Text(
                createEventModel.eventName,
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Location Info
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 16, color: theme.hintColor),
                  const SizedBox(width: 8),
                  Text('Location: ${createEventModel.location}',
                      style: theme.textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 4),

              // Date Info
              Row(
                children: [
                  Icon(Icons.calendar_today_outlined,
                      size: 16, color: theme.hintColor),
                  const SizedBox(width: 8),
                  Text(
                      'Date: ${DateFormat('E, MMM dd').format(createEventModel.eventDate)}',
                      style: theme.textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 12),

              // Bottom row with Privacy Chip and Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Privacy Chip
                  Chip(
                    avatar: Icon(
                      isPrivate ? Icons.lock_outline : Icons.public,
                      size: 16,
                      color: isPrivate ? Colors.white : Colors.black,
                    ),
                    label: Text(
                      isPrivate ? 'Private' : 'Public',
                    ),
                    labelStyle: TextStyle(
                        color: isPrivate ? Colors.white : Colors.black),
                    backgroundColor:
                        isPrivate ? Colors.red[300] : Colors.green[300],
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),

                  // Action Buttons (Edit & Delete)
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: onEdit,
                        tooltip: 'Edit Event',
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline,
                            color: Colors.red.shade700),
                        onPressed: onDelete,
                        tooltip: 'Delete Event',
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
