import 'package:flutter/material.dart';

class Calendarscreen extends StatelessWidget {
  const Calendarscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        // backgroundColor: Color(0xFFF4F2EA),
        centerTitle: true,
      ),
    );
  }
}
