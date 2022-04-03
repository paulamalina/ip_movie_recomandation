import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN SCREEN'),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the `WelcomeScreen` widget
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/main');
          },
          child: const Text('go ahead'),
        ),
      ),
    );
  }
}