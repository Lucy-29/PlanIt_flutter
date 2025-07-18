import 'package:ems_1/features/home/data/models/company_model.dart';

class EventCardModel {
  final String imageUrl;
  final String title;
  final String date;
  final String location;
  final int goingCount;
  final CompanyModel organizer;
  final String organizerImage;
  final String desc;
  final String price;

  EventCardModel(
      {required this.imageUrl,
      required this.title,
      required this.date,
      required this.location,
      required this.goingCount,
      required this.organizer,
      required this.organizerImage,
      required this.desc,
      required this.price});
}
