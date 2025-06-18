class CreateEventModel {
  final String name;
  final DateTime dateTime;
  final String date;
  final String time;
  final String privacy;
  final String type;
  final String location;
  CreateEventModel({
    required this.name,
    required this.dateTime,
    required this.date,
    required this.time,
    required this.privacy,
    required this.type,
    required this.location,
  });
}
