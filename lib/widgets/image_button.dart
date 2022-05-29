import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ip_movie_recomandation/data/data.dart';
import 'package:http/http.dart' as http;

class ImageButton extends StatefulWidget {
  final String text;
  final Image image;

  ImageButton({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  void getDetailsForMovie() async {
    final Uri apiUrl = Uri.parse(
        "http://157.230.114.95:8090/api/v1/movies/search/name/" + titleText);
    final response = await http.get(apiUrl, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      "Content-Type": "application/json",
      "Authorization": token
    });
    List data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (int i = 0; i < data.length; i++) {
        if (data[i]["name"] == titleText) {
          trailerLink = data[i]["trailerLink"];
          movieLink = data[i]["movieLink"];
          break;
        }
      }
    }
  }

  bool x = false;

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 500), () {
            getDetailsForMovie();
          });
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
            Navigator.pushNamed(context, '/details');
          });
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Container(
            width: 300,
            height: 350,
            decoration: BoxDecoration(
                color: const Color(0xFFCAEEE4),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFF2B6086), width: 2)),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                  onPressed: () {
                    titleText = widget.text;
                    showLoaderDialog(context);
                  },
                  icon: widget.image,
                  iconSize: 250,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(widget.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF1A759F),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                )
              ],
            )));
  }
}
