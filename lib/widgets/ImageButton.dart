import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String text;
  final Image image;
  const ImageButton({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/details');
          },
          child: Container(
            decoration: BoxDecoration(      
              color: Color(0xFFCAEEE4),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Color(0xFF2B6086), width: 2),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                image,
                Text(
                  text,
                  style: TextStyle(
                    color: Color(0xFF1A759F),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
