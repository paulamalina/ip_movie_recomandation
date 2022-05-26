import 'package:flutter/material.dart';
import 'package:ip_movie_recomandation/data/data.dart';
import 'package:ip_movie_recomandation/screens/MovieDetailsScreen/details.dart';

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
        child: Container(
            width: 300,
            decoration: BoxDecoration(
                color: Color(0xFFCAEEE4),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Color(0xFF2B6086), width: 2)),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    titleText=text;
                    Navigator.pushNamed(context, '/details');
                  },
                  icon: image,
                  iconSize: 250,
                ),
                Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1A759F),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            )));
  }
}
