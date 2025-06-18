// --- COMPLETE IMPORTS ---
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ems_1/core/service_locator/service_locator.dart';
import 'package:ems_1/features/auth/data/models/service_item_model.dart';
import 'package:ems_1/features/auth/presentation/screens/pending_approval_screen.dart';
import 'package:ems_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:ems_1/features/auth/presentation/cubit/registration/registration_cubit.dart';
import 'package:ems_1/common/widgets/customtextformfield.dart';
import 'package:ems_1/features/auth/presentation/screens/registration_type.dart';
import 'package:ems_1/common/widgets/showdialoge.dart'; // Your custom dialog

// --- UNCHANGED WIDGETS ---
class RegisterScreen extends StatelessWidget {
  final RegistrationType type;
  final List<ServiceItemModel>? initialService;
  const RegisterScreen({required this.type, this.initialService, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationCubit(sl<AuthRepository>()),
      child: Scaffold(
        // backgroundColor: const Color(0xFFF4F2EA),
        body: RegisterForm(type: type, initialService: initialService),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  final RegistrationType type;
  final List<ServiceItemModel>? initialService;
  const RegisterForm({required this.type, this.initialService, super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

// =========================================================================
// ===                    START OF COMPLETE STATE CLASS                    ===
// =========================================================================

class _RegisterFormState extends State<RegisterForm> {
  // --- Your controllers and state variables ---
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _linksController = TextEditingController();

  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  // Local loading state ONLY for the initial /send-otp API call.
  bool _isSendingOtp = false;

  // --- NEW MASTER REGISTRATION FUNCTION ---
  // This function contains the corrected logic flow.
  Future<void> _processRegistration() async {
    // 1. Validate the main form.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // THIS IS THE CORRECT LOGIC FOR YOUR CURRENT BACKEND
    // It calls /send-otp first, then shows the dialog.
    setState(() {
      _isSendingOtp = true;
    });

    try {
      // 2. Call /send-otp to set '123456' in the backend cache.
      await sl<AuthRepository>().sendOtp(email: _emailController.text.trim());

      // 3. Pop up the dialog to get the OTP from the user.
      final String? otpFromDialog = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (_) => Showdialoge(email: _emailController.text.trim()),
      );

      // 4. If the user provided an OTP, finalize the registration.
      if (otpFromDialog != null && otpFromDialog.isNotEmpty) {
        _finalizeRegistration(otpFromDialog);
      }
    } catch (e) {
      // Handle any errors from the /send-otp call.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      // 5. Always hide the button's loading indicator.
      if (mounted) {
        setState(() {
          _isSendingOtp = false;
        });
      }
    }
  }

  /// This function takes the OTP and sends all data to the backend via the Cubit.
  void _finalizeRegistration(String otpFromDialog) {
    final List<String> links = _linksController.text
        .split('\n')
        .map((link) => link.trim())
        .where((link) => link.isNotEmpty)
        .toList();

    final servicesAsString = widget.initialService != null
        ? widget.initialService!
            .map((service) => service.serviceName)
            .join(', ')
        : '';
    final cubit = context.read<RegistrationCubit>();

    switch (widget.type) {
      case RegistrationType.user:
        cubit.registerUser(
          name: _nameController.text,
          email: _emailController.text.trim(),
          password: _passwordController.text,
          passwordConfirmation: _confirmPasswordController.text,
          otp: otpFromDialog,
        );
        break;
      case RegistrationType.provider:
        cubit.registerProvider(
          name: _nameController.text,
          email: _emailController.text.trim(),
          password: _passwordController.text,
          passwordConfirmation: _confirmPasswordController.text,
          otp: otpFromDialog,
          service: servicesAsString,
          links: links,
        );
        break;
      case RegistrationType.company:
        cubit.registerCompany(
          companyName: _nameController.text,
          email: _emailController.text.trim(),
          password: _passwordController.text,
          passwordConfirmation: _confirmPasswordController.text,
          otp: otpFromDialog,
          service: servicesAsString,
          links: links,
        );
        break;
    }
  }

  @override
  void dispose() {
    // Your full dispose method
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _linksController.dispose();
    super.dispose();
  }

  // --- YOUR COMPLETE, UNCHANGED BUILD METHOD ---
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -500,
          left: -350,
          child: Container(
            width: 800,
            height: 800,
            decoration: const BoxDecoration(
              color: Color(0xFF206173),
              shape: BoxShape.circle,
            ),
          ),
        ),
        BlocListener<RegistrationCubit, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.error), backgroundColor: Colors.red),
              );
            }
            if (state is RegistrationSuccessUser) {
              context.read<AuthCubit>().userLoggedIn(state.loginResponse.user!);
            }
            if (state is RegistrationSuccessProvider) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (_) =>
                        PendingApprovalScreen(request: state.providerRequest)),
                (route) => false,
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 140),
                    const Padding(
                      padding: EdgeInsets.only(right: 200),
                      child: Text('Create',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 170),
                      child: Text('Account',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 80),
                    CustomTextFormField(
                      controller: _nameController,
                      hintText: widget.type == RegistrationType.company
                          ? 'Company Name'
                          : 'Full Name',
                      validator: (value) =>
                          value!.isEmpty ? 'Cannot be empty' : null,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _emailController,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: _isPasswordVisible,
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                            () => _isPasswordVisible = !_isPasswordVisible),
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: _isConfirmPasswordVisible,
                      suffixIcon: IconButton(
                        onPressed: () => setState(() =>
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible),
                        icon: Icon(_isConfirmPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter a passwrod';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (widget.type != RegistrationType.user &&
                        widget.initialService != null) ...[
                      TextFormField(
                        controller: _linksController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: 'Portfolio, Website, LinkedIn Links',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text('Your Selected Services:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[200],
                            ),
                            child: Wrap(
                              children: widget.initialService!.map((service) {
                                return Chip(
                                  avatar: Text(service.emoji,
                                      style: const TextStyle(fontSize: 14)),
                                  label: Text(service.serviceName),
                                  backgroundColor: const Color(0xFF206173),
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        const Text('Sign Up',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        BlocBuilder<RegistrationCubit, RegistrationState>(
                            builder: (context, state) {
                          final isFinalizing = state is RegistrationLoading;
                          final isButtonDisabled =
                              _isSendingOtp || isFinalizing;

                          if (isButtonDisabled) {
                            return const CircularProgressIndicator();
                          }

                          return ElevatedButton(
                            onPressed:
                                _processRegistration, // Calls our new master function
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF50C878),
                                shape: const CircleBorder(),
                                fixedSize: const Size(55, 55)),
                            child: const Icon(Icons.arrow_forward,
                                color: Colors.white),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:ems_1/features/auth/presentation/widgets/showdialoge.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // Your existing imports
// import 'package:ems_1/core/service_locator/service_locator.dart';
// import 'package:ems_1/features/auth/data/models/service_item_model.dart';
// import 'package:ems_1/features/auth/presentation/screens/pending_approval_screen.dart';
// import 'package:ems_1/features/auth/domain/repositories/auth_repository.dart';
// import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
// import 'package:ems_1/features/auth/presentation/cubit/registration/registration_cubit.dart';
// import 'package:ems_1/features/auth/presentation/widgets/customtextformfield.dart';
// import 'package:ems_1/features/auth/presentation/screens/registration_type.dart';

// class RegisterScreen extends StatelessWidget {
//   final RegistrationType type;
//   final List<ServiceItemModel>? initialService;
//   const RegisterScreen({required this.type, this.initialService, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => RegistrationCubit(sl<AuthRepository>()),
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF4F2EA),
//         body: RegisterForm(type: type, initialService: initialService),
//       ),
//     );
//   }
// }

// class RegisterForm extends StatefulWidget {
//   final RegistrationType type;
//   final List<ServiceItemModel>? initialService;
//   const RegisterForm({required this.type, this.initialService, super.key});

//   @override
//   State<RegisterForm> createState() => _RegisterFormState();
// }

// class _RegisterFormState extends State<RegisterForm> {
//   // --- Controllers are the same, but no OTP controller needed ---
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   bool _isPasswordVisible = true;
//   bool _isConfirmPasswordVisible = true;

//   bool _isProcessing = false;

//   // 2. THIS IS THE NEW HELPER FUNCTION
//   Future<void> _processRegistration() async {
//     // A. Validate the main form.
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     // B. Pop up the dialog and wait for the OTP.
//     final String? otpFromDialog = await showDialog<String>(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => Showdialoge(email: _emailController.text.trim()),
//     );

//     // C. If the user provided an OTP, proceed.
//     if (otpFromDialog != null && otpFromDialog.isNotEmpty) {
//       final String servicesAsString = widget.initialService != null
//           ? widget.initialService!
//               .map((service) => service.serviceName)
//               .join(', ')
//           : '';

//       final cubit = context.read<RegistrationCubit>();

//       // D. Call the correct cubit method with the OTP from the dialog.
//       switch (widget.type) {
//         case RegistrationType.user:
//           cubit.registerUser(
//             name: _nameController.text,
//             email: _emailController.text.trim(),
//             password: _passwordController.text,
//             passwordConfirmation: _confirmPasswordController.text,
//             otp: otpFromDialog,
//           );
//           break;
//         case RegistrationType.provider:
//           cubit.registerProvider(
//             name: _nameController.text,
//             email: _emailController.text.trim(),
//             password: _passwordController.text,
//             passwordConfirmation: _confirmPasswordController.text,
//             otp: otpFromDialog,
//             service: servicesAsString,
//           );
//           break;
//         case RegistrationType.company:
//           cubit.registerCompany(
//             companyName: _nameController.text,
//             email: _emailController.text.trim(),
//             password: _passwordController.text,
//             passwordConfirmation: _confirmPasswordController.text,
//             otp: otpFromDialog,
//             service: servicesAsString,
//           );
//           break;
//       }
//     }
//   }

//   @override
//   void dispose() {
//     // --- Dispose method is now cleaner ---
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           top: -500,
//           left: -350,
//           child: Container(
//             width: 800,
//             height: 800,
//             decoration: const BoxDecoration(
//               color: Color(0xFF206173),
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//         // --- BlocListener remains UNCHANGED. It handles the final result perfectly. ---
//         BlocListener<RegistrationCubit, RegistrationState>(
//           listener: (context, state) {
//             if (state is RegistrationFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                     content: Text(state.error), backgroundColor: Colors.red),
//               );
//             }
//             if (state is RegistrationSuccessUser) {
//               context.read<AuthCubit>().userLoggedIn(state.loginResponse.user!);
//             }
//             if (state is RegistrationSuccessProvider) {
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                     builder: (_) =>
//                         PendingApprovalScreen(request: state.providerRequest)),
//                 (route) => false,
//               );
//             }
//           },
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     // --- ALL YOUR UI WIDGETS ARE UNCHANGED, UP TO THE BUTTON ---
//                     const SizedBox(height: 140),
//                     const Padding(
//                       padding: EdgeInsets.only(right: 200),
//                       child: Text('Create',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 40,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(right: 170),
//                       child: Text('Account',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 40,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                     const SizedBox(height: 80),
//                     CustomTextFormField(
//                       controller: _nameController,
//                       hintText: widget.type == RegistrationType.company
//                           ? 'Company Name'
//                           : 'Full Name',
//                       validator: (value) =>
//                           value!.isEmpty ? 'Cannot be empty' : null,
//                     ),
//                     const SizedBox(height: 20),
//                     CustomTextFormField(
//                       controller: _emailController,
//                       hintText: 'Email',
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                             .hasMatch(value)) {
//                           return 'Please enter a valid email';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     CustomTextFormField(
//                       controller: _passwordController,
//                       hintText: 'Password',
//                       obscureText: _isPasswordVisible,
//                       suffixIcon: IconButton(
//                         onPressed: () => setState(
//                             () => _isPasswordVisible = !_isPasswordVisible),
//                         icon: Icon(_isPasswordVisible
//                             ? Icons.visibility_off
//                             : Icons.visibility),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a password';
//                         }
//                         if (value.length < 6) {
//                           return 'password must be at least 6 characters';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     CustomTextFormField(
//                       controller: _confirmPasswordController,
//                       hintText: 'Confirm Password',
//                       obscureText: _isConfirmPasswordVisible,
//                       suffixIcon: IconButton(
//                         onPressed: () => setState(() =>
//                             _isConfirmPasswordVisible =
//                                 !_isConfirmPasswordVisible),
//                         icon: Icon(_isConfirmPasswordVisible
//                             ? Icons.visibility_off
//                             : Icons.visibility),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'please enter a passwrod';
//                         }
//                         if (value != _passwordController.text) {
//                           return 'Passwords do not match';
//                         }
//                         return null;
//                       },
//                     ),
//                     if (widget.type != RegistrationType.user &&
//                         widget.initialService != null) ...[
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Text('Your Selected Services:',
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
//                               children: widget.initialService!.map((service) {
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
//                     ],
//                     const SizedBox(height: 50),
//                     Row(
//                       children: [
//                         const Text('Sign Up',
//                             style: TextStyle(
//                                 fontSize: 30, fontWeight: FontWeight.bold)),
//                         const Spacer(),
//                         BlocBuilder<RegistrationCubit, RegistrationState>(
//                             builder: (context, state) {
//                           if (state is RegistrationLoading) {
//                             return const CircularProgressIndicator();
//                           }
//                           // --- 3. THE BUTTON IS UPDATED ---
//                           return ElevatedButton(
//                             onPressed:
//                                 _processRegistration, // Calls our new master function
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF50C878),
//                                 shape: const CircleBorder(),
//                                 fixedSize: const Size(55, 55)),
//                             child: const Icon(Icons.arrow_forward,
//                                 color: Colors.white),
//                           );
//                         }),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
