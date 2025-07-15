import 'package:ems_1/features/auth/presentation/screens/login_page.dart';
import 'package:ems_1/features/splashscreens/screens/first_screen.dart';
import 'package:ems_1/features/splashscreens/screens/fourth_screen.dart';
import 'package:ems_1/features/splashscreens/screens/second_screen.dart';
import 'package:ems_1/features/splashscreens/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  final PageController pageController = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                isLastPage = (index == 3);
              });
            },
            children: [
              FirstScreen(),
              SecondScreen(),
              ThirdScreen(),
              FourthScreen(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    pageController.jumpToPage(3);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SmoothPageIndicator(controller: pageController, count: 4),
                isLastPage
                    ? TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
