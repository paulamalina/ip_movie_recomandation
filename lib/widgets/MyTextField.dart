import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final String text;
  final bool obsureText;
  const MyTextField({Key? key, required this.hintText, required this.text, this.obsureText=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEDF8FF),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color.fromRGBO(162, 215, 255, 1)),
          ),
          child: TextField(
            obscureText: obsureText,
            cursorColor: const Color(0xFF1F3969),
            style: TextStyle(
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1F3969),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hintStyle: const TextStyle(
                color: Color(0xFFBBBFC2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
