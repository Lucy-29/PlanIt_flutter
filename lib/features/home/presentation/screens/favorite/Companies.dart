import 'package:ems_1/common/widgets/company_card.dart';
import 'package:ems_1/features/home/presentation/screens/favorite/Fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Companies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favProvider, _) {
        final companies = favProvider.favoriteCompanies; 

        if (companies.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/favorite.png",
                  height: 330,
                  width: 330,
                ),
                const Text("No liked companies!"),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: companies.length,
          itemBuilder: (context, i) {
            final c = companies[i];
            return CompanyCard(
              companyModel: c,
              onFavoriteToggle: () => favProvider.toggleCompany(c),
            );
          },
        );
      },
    );
  }
}
