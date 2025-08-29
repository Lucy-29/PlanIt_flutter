import 'dart:ffi';

import 'package:ems_1/common/widgets/event_card.dart';

class CompanyModel {
  bool isFavorite = false;
  final String companyName;
  final String companyImageUrl;
  final String discription;
  final String location;
   List<EventCard> events = [];
  late Float rate;
  CompanyModel(
      {required this.companyName,
      required this.companyImageUrl,
      required this.discription,
      required this.location});
        factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      companyName: json['companyName'] ?? 'Unknown',
      companyImageUrl: json['companyImageUrl'] ?? '',
      discription: json['discription'] ?? '',
      location: json['location'] ?? '',
    );
  }
}
