import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ems_1/features/home/data/models/serviceprovider_model.dart';
import 'package:ems_1/features/home/presentation/screens/favorite/Fav_provider.dart';
import 'package:ems_1/common/widgets/service_card.dart';

class Providers extends StatelessWidget {
  const Providers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favProvider, _) {
        final providersList = favProvider.favoriteProviders;

        if (providersList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/favorite.png",
                  height: 330,
                  width: 330,
                ),
                const Text("No liked providers!"),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: providersList.length,
          itemBuilder: (context, i) {
            final p = providersList[i];
            return ServiceCard(
              serviceProviderModel: p,
              onFavoriteToggle: () => favProvider.toggleProvider(p),
            );
          },
        );
      },
    );
  }
}
