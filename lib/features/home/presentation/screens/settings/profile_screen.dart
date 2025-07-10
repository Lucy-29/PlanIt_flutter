import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // The AppBar from your design
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.appBarTheme.titleTextStyle?.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            children: [
              // Profile Image Section
              const CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage('https://i.pravatar.cc/150?u=lana'),
              ),
              TextButton.icon(
                onPressed: () {
                  print('Change image tapped');
                },
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('change image'),
                style: TextButton.styleFrom(
                  foregroundColor: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 30),

              // Form Fields Section
              _buildProfileTextField(
                label: 'username',
                initialValue: 'Lana Haidar',
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'email',
                initialValue: 'Lana.Haidar12@gmail.com',
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'password',
                initialValue: 'l199ohg0',
                isPassword: true,
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'phone number',
                initialValue: '+963 949 115 161',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 40),

              // Action Buttons Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9FB3B5), // A muted teal
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('DONE tapped');
                      Navigator.pop(context); // Go back for now
                    },
                    child: const Text('DONE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          theme.primaryColor, // Uses your primary theme color
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// A helper widget to build the labeled text fields consistently.
  Widget _buildProfileTextField({
    required String label,
    required String initialValue,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            // In light mode, this will be white-ish. In dark mode, dark grey.
            // This color should be defined in your ThemeData.
            // Using a hardcoded white for perfect replication of the image.
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: const Icon(Icons.edit, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF206173), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
