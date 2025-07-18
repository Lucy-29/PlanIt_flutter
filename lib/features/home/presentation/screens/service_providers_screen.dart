import 'package:ems_1/common/widgets/service_card.dart';
import 'package:ems_1/features/home/data/models/serviceprovider_model.dart';
import 'package:flutter/material.dart';

class ServiceProvidersScreen extends StatelessWidget {
  final List<ServiceProviderModel> dummyServices = [
    ServiceProviderModel(
      providerName: 'Salon Sarah',
      serviceName: 'Hair Styling & Beauty',
      location: 'Damascus',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      description:
          'Expert beauty services from trained professionals in a relaxing environment.',
      email: "Sara_Salon12@gmail.com",
      facebookUrl: "",
      instagramUrl: "",
    ),
    ServiceProviderModel(
      providerName: 'FixIt Co.',
      serviceName: 'Home Repair Services',
      location: 'Homs',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      description:
          'Reliable home maintenance and repair for appliances and furniture.',
      email: "",
      facebookUrl: "",
      instagramUrl: "",
    ),
    ServiceProviderModel(
      providerName: 'FixIt Co.',
      serviceName: 'Home Repair Services',
      location: 'Homs',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      description:
          'Reliable home maintenance and repair for appliances and furniture.',
      email: "",
      facebookUrl: "",
      instagramUrl: "",
    ),
    ServiceProviderModel(
      providerName: 'FixIt Co.',
      serviceName: 'Home Repair Services',
      location: 'Homs',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      description:
          'Reliable home maintenance and repair for appliances and furniture.',
      email: "",
      facebookUrl: "",
      instagramUrl: "",
    ),
  ];

  ServiceProvidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Services'),
      ),
      body: ListView.builder(
        itemCount: dummyServices.length,
        itemBuilder: (context, index) {
          return ServiceCard(serviceProviderModel: dummyServices[index]);
        },
      ),
    );
  }
}
