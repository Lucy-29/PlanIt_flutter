import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

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
                'As a User...',
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
                'assets/lottie/introhost22.json',
                reverse: true,
                repeat: true,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Effortlessly attend and organize public or private events on your device with a stress-free form.',
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
