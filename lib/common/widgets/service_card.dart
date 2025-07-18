import 'dart:ui';

import 'package:ems_1/features/home/data/models/serviceprovider_model.dart';
import 'package:ems_1/features/home/presentation/screens/provider_details_screen.dart';
import 'package:ems_1/features/home/presentation/screens/service_details_screen.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final ServiceProviderModel serviceProviderModel;

  const ServiceCard({required this.serviceProviderModel, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
       onTap: () {
         Navigator.push(
           context,
           MaterialPageRoute(
             builder: (context) => ProviderDetails(serviceCard1: serviceProviderModel)

           ),
         );
       },
      child: Container(
        margin: EdgeInsets.all(5),
        width: 250,
        decoration: BoxDecoration(
          color: const Color(0xFFbde0c4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            buildImage(),
            const SizedBox(height: 5),
            buildInfo(),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              serviceProviderModel.placeImageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
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
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: Color(0xffD99A9A),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildInfo() {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            serviceProviderModel.serviceName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            serviceProviderModel.providerName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
              ),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  serviceProviderModel.location,
                  style: TextStyle(
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
    );
  }
}
