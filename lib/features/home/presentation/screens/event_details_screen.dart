import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventCardModel eventCardModel;

  const EventDetailsScreen({required this.eventCardModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              Image.network(
                eventCardModel.imageUrl,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventCardModel.title,
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
                          eventCardModel.date,
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
                          eventCardModel.location,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage(eventCardModel.organizerImage),
                        ),
                        SizedBox(width: 15),
                        Text(eventCardModel.organizer),
                        SizedBox(width: 200),
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
                      eventCardModel.desc,
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
                    'Events Details',
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
              onPressed: () {},
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
                      'Buy a ticket \$${eventCardModel.price}',
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
                      color: Color(0xFF1a5f33), // Dark green circle background
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
}
