import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the `WelcomeScreen` widget
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pop(context);
          },
          child: const Text('go back'),
        ),
      ),
    );
  }
}