import 'package:ems_1/common/widgets/event_card.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:ems_1/features/home/presentation/screens/favorite/Fav_provider.dart';
import 'package:ems_1/features/home/presentation/screens/popular_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularEventsWidget extends StatelessWidget {
  final List<EventCardModel> event;
  final Function(EventCardModel)? onFavoriteToggle;

  const PopularEventsWidget({
    required this.event,
    super.key,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favProvider, child) {
        final events = favProvider.allEvents; 

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'popular events',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PopularEventsScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'view all→',
                      style: TextStyle(color: Color(0xFF50C878), fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 270,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final e = events[index];
                  return EventCard(
                    eventCardModel: e,
                    onFavoriteToggle: (_) {
                      favProvider.toggleEvent(e);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
