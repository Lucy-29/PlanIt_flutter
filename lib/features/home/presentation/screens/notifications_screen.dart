import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xFFF4F2EA),
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      // backgroundColor: Color(0xFFF4F2EA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(isDark
                  ? 'assets/images/notifications_darkmode.png'
                  : 'assets/images/notification pic.png'),
              SizedBox(
                height: 32,
              ),
              Text(
                'No Notifications Yet!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Be active! Participate in events, create parties, and invite your friends to receive notifications.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.8,
                  // color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
