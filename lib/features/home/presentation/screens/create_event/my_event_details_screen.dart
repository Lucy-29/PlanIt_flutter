import 'dart:io';
import 'package:ems_1/common/widgets/show_guest_alert.dart';
import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:ems_1/features/home/data/models/event_details_model.dart';
import 'package:ems_1/features/home/data/models/company_model.dart';
import 'package:ems_1/features/home/presentation/screens/user_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MyEventDetailsScreen extends StatelessWidget {
  final EventDetailsModel event;

  const MyEventDetailsScreen({
    required this.event,
    super.key,
  });

  EventCardModel _convertToEventCardModel() {
    return EventCardModel(
      imageUrl: event.imagePath ?? '',
      title: event.eventName,
      date: DateFormat('dd MMM yyyy').format(event.eventDate),
      location: event.location,
      goingCount: 0, // Mock data
      organizer: CompanyModel(
        companyName: 'My Event',
        companyImageUrl: event.imagePath ?? '',
        discription: event.description,
        location: event.location,
      ),
      organizerImage: event.imagePath ?? '',
      desc: event.description,
      price: event.price,
      eventType: event.eventType ?? 'No Type',
    );
  }

  String get approvalStatus => 'pending'; // Mock data - replace with actual status
  String get privacyStatus => event.privacy == EventPrivacy.private ? 'private' : 'public';

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final isGuest = authState is Authenticated && authState.isGuest;
    final eventCardModel = _convertToEventCardModel();
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              event.imagePath != null
                  ? Image.file(
                      File(event.imagePath!),
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 350,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      child: Icon(
                        Icons.event,
                        size: 100,
                        color: Colors.grey.shade500,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.eventName,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                        ),
                        SizedBox(width: 10),
                        Text(
                          DateFormat('dd MMM yyyy').format(event.eventDate),
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          event.location,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(_getApprovalIcon()),
                        SizedBox(width: 10),
                        Text(
                          'Status: ${approvalStatus.toUpperCase()}',
                          style: TextStyle(
                            fontSize: 18,
                            color: _getApprovalColor(),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          privacyStatus == 'private' ? Icons.lock : Icons.public,
                          color: privacyStatus == 'private' ? Colors.orange : Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Privacy: ${privacyStatus.toUpperCase()}',
                          style: TextStyle(
                            fontSize: 18,
                            color: privacyStatus == 'private' ? Colors.orange : Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.person),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'My Event',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text('Visit'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      event.description,
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              top: 40,
              left: 10,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'My Event Details',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              )),
          Positioned(
            top: 325,
            left: 100,
            child: Row(
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Invite Your Friends',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 60,
            child: ElevatedButton(
              onPressed: () {
                isGuest
                    ? showGuestAlert(context)
                    : Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserScreens()));
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(280, 55),
                backgroundColor: Color(0xFF50C878),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Buy a ticket \$${event.price}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF1a5f33),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getApprovalIcon() {
    switch (approvalStatus.toLowerCase()) {
      case 'approved':
        return Icons.check_circle;
      case 'pending':
        return Icons.schedule;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  Color _getApprovalColor() {
    switch (approvalStatus.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}