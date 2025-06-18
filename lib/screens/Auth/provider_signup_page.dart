// import 'dart:developer';
// import 'package:ems_1/cubits/auth_cubit/auth_cubit.dart';
// import 'package:ems_1/features/auth/data/models/service_item_model.dart';
// import 'package:ems_1/features/auth/presentation/screens/login_page.dart';
// import 'package:ems_1/screens/Home_Pages/provider_home_page.dart';
// import 'package:ems_1/widgets/customtextformfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProviderSignupPage extends StatefulWidget {
//   final List<ServiceItemModel> selectedServices;

//   ProviderSignupPage({super.key, required this.selectedServices});

//   @override
//   State<ProviderSignupPage> createState() => _ProviderSignupPageState();
// }

// class _ProviderSignupPageState extends State<ProviderSignupPage> {
//   final _formKey = GlobalKey<FormState>(); //
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final TextEditingController otpCodeController = TextEditingController();
//   final TextEditingController socialMediaLinksController =
//       TextEditingController();

//   bool isConfirmPasswordVisible = true;
//   bool isPasswordVisible = true;

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     otpCodeController.dispose();
//     socialMediaLinksController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF4F2EA),
//       body: Stack(
//         children: [
//           Positioned(
//             top: -500,
//             left: -300,
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
//                 showDialog(
//                     context: context,
//                     barrierDismissible: false,
//                     builder: (_) => Center(child: CircularProgressIndicator()));
//               } else if (state is AuthRegistrationPending) {
//                 if (Navigator.of(context, rootNavigator: true).canPop()) {
//                   Navigator.of(context, rootNavigator: true).pop();
//                 }
//                 // For Provider/Company, successful signup usually leads to a pending page or login prompt
//                 // ProviderHomePage might not be the immediate next step until approval.
//                 // For now, let's keep ProviderHomePage but you might change this flow.
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                       content: Text(state.message)), // Show pending message
//                 );
//                 // Potentially navigate to a "Pending Approval" page or back to login.
//                 // For now, let's assume ProviderHomePage is shown after they log in later.
//                 // Or, if ProviderHomePage can handle a pending state:
//                 // Navigator.pushReplacement(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) => ProviderHomePage(providerData: state.someProviderDataFromPendingState),
//                 //   ),
//                 // );
//                 // For simplicity now, just show message. User will login later.
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPage()),
//                   (Route<dynamic> route) => false,
//                 );
//               } else if (state is AuthFailure) {
//                 if (Navigator.of(context, rootNavigator: true).canPop()) {
//                   Navigator.of(context, rootNavigator: true).pop();
//                 }
//                 ScaffoldMessenger.of(context)
//                     .showSnackBar(SnackBar(content: Text(state.errorMessage)));
//               }
//             },
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: Form(
//                   // Wrap with Form
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       SizedBox(height: 80),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 200),
//                         child: Text('Create',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 40,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 170),
//                         child: Text('Account',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 40,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//                       SizedBox(height: 40),
//                       CustomTextFormField(
//                         controller: nameController,
//                         hintText: 'Name / Business Name',
//                         validator: (value) {
//                           if (value == null || value.isEmpty)
//                             return 'Please enter your name';
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       CustomTextFormField(
//                         controller: emailController,
//                         hintText: 'Email',
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value == null || value.isEmpty)
//                             return 'Please enter your email';
//                           if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                               .hasMatch(value)) return 'Enter a valid email';
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       CustomTextFormField(
//                         controller: passwordController,
//                         hintText: 'Password',
//                         obscureText: isPasswordVisible,
//                         suffixIcon: IconButton(
//                             onPressed: () => setState(
//                                 () => isPasswordVisible = !isPasswordVisible),
//                             icon: Icon(isPasswordVisible
//                                 ? Icons.visibility_off
//                                 : Icons.visibility)),
//                         validator: (value) {
//                           if (value == null || value.isEmpty)
//                             return 'Please enter a password';
//                           if (value.length < 6)
//                             return 'Password must be at least 6 characters';
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       CustomTextFormField(
//                         controller: confirmPasswordController,
//                         hintText: 'Confirm Password',
//                         obscureText: isConfirmPasswordVisible,
//                         suffixIcon: IconButton(
//                             onPressed: () => setState(() =>
//                                 isConfirmPasswordVisible =
//                                     !isConfirmPasswordVisible),
//                             icon: Icon(isConfirmPasswordVisible
//                                 ? Icons.visibility_off
//                                 : Icons.visibility)),
//                         validator: (value) {
//                           if (value == null || value.isEmpty)
//                             return 'Please confirm your password';
//                           if (value != passwordController.text)
//                             return 'Passwords do not match';
//                           return null;
//                         },
//                       ),
//                       // SizedBox(height: 20),
//                       // CustomTextFormField(
//                       //   controller: mainServiceController,
//                       //   hintText: 'Main Service Offered (e.g., Plumbing)',
//                       //   validator: (value) {
//                       //     if (value == null || value.isEmpty)
//                       //       return 'Please enter your main service';
//                       //     return null;
//                       //   },
//                       // ),
//                       SizedBox(height: 20),
//                       CustomTextFormField(
//                         controller: socialMediaLinksController,
//                         hintText: 'Social Media Links (Optional)',
//                       ),
//                       SizedBox(height: 20),
//                       CustomTextFormField(
//                         controller: otpCodeController,
//                         hintText: 'OTP Code (from email)',
//                         keyboardType: TextInputType.number,
//                         validator: (value) {
//                           if (value == null || value.isEmpty)
//                             return 'Please enter OTP';
//                           if (value.length != 6) return 'OTP must be 6 digits';
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Text(
//                                 'Your Selected Services (Informational)',
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.bold)),
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.grey[200],
//                             ),
//                             child: Wrap(
//                               spacing: 8,
//                               runSpacing: 8,
//                               children: widget.selectedServices.map((service) {
//                                 return Chip(
//                                   avatar: Text(service.emoji,
//                                       style: TextStyle(fontSize: 14)),
//                                   label: Text(service.serviceName),
//                                   backgroundColor: Color(0xFF206173),
//                                   labelStyle: TextStyle(color: Colors.white),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 30),
//                       Row(
//                         children: [
//                           Text('Sign Up',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.bold)),
//                           Spacer(),
//                           ElevatedButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 context.read<AuthCubit>().signUpProvider(
//                                       name: nameController.text,
//                                       email: emailController.text.trim(),
//                                       password: passwordController.text.trim(),
//                                       confirmPassword:
//                                           confirmPasswordController.text.trim(),
//                                       otp: otpCodeController.text.trim(),
//                                     );
//                               }
//                             },
//                             child:
//                                 Icon(Icons.arrow_forward, color: Colors.white),
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xFF50C878),
//                                 shape: CircleBorder(),
//                                 fixedSize: Size(55, 55)),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           TextButton(
//                             onPressed: () => Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => LoginPage())),
//                             child: Text('Sign In',
//                                 style: TextStyle(
//                                     color: Color(0xFF206473),
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     decoration: TextDecoration.underline,
//                                     decorationColor: Color(0xFFD99A9A),
//                                     decorationThickness: 3)),
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
