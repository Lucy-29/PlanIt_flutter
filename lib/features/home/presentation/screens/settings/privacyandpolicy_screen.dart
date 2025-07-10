import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              'Introduction',
              'Welcome to our Privacy Policy. Your privacy is critically important to us. This policy outlines how we collect, use, and protect your information.',
            ),
            _buildSection(
              context,
              'Information We Collect',
              'We collect the following types of information:\n\n'
                  '- Personally Identifiable Information: Name, Email, Phone Number, Profile Picture.\n'
                  '- Authentication Data: We store your password in a secure, hashed format.\n'
                  '- Usage Data: We may collect data on how you interact with our services to improve them.',
            ),
            _buildSection(
              context,
              'How We Use Your Information',
              'The information we collect is used to:\n\n'
                  '- Create and manage your account.\n'
                  '- Provide, maintain, and improve our services.\n'
                  '- Communicate with you, including for support and password resets.',
            ),
            _buildSection(
              context,
              'Data Security',
              'We are committed to protecting your data. We implement a variety of security measures to maintain the safety of your personal information. However, no method of transmission over the Internet is 100% secure.',
            ),
            _buildSection(
              context,
              'Contact Us',
              'If you have any questions about this Privacy Policy, please contact us at: PLANit@gmail.com',
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to make the sections look nice and consistent
  Widget _buildSection(BuildContext context, String title, String content) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
