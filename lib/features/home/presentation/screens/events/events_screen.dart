import 'package:ems_1/features/home/presentation/screens/events/past_events.dart';
import 'package:ems_1/features/home/presentation/screens/events/pending_events.dart';
import 'package:ems_1/features/home/presentation/screens/events/upcoming_evetns.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({super.key});

  final List<Widget> tabs = const [
    Tab(text: "Pending"),
    Tab(text: "Upcoming"),
    Tab(text: "Past"),
  ];

  final List<Widget> pages = [
    PendingEvents(),
    UpcomingEvetns(),
    PastEvents(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            "Events",
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xffD9D9D9).withOpacity(0.3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                tabs: tabs,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: const Color(0xff206173),
                unselectedLabelColor: const Color(0xff206173).withOpacity(0.6),
                indicatorColor: Colors.transparent,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 4),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: TabBarView(children: pages),
      ),
    );
  }
}
