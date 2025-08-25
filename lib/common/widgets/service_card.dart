import 'dart:ui';
import 'package:ems_1/features/home/presentation/screens/favorite/Fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:ems_1/features/home/data/models/serviceprovider_model.dart';
import 'package:ems_1/features/home/presentation/screens/provider_details_screen.dart';
import 'package:provider/provider.dart';

class ServiceCard extends StatelessWidget {
  final ServiceProviderModel serviceProviderModel;
  final VoidCallback? onFavoriteToggle;
  final onTap;

  const ServiceCard({
    super.key,
    required this.serviceProviderModel,
    this.onFavoriteToggle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 250,
      decoration: BoxDecoration(
        color: const Color(0xFFbde0c4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              // الصورة
              Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProviderDetails(
                              serviceCard1: serviceProviderModel),
                        ),
                      );
                    },
                    child: Image.network(
                      serviceProviderModel.placeImageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // زر الفافوريت فوق الصورة
              Positioned(
                top: 15,
                right: 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Material(
                      color: Colors.transparent,
                      child: Consumer<FavoritesProvider>(
                        builder: (context, favProvider, _) {
                          final isFav = favProvider.favoriteProviders
                              .contains(serviceProviderModel);

                          return IconButton(
                            onPressed: () {
                              favProvider.toggleProvider(serviceProviderModel);
                            },
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: const Color(0xffD99A9A),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // معلومات الخدمة
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceProviderModel.serviceName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  serviceProviderModel.providerName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        serviceProviderModel.location,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
