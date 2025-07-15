import 'package:ems_1/core/service_locator/service_locator.dart';
import 'package:ems_1/features/auth/presentation/screens/signup_options_page.dart';
import 'package:ems_1/features/home/presentation/screens/user_home_screen.dart';
import 'package:ems_1/features/home/presentation/screens/user_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ems_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:ems_1/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:ems_1/common/widgets/customtextformfield.dart';
import 'package:ems_1/features/auth/presentation/screens/forgotpassword.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit(sl<AuthRepository>())),
          BlocProvider<AuthCubit>.value(
            value: context.read<AuthCubit>(), // ✅ reuse existing instance
          ),
        ],
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, authState) {
            if (authState is Authenticated) {
              print(
                  'HEREEEEE I AMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserScreens()));
              // final user = authState.user;

              // if (user.type == 'user') {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(builder: (_) => const UserScreens()),
              //   );
              // }
              // else if (user.type == 'provider') {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(builder: (_) => const ProviderHomeScreen()),
              //   );
              // } else if (user.type == 'company') {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(builder: (_) => const CompanyHomeScreen()),
              //   );
              // }
            }
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    print(
        'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 235,
          child: Container(
            width: 398,
            height: 398,
            decoration: const BoxDecoration(
              color: Color(0xFFD99A9A),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: -470,
          left: -200,
          child: Container(
            width: 800,
            height: 800,
            decoration: const BoxDecoration(
              color: Color(0xFF206173),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: -480,
          left: -300,
          child: Container(
            width: 600,
            height: 600,
            decoration: const BoxDecoration(
              color: Color(0xFF50C878),
              shape: BoxShape.circle,
            ),
          ),
        ),
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              if (state.loginResponse.user != null) {
                context
                    .read<AuthCubit>()
                    .userLoggedIn(state.loginResponse.user!);
              } else {
                context.read<AuthCubit>().checkAuthentication();
              }
            }
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.error), backgroundColor: Colors.red),
              );
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  const Padding(
                    padding: EdgeInsets.only(left: 35),
                    child: Row(
                      children: [
                        Text('Welcome',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 35),
                    child: Row(
                      children: [
                        Text('Back',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 130),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                    child: CustomTextFormField(
                      controller: emailController,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                    child: CustomTextFormField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: isPasswordVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Forgotpassword(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                          // color: Color(0xFF206473),
                          fontWeight: FontWeight.bold,
                          // fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 35),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return const CircularProgressIndicator();
                            }
                            return ElevatedButton(
                              onPressed: () {
                                _login();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => UserScreens(),
                                //   ),
                                // );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF50C878),
                                shape: const CircleBorder(),
                                fixedSize: const Size(55, 55),
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupOptionsPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 150),
                  // Column(
                  //   // mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     TextButton(
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => SignupOptionsPage(),
                  //           ),
                  //         );
                  //       },
                  //       child: const Padding(
                  //         padding: EdgeInsets.only(left: 35),
                  //         child: Text(
                  //           'Sign up',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             // color: Color(0xFF206473),
                  //             fontSize: 20,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     // const Spacer(),
                  //     // Padding(
                  //     //   padding: const EdgeInsets.only(right: 35),
                  //     //   child: TextButton(
                  //     //     onPressed: () {
                  //     //       Navigator.push(
                  //     //         context,
                  //     //         MaterialPageRoute(
                  //     //           builder: (context) => Forgotpassword(),
                  //     //         ),
                  //     //       );
                  //     //     },
                  //     //     child: const Text(
                  //     //       'Forgot Password',
                  //     //       style: TextStyle(
                  //     //         // color: Color(0xFF206473),
                  //     //         fontWeight: FontWeight.bold,
                  //     //         fontSize: 20,
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     // )
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
