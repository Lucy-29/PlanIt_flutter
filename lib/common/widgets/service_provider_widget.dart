// lib/common/widgets/popular_services_widget.dart

import 'package:ems_1/features/home/presentation/screens/service_providers_screen.dart';
import 'package:flutter/material.dart';
import 'package:ems_1/features/home/data/models/serviceprovider_model.dart';
import 'package:ems_1/common/widgets/service_card.dart';

class ServiceProviderWidget extends StatelessWidget {
  final List<ServiceProviderModel> serviceProviderModel;

  const ServiceProviderWidget({required this.serviceProviderModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Service Providers',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServiceProvidersScreen()));
                },
                child: const Text(
                  'view all→',
                  style: TextStyle(color: Color(0xFF50C878), fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return ServiceCard(serviceProviderModel: serviceProviderModel[index]);
            },
          ),
        ),
      ],
    );
  }
}
