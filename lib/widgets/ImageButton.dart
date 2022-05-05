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
          onLongPress: () {
            Navigator.pushNamed(context, '/details');
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xffB5E48C),
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                image,
                Text(text),
              ],
            ),
          ),
        ));
  }
}
