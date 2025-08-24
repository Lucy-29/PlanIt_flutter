import 'package:ems_1/common/widgets/event_card.dart';

import 'package:ems_1/features/home/presentation/screens/favorite/Fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final favoriteEvents = favoritesProvider.favoriteEvents;

        if (favoriteEvents.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/favorite.png",
                  height: 330,
                  width: 330,
                ),
                const Text("No liked events!"),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: favoriteEvents.length,
            itemBuilder: (context, i) {
              return EventCard(
                eventCardModel: favoriteEvents[i],
                onFavoriteToggle: (e) {
                  favoritesProvider.toggleEvent(favoriteEvents[i]);
                },
              );
            },
          );
        }
      },
    );
  }
}
