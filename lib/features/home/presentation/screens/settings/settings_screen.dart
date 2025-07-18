import 'package:ems_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:ems_1/features/auth/presentation/screens/login_page.dart';
import 'package:ems_1/features/home/presentation/cubit/themes/themes_cubit.dart';
import 'package:ems_1/features/home/presentation/screens/settings/contactus_screen.dart';
import 'package:ems_1/features/home/presentation/screens/settings/privacyandpolicy_screen.dart';
import 'package:ems_1/features/home/presentation/screens/settings/profile_screen.dart';
import 'package:ems_1/features/home/presentation/screens/settings/termsandconditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // File? _profileImage;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        children: [
          _buildProfileCard(context),
          const SizedBox(height: 20),
          // _buildToggleItem(
          //   context: context,
          //   title: 'Notification',
          //   value: true,
          //   onChanged: (value) {},
          // ),
          // const SizedBox(height: 5),
          _buildToggleItem(
            context: context,
            title: 'Dark Mode',
            value: context.watch<ThemesCubit>().state is ThemesDark,
            onChanged: (value) {
              context.read<ThemesCubit>().toggleTheme(value);
            },
          ),
          const SizedBox(height: 20),
          _buildActionItem(
            context: context,
            title: 'Share App',
            icon: Icons.share_outlined,
            onTap: () {
              Share.share(
                'Check out this app I\'m building! You can follow my progress on GitHub: https://github.com/Ghaly88/PlanIt_flutter.git',
              );
            },
          ),
          _buildActionItem(
            context: context,
            title: 'Privacy Policy',
            icon: Icons.lock_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
          _buildActionItem(
            context: context,
            title: 'Terms and Conditions',
            icon: Icons.copy_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsandconditionsScreen(),
                ),
              );
            },
          ),
          _buildActionItem(
            context: context,
            title: 'Contact us',
            icon: Icons.chat_bubble_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactUsScreen(),
                ),
              );
            },
          ),
          _buildActionItem(
            context: context,
            title: 'log out',
            icon: Icons.logout,
            iconColor: Colors.red,
            onTap: () {
              // 1. Show a confirmation dialog (good practice)
              showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                        title: Text("Log Out"),
                        content: Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                                // 2. Call the global AuthCubit to log out.
                                context.read<AuthCubit>().logout();
                              },
                              child: Text("Log Out",
                                  style: TextStyle(color: Colors.red))),
                        ],
                      ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(),
            ),
          );
        },
        title: const Text('Profile',
            style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }

  Widget _buildToggleItem({
    required BuildContext context,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).primaryColor,
        activeTrackColor: const Color(0xFFF4C2C2),
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey.shade300,
      ),
    );
  }

  Widget _buildActionItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title),
        trailing: Icon(
          icon,
          color: iconColor,
        ),
        onTap: onTap,
      ),
    );
  }
}
