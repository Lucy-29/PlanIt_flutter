// import 'package:ems_1/cubits/auth_cubit/auth_cubit.dart';
// import 'package:ems_1/screens/Home_Pages/home_page.dart';
// import 'package:ems_1/features/auth/presentation/screens/login_page.dart';
// import 'package:ems_1/widgets/customtextformfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class UserSignupPage extends StatefulWidget {
//   UserSignupPage({super.key});

//   @override
//   State<UserSignupPage> createState() => _UserSignupPageState();
// }

// class _UserSignupPageState extends State<UserSignupPage> {
//   final _formKey = GlobalKey<FormState>(); // 1. Create GlobalKey for Form
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   bool isPasswordVisible = true;
//   bool isConfirmPasswordVisible = true;
//   bool _isSendingOtp = false;

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _showOtpDialog(String emailForOtp) {
//     final TextEditingController otpDialogController = TextEditingController();
//     final GlobalKey<FormState> otpDialogFormKey = GlobalKey<FormState>();

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//           title: Center(
//               child: Text('Enter OTP',
//                   style: TextStyle(fontWeight: FontWeight.bold))),
//           content: Form(
//             key: otpDialogFormKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('An OTP has been sent to\n$emailForOtp',
//                     textAlign: TextAlign.center),
//                 SizedBox(height: 20),
//                 CustomTextFormField(
//                   controller: otpDialogController,
//                   hintText: '6-digit OTP',
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter OTP';
//                     }
//                     if (value.length != 6) {
//                       return 'OTP must be 6 digits';
//                     }
//                     return null;
//                   },
//                 ),
//               ],
//             ),
//           ),
//           actionsAlignment: MainAxisAlignment.spaceEvenly,
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel', style: TextStyle(color: Colors.redAccent)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             ElevatedButton(
//               style:
//                   ElevatedButton.styleFrom(backgroundColor: Color(0xFF50C878)),
//               child: Text('Verify & Sign Up',
//                   style: TextStyle(color: Colors.white)),
//               onPressed: () {
//                 if (otpDialogFormKey.currentState!.validate()) {
//                   if (otpDialogController.text.trim() != '123456') {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Invalid OTP. Try 123456.")),
//                     );
//                     return;
//                   }
//                   Navigator.of(dialogContext).pop();

//                   context.read<AuthCubit>().signUpUser(
//                         name: nameController.text,
//                         email: emailController.text.trim(),
//                         password: passwordController.text.trim(),
//                         confirmPassword: confirmPasswordController.text.trim(),
//                         otp: otpDialogController.text.trim(),
//                       );
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => HomePage()));
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     ).then((_) {
//       // otpDialogController.dispose();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF4F2EA),
//       body: Stack(
//         children: [
//           Positioned(
//             top: -500,
//             left: -350,
//             child: Container(
//               width: 800,
//               height: 800,
//               decoration: BoxDecoration(
//                 color: Color(0xFF206173),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 600,
//             left: 200,
//             child: Container(
//               height: 400,
//               width: 400,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           BlocListener<AuthCubit, AuthState>(
//             listener: (context, state) {
//               if (state is AuthLoading) {
//                 if (!_isSendingOtp) {
//                   showDialog(
//                       context: context,
//                       barrierDismissible: false,
//                       builder: (_) =>
//                           Center(child: CircularProgressIndicator()));
//                 }
//               } else if (state is AuthOtpSent) {
//                 // <<< ADD THIS ELSE IF CASE
//                 setState(() {
//                   _isSendingOtp =
//                       false; // OTP request is done (successfully or not)
//                 });
//                 // AuthOtpSent now always has an email as per your simplified Cubit
//                 _showOtpDialog(state.email);
//               } else if (state is AuthSuccess) {
//                 if (Navigator.of(context, rootNavigator: true).canPop()) {
//                   Navigator.of(context, rootNavigator: true).pop();
//                 }
//                 setState(() {
//                   _isSendingOtp = false;
//                 });

//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         HomePage(), //user: state.user Pass user data
//                   ),
//                 );
//               } else if (state is AuthFailure) {
//                 if (Navigator.of(context, rootNavigator: true).canPop()) {
//                   Navigator.of(context, rootNavigator: true).pop();
//                 }
//                 setState(() {
//                   _isSendingOtp = false;
//                 });
//                 ScaffoldMessenger.of(context)
//                     .showSnackBar(SnackBar(content: Text(state.errorMessage)));
//               }
//             },
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 140,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           right: 200,
//                         ),
//                         child: Text(
//                           'Create',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 40,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           right: 170,
//                         ),
//                         child: Text(
//                           'Account',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 40,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 80,
//                       ),
//                       CustomTextFormField(
//                         controller: nameController,
//                         hintText: 'Name',
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your name';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       CustomTextFormField(
//                         controller: emailController,
//                         hintText: 'Email',
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                               .hasMatch(value)) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       CustomTextFormField(
//                         controller: passwordController,
//                         hintText: 'Password',
//                         obscureText: isPasswordVisible,
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               isPasswordVisible = !isPasswordVisible;
//                             });
//                           },
//                           icon: Icon(isPasswordVisible
//                               ? Icons.visibility_off
//                               : Icons.visibility),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a password';
//                           }
//                           if (value.length < 6) {
//                             return 'Password must be at least 6 characters';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       CustomTextFormField(
//                         controller: confirmPasswordController,
//                         hintText: 'Confirm Password',
//                         obscureText: isConfirmPasswordVisible,
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               isConfirmPasswordVisible =
//                                   !isConfirmPasswordVisible;
//                             });
//                           },
//                           icon: Icon(isConfirmPasswordVisible
//                               ? Icons.visibility_off
//                               : Icons.visibility),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please confirm your password';
//                           }
//                           if (value != passwordController.text) {
//                             return 'Passwords do not match';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       SizedBox(
//                         height: 35,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             'Sign Up',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Spacer(),
//                           ElevatedButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 _showOtpDialog(emailController.text.trim());
//                               }
//                             },
//                             child:
//                                 Icon(Icons.arrow_forward, color: Colors.white),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF50C878),
//                               shape: CircleBorder(),
//                               fixedSize: Size(55, 55),
//                             ),
//                           ),
//                           // onPressed: _isSendingOtp
//                           //     ? null
//                           //     : () {
//                           //         if (_formKey.currentState!.validate()) {
//                           //           setState(() {
//                           //             _isSendingOtp = true;
//                           //           });
//                           //           context.read<AuthCubit>().sendOtp(
//                           //                 email: emailController.text.trim(),
//                           //               );
//                           //         }
//                           //       },
//                           //   child: _isSendingOtp
//                           //       ? SizedBox(
//                           //           width: 24,
//                           //           height: 24,
//                           //           child: CircularProgressIndicator(
//                           //             color: Colors.white,
//                           //             strokeWidth: 3,
//                           //           ))
//                           //       : Icon(Icons.arrow_forward,
//                           //           color: Colors.white),
//                           //   style: ElevatedButton.styleFrom(
//                           //     backgroundColor: Color(0xFF50C878),
//                           //     shape: CircleBorder(),
//                           //     fixedSize: Size(55, 55),
//                           //   ),
//                           // )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 70,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => LoginPage(),
//                                 ),
//                               );
//                             },
//                             child: Text(
//                               'Sign In',
//                               style: TextStyle(
//                                 color: Color(0xFF206473),
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
