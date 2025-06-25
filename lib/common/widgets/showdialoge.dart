import 'package:flutter/material.dart';
import 'package:ems_1/common/widgets/customtextformfield.dart';

class Showdialoge extends StatefulWidget {
  final String email;
  const Showdialoge({required this.email, super.key});
  @override
  State<StatefulWidget> createState() => ShowdialogeState();
}

class ShowdialogeState extends State<Showdialoge> {
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Center(
        child: Text(
          'Enter OTP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('OTP Code Sent to \n  ${widget.email}'),
            SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              controller: otpController,
              hintText: '6 Digit Code',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter OTP Code';
                }
                if (value.length < 6) {
                  return 'OTP must be at least 6 digits';
                }
                return null;
              },
            )
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF50C878)),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop(otpController.text.trim());
              }
            },
            child: Text(
              'Verify',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
