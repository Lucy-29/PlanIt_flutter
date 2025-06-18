import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'As a Provider...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Text(
                'You Can..',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Lottie.asset(
                'assets/lottie/services.json',
                // 'assets/services1.json',
                reverse: true,
                repeat: true,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Share your services and find the perfect customers for you',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
