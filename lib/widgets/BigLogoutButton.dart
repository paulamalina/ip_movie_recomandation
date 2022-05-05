import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigLogoutButton extends StatelessWidget {
  const BigLogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/choose');
      },
      child: Text(
        'Log out',
        style: TextStyle(
          color: Color(0xFF1A759F),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
