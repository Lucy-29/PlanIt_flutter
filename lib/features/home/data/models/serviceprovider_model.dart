import 'dart:ffi';
import 'dart:ui';

import 'package:ems_1/common/widgets/provider_offer_card.dart';
import 'package:ems_1/features/home/data/models/provider_offer_model.dart';

class ServiceProviderModel {
  final String providerName;
  final String serviceName;
  final String location;
  final String placeImageUrl;
  final String providerImageUrl;
  final String description;
  final String email;
  final String facebookUrl;
  final String instagramUrl;
  List<String> gallery = [];
  List<ProviderOfferModel> offers = [];
  double rate = 0.0;

  ServiceProviderModel({
    required this.providerName,
    required this.serviceName,
    required this.location,
    required this.placeImageUrl,
    required this.providerImageUrl,
    required this.description,
    required this.email,
    required this.facebookUrl,
    required this.instagramUrl,
  });
  ServiceProviderModel.withgallery({
    required this.providerName,
    required this.serviceName,
    required this.location,
    required this.placeImageUrl,
    required this.providerImageUrl,
    required this.description,
    required this.email,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.gallery,
  });
  ServiceProviderModel.withoffers(
      {required this.providerName,
      required this.serviceName,
      required this.location,
      required this.placeImageUrl,
      required this.providerImageUrl,
      required this.description,
      required this.email,
      required this.facebookUrl,
      required this.instagramUrl,
      required this.gallery,
      required this.offers});
}
