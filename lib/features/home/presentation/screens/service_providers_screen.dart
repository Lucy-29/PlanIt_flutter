import 'package:ems_1/common/widgets/service_card.dart';
import 'package:ems_1/features/home/data/models/provider_offer_model.dart';
import 'package:ems_1/features/home/data/models/serviceprovider_model.dart';
import 'package:ems_1/features/home/presentation/screens/provider_details_screen.dart';
import 'package:flutter/material.dart';

class ServiceProvidersScreen extends StatelessWidget {
  // YOUR original dummy data. In a real app, this would come from a cubit.
  static final List<ServiceProviderModel> dummyServices = [
    ServiceProviderModel.withoffers(
      providerName: 'Salon Sarah',
      serviceName: 'Hair Styling & Beauty',
      location: 'Damascus',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl:
          "https://i.pinimg.com/736x/5c/2c/71/5c2c71a48d6d1a166c529c2c9d2c7348.jpg",
      description:
          'Expert beauty services from trained professionals in a relaxing environment.',
      email: "Sara_Salon12@gmail.com",
      facebookUrl: "https://www.facebook.com/share/15hYNXKTc1/",
      instagramUrl: "https://www.instagram.com/instagram?igsh=Ym1sdzZmcDRjYTll",
      gallery: [
        "https://i.pinimg.com/736x/99/b1/14/99b114c8aebba9eaf7dcf32b2e0838ba.jpg",
        "https://i.pinimg.com/736x/13/23/a2/1323a2495b5b513df7ef6adb92815169.jpg",
        "https://i.pinimg.com/736x/6c/56/e6/6c56e6a5df1874f01180be399cdce30c.jpg",
        "https://i.pinimg.com/736x/99/b1/14/99b114c8aebba9eaf7dcf32b2e0838ba.jpg",
      ],
      offers: [
        ProviderOfferModel(
            imageUrl:
                "https://i.pinimg.com/736x/9f/57/16/9f5716bf58c4fad05f6c93d7a3887459.jpg",
            price: "150.000 S.P",
            offerDiscription: "offerDiscription",
            offerName: ' offer name .... ....'),
        ProviderOfferModel(
            imageUrl:
                "https://i.pinimg.com/736x/d5/34/0a/d5340a131bdc9f3c051696ed9bc6cdea.jpg",
            price: "200.000 S.P",
            offerDiscription: "offerDiscription",
            offerName: ' offer name .... ....')
      ],
    ),
    ServiceProviderModel(
      providerName: 'FixIt Co.',
      serviceName: 'Home Repair Services',
      location: 'Homs',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl: 'assets/images/Pretty Simple Headshot.jpeg',
      description:
          'Reliable home maintenance and repair for appliances and furniture.',
      email: "",
      facebookUrl: "",
      instagramUrl: "",
    ),
    // ... more of your dummy data
  ];

  ServiceProvidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Services'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: dummyServices.length,
        itemBuilder: (context, index) {
          final provider = dummyServices[index];
          // Use YOUR ServiceCard and wire up its onTap callback.
          return ServiceCard(
            serviceProviderModel: provider,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProviderDetails(serviceCard1: provider),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
