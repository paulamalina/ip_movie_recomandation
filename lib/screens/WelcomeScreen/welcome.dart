import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Let\'s find a movie',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),),),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Center(child: SvgPicture.asset('images/welcome.svg')),
                ],
              ),
            ),
          ),
          Center(
            child: TextButton(
              // Within the `WelcomeScreen` widget
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/choose');
              },
              child: const Text('Get Started'),
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20,),
                primary: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}