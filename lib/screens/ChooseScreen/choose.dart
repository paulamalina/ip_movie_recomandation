import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF34A0A4), //
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 100,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Color(0xFFCAEEE4),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
                child: Text(
                  'Log in',
                  style: TextStyle(
                    color: Color(0xFF1A759F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Color(0xFFCAEEE4),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/register");
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Color(0xFF1A759F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Color(0xFFCAEEE4),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: Color(0xFF1A759F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
