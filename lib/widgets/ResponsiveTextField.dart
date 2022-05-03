import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResponsiveTextField extends StatelessWidget {
  final String hintText;
  final String text;
  final bool obscureText;
  final double height;
  final double width;
  final TextEditingController controller;
  const ResponsiveTextField(
      {Key? key,
      required this.height,
      required this.width,
      required this.hintText,
      required this.text,
      this.obscureText = false,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: FittedBox(
              child: Text(
            text,
            style: TextStyle(
              color: Color(0xFFB5E48C),
            ),
          )),
          height: height * 0.3,
        ),
        SizedBox(
          height: height * 0.1,
        ),
        Container(
          width: width,
          height: height * 0.6,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 214, 254, 255),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Color(0xFFB5E48C)),
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
