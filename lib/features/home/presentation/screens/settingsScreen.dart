import 'package:flutter/material.dart';

class Settingsscreen extends StatelessWidget {
  const Settingsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        // backgroundColor: Color(0xFFF4F2EA),
        centerTitle: true,
      ),
    );
  }
}
