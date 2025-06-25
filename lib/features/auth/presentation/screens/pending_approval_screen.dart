import 'package:ems_1/core/service_locator/service_locator.dart';
import 'package:ems_1/features/auth/presentation/cubit/approval/approval_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ems_1/features/auth/data/models/provider_request_model.dart';
import 'package:ems_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';

class PendingApprovalScreen extends StatelessWidget {
  /// The registration receipt containing the user's email and details.
  final ProviderRequestModel request;

  const PendingApprovalScreen({required this.request, super.key});

  @override
  Widget build(BuildContext context) {
    // We provide the local ApprovalCubit here
    return BlocProvider(
      create: (context) => ApprovalCubit(sl<AuthRepository>())
        // Immediately check the status when the screen is created
        ..checkStatus(request.email),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Application Status"),
          // The logout action should be available here
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                // Call the GLOBAL AuthCubit to log out.
                // This will trigger the main navigator to go to the LoginPage.
                context.read<AuthCubit>().logout();
              },
            )
          ],
        ),
        body: Center(
          // BlocBuilder will rebuild the UI based on the ApprovalCubit's state
          child: BlocBuilder<ApprovalCubit, ApprovalState>(
            builder: (context, state) {
              // --- Show different UI based on the state ---

              if (state is ApprovalStatusApproved) {
                return _StatusView(
                  imagePath: 'assets/images/approved.png',
                  title: "Congratulations, ${state.status.name}!",
                  message:
                      "Your application has been approved. You can now log in to access your account.",
                  buttonText: "Proceed to Login",
                  onButtonPressed: () {
                    // Log out to clear the pending token and go to login screen
                    context.read<AuthCubit>().logout();
                  },
                );
              }

              if (state is ApprovalFailure) {
                return _StatusView(
                  imagePath: 'assets/images/rejected.png',
                  title: "Application Not Approved",
                  message:
                      "We're sorry, but your application could not be approved at this time. Please contact support for more information.",
                  buttonText: "Back to Home",
                  onButtonPressed: () {
                    // Log out to clear the pending token and go to login screen
                    context.read<AuthCubit>().logout();
                  },
                );
              }

              // By default (including Initial and Pending states), show the pending view.
              // A loading indicator is shown inside the _StatusView for a better UX.
              return _StatusView(
                imagePath: 'assets/images/Picsart_waitingscreen.png',
                title: "Your Application is Under Review",
                message:
                    "Thank you for registering, ${request.name}.\nYour service application is pending approval by an administrator. Please check back later.",
                buttonText: "Check Status Again",
                isLoading: state is ApprovalLoading,
                onButtonPressed: () {
                  // Manually re-trigger the status check
                  context.read<ApprovalCubit>().checkStatus(request.email);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

/// A reusable private widget to display the status UI to keep the build method clean.
class _StatusView extends StatelessWidget {
  final String imagePath;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool isLoading;

  const _StatusView({
    required this.imagePath,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // The image you provided
          Image.asset(imagePath, height: 180),
          const SizedBox(height: 32),
          // Title text
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Message text
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 40),
          // Button or Loading Indicator
          SizedBox(
            height: 50,
            width: 250,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: onButtonPressed,
                    child: Text(buttonText),
                  ),
          )
        ],
      ),
    );
  }
}
