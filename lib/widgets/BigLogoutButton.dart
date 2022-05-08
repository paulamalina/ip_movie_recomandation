import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigLogoutButton extends StatelessWidget {
  const BigLogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xffB5E48C),
          border: Border.all(color: Color(0xFF2B6086), width: 2),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/choose');
          },
          child: Text(
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