import 'package:flutter/material.dart';

class TermsandconditionsScreen extends StatelessWidget {
  const TermsandconditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              'Acceptance of Terms',
              'By accessing or using this app, you agree to be bound by these Terms and Conditions. If you do not agree, please do not use the app.',
            ),
            _buildSection(
              context,
              'Use of the App',
              'You agree to use the app only for lawful purposes. You are responsible for any content you post or share, and you must not engage in any activity that is harmful, fraudulent, or violates any law.',
            ),
            _buildSection(
              context,
              'Accounts and Security',
              'You are responsible for maintaining the confidentiality of your account and password. We are not liable for any loss or damage from your failure to comply with this security obligation.',
            ),
            // _buildSection(
            //   context,
            //   'Intellectual Property',
            //   'All content, features, and functionality are owned by the app developers and protected by copyright and other laws. You may not reproduce, distribute, or create derivative works without permission.',
            // ),
            _buildSection(
              context,
              'Termination',
              'We reserve the right to suspend or terminate your access to the app at our sole discretion, without notice, if we believe you have violated these terms.',
            ),
            _buildSection(
              context,
              'Disclaimer of Warranties',
              'The app is provided "as is" without warranties of any kind. We do not guarantee that the app will be secure, error-free, or available at all times.',
            ),
            _buildSection(
              context,
              'Limitation of Liability',
              'We are not liable for any damages or losses resulting from your use or inability to use the app.',
            ),
            _buildSection(
              context,
              'Changes to Terms',
              'We may update these Terms and Conditions from time to time. Continued use of the app after any changes indicates your acceptance of the new terms.',
            ),
            _buildSection(
              context,
              'Contact Us',
              'If you have any questions about these Terms and Conditions, please contact us at: PLANit@gmail.com',
            ),
          ],
        ),
      ),
    );
  }

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
