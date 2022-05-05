import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback buttonMethod;

  const MyButton({
    Key? key,
    required this.text,
    required this.buttonMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xffB5E48C),
          border: Border.all(color: Color(0xFF2B6086), width: 2),
        ),
        child: TextButton(
          onPressed: () {
            buttonMethod();
          },
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF1A759F),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ));
  }
}
