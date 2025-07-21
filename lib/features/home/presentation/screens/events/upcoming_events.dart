import 'package:ems_1/common/widgets/event_card.dart';
import 'package:flutter/material.dart';

class UpcomingEvetns extends StatelessWidget {
  List<EventCard> upComingEvents = [];

  @override
  Widget build(BuildContext context) {
    if (upComingEvents.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(children: [
          Image.asset(
            "assets/images/upComingEvents.png",
            height: 350,
            width: 350,
          ),
        ]),
      );
    } else {
      return ListView.builder(
          itemCount: upComingEvents.length,
          itemBuilder: (context, i) {
            return upComingEvents[i];
          });
    }
  }
}
