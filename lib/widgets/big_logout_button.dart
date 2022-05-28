import 'package:flutter/material.dart';

class BigLogoutButton extends StatelessWidget {
  const BigLogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 50,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: const Color(0xFFCAEEE4),
          border: Border.all(color: const Color(0xFF2B6086), width: 2),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/choose');
          },
          child: const Text(
            'Log out',
            style: TextStyle(
              color: Color(0xFF1A759F),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ));
  }
}
