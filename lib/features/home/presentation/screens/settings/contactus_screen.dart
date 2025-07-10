import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'PLANit@gmail.com',
      // query: 'subject=App Support&body=Hi, I need help with...',
    );
    await launchUrl(emailLaunchUri);
  }

  void _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+1234567890');
    await launchUrl(phoneUri);
  }

  // void _launchWebsite() async {
  //   final Uri websiteUri = Uri.parse('https://yourwebsite.com/contact');
  //   await launchUrl(websiteUri);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('PLANit@gmail.com'),
              onTap: _launchEmail,
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone'),
              subtitle: const Text('+1 234 567 890'),
              onTap: _launchPhone,
            ),
            // ListTile(
            //   leading: const Icon(Icons.language),
            //   title: const Text('Website'),
            //   subtitle: const Text('www.yourwebsite.com'),
            //   onTap: _launchWebsite,
            // ),
          ],
        ),
      ),
    );
  }
}
