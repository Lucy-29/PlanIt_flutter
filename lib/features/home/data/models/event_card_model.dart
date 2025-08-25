import 'package:ems_1/features/home/data/models/company_model.dart';

class EventCardModel {
  bool isFavorite = false;

  final String imageUrl;
  final String title;
  final String date;
  final String location;
  final int goingCount;
  final CompanyModel organizer;
  final String organizerImage;
  final String desc;
  final double price;
  final String eventType;
  ////////////////////////////////////////////

  EventCardModel(
      {required this.imageUrl,
      required this.title,
      required this.date,
      required this.location,
      required this.goingCount,
      required this.organizer,
      required this.organizerImage,
      required this.desc,
      required this.price,
      required this.eventType});
        factory EventCardModel.fromJson(Map<String, dynamic> json) {
    return EventCardModel(
      imageUrl: json['imageUrl'] ?? '',
      title: json['title'] ?? 'Untitled',
      date: json['date'] ?? '',
      location: json['location'] ?? 'Unknown',
      goingCount: json['goingCount'] ?? 0,
      organizer: json['organizer'] != null
          ? CompanyModel.fromJson(json['organizer'])
          : CompanyModel(
              companyName: 'Unknown',
              companyImageUrl: '',
              discription: '',
              location: '',
            ),
      organizerImage: json['organizerImage'] ?? '',
      desc: json['desc'] ?? '',
      price: (json['price'] != null)
          ? double.tryParse(json['price'].toString()) ?? 0.0
          : 0.0,
      eventType: json['eventType'] ?? 'Other',
    );
  }
}
