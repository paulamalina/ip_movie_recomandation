import 'package:flutter/material.dart';

class MainGenreButton extends StatelessWidget {
  final String text;
  final VoidCallback buttonMethod;

  const MainGenreButton({
    Key? key,
    required this.text,
    required this.buttonMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 125,
        height: 50,
        child: TextButton(
          onPressed: () {
            buttonMethod();
          },
          child: Text(
            text,
            style: const TextStyle(
                color: Color(0xFFCAEEE4),
                fontSize: 20,
                fontWeight: FontWeight.w200),
          ),
        ));
  }
}
