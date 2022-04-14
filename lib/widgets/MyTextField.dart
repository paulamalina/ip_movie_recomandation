import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final String text;
  final bool obscureText;
  final TextEditingController controller;
  const MyTextField({Key? key, required this.hintText, required this.text, this.obscureText=false, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: TextStyle(
          color: Color(0xFFB5E48C),
          fontSize: 25,
        ),),
        SizedBox(
          height: 5,
        ),
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: const Color(0xFFEDF8FF),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.yellow),
          ),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            maxLines: 1,
            controller: controller,
            obscureText: obscureText,
            cursorColor: const Color(0xFF34A0A4),
            style: TextStyle(
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF34A0A4),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
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
