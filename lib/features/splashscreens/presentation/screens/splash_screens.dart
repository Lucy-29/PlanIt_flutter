import 'package:ems_1/features/auth/presentation/screens/login_page.dart';
import 'package:ems_1/features/splashscreens/presentation/cubit/splashscreen_cubit/splash_screen_cubit.dart';
import 'package:ems_1/features/splashscreens/presentation/screens/first_screen.dart';
import 'package:ems_1/features/splashscreens/presentation/screens/fourth_screen.dart';
import 'package:ems_1/features/splashscreens/presentation/screens/second_screen.dart';
import 'package:ems_1/features/splashscreens/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                        child: TextButton(
                          child: Text(
                            'Done',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            context
                                .read<SplashScreenCubit>()
                                .markSplashScreensAsComplete();
                          },
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
