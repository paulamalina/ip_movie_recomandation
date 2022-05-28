import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback buttonMethod;
  final TextStyle textStyle;
  final double width;
  final double height;
   const MyButton({
    Key? key,
    required this.text,
    required this.buttonMethod,
    this.textStyle=const TextStyle(
      color: Color(0xFF1A759F),
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ), this.width=125, this.height=50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: const Color(0xFFCAEEE4),
          border: Border.all(color: const Color(0xFF2B6086), width: 2),
        ),
        child: TextButton(
          onPressed: () {
            buttonMethod();
          },
          child: Text(
            text,
            style: textStyle
          ),
        ));
  }
}
