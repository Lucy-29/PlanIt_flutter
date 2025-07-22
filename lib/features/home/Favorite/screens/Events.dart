import 'dart:math';

import 'package:ems_1/common/widgets/event_card.dart';
import 'package:ems_1/features/home/data/models/company_model.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:flutter/material.dart';

class Events extends StatelessWidget {
  List<EventCard> myEvents = [
    EventCard(
        eventCardModel: EventCardModel(
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvL8KnEdIemiK4bUhR6HwHXf6Eo3BXXHsqHg&s",
            title: "title",
            date: "date",
            location: "location",
            goingCount: 20,
            organizer: CompanyModel(
                companyName: 'name',
                companyImageUrl: '',
                discription: '',
                location: ''),
            organizerImage: "organizerImage",
            desc: "desc",
            price: 20,
            eventType: ''))
  ];
  @override
  Widget build(BuildContext context) {
    if (myEvents.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(children: [
          Image.asset(
            "assets/images/favorite.png",
            height: 330,
            width: 330,
          ),
          Text("no liked events!")
        ]),
      );
    } else {
      return ListView.builder(
          itemCount: myEvents.length,
          itemBuilder: (context, i) {
            return myEvents[i];
          });
    }
  }
}
