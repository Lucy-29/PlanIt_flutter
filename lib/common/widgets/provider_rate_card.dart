import 'package:ems_1/features/home/data/models/provider_rate_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProviderRateCard extends StatelessWidget {
  final ProviderRateModel providerRateModel;
  const ProviderRateCard({super.key, required this.providerRateModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffF4F2EA),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              FontAwesomeIcons.solidCircleUser,
              color: Color(0xff206173),
              size: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBarIndicator(
                    rating: providerRateModel.numOfStars,
                    itemBuilder: (context, index) => const Icon(
                      FontAwesomeIcons.solidStar,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 18.0,
                    itemPadding: EdgeInsets.all(1.2),
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    providerRateModel.comment,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
