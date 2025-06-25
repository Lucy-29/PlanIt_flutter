import 'package:ems_1/features/auth/presentation/screens/service_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:ems_1/features/auth/presentation/screens/registration_type.dart';
import 'package:ems_1/features/auth/presentation/screens/register_screen.dart';

class SignupOptionsPage extends StatelessWidget {
  const SignupOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF4F2EA),
      body: Stack(
        children: [
          Positioned(
            top: -210,
            left: -210,
            child: Container(
              width: 550,
              height: 550,
              decoration: const BoxDecoration(
                color: Color(0xFF206173),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: -130,
            left: 230,
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                color: Color(0xFF50C878),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 170),
              const Padding(
                padding: EdgeInsets.only(right: 90),
                child: Text(
                  'Who You Are',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 130),
              Container(
                height: 120,
                width: 330,
                decoration: BoxDecoration(
                  color: const Color(0xFFD99A9A),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Image.asset('assets/images/Picsart_girl.png'),
                      Image.asset('assets/images/Picsart_boy.png'),
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(
                                type: RegistrationType.user,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'User',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 120,
                width: 330,
                decoration: BoxDecoration(
                  color: const Color(0xFFD99A9A),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Image.asset('assets/images/Picsart_provider.png'),
                      const SizedBox(width: 30),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceSelectionScreen(
                                registrationType: RegistrationType.provider,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Provider',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 120,
                width: 330,
                decoration: BoxDecoration(
                  color: const Color(0xFFD99A9A),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Image.asset('assets/images/Picsart_Company.png'),
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceSelectionScreen(
                                registrationType: RegistrationType.company,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Company',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: TextButton(
                      onPressed: () {
                        //
                        //
                      },
                      child: const Text(
                        'continue as guest',
                        style: TextStyle(
                          // color: Color(0xFF206473),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
