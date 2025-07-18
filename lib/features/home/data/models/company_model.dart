import 'dart:ffi';

import 'package:ems_1/common/widgets/event_card.dart';

class CompanyModel {
  final String companyName;
  final String companyImageUrl;
  final String discription;
  final String location;
  late List<EventCard> events;
  late Float rate;
  CompanyModel(
      {required this.companyName,
      required this.companyImageUrl,
      required this.discription,
      required this.location});
      
}
