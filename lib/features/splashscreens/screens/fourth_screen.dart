import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

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
                'As a Company...',
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
                'assets/lottie/company.json',
                reverse: true,
                repeat: true,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Simply share your projects and parties and let people have fun with you',
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
