import 'package:flutter/material.dart';
import 'package:ems_1/features/home/presentation/screens/favorite/Events.dart';
import 'package:ems_1/features/home/presentation/screens/favorite/Providers.dart';
import 'package:ems_1/features/home/presentation/screens/favorite/Companies.dart';

class Favoritescreen extends StatelessWidget {
  Favoritescreen({super.key});

  final List<Widget> tabs = const [
    Tab(text: "EVENTS"),
    Tab(text: "PROVIDERS"),
    Tab(text: "COMPANIES"),
  ];

  final List<Widget> pages = [
    Events(),
    Providers(),
    Companies(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        // backgroundColor: const Color(0xFFF4F2EA),
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          // backgroundColor: const Color(0xFFF4F2EA),
          centerTitle: true,
          title: const Text(
            "Favorite",
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.more_vert, color: Colors.black),
            ),
          ],
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
