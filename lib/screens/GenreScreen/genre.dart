import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ip_movie_recomandation/request/model.dart';
import 'package:ip_movie_recomandation/widgets/MyTextField.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/MyBox.dart';
import '../../widgets/MyTextField.dart';

 import 'package:flutter/material.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}
class _GenreScreenState extends State<GenreScreen>{
  final pressAttention = ButtonStyle;


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xff34A0A4), //
      appBar: AppBar(
        backgroundColor: Color(0xff1A759F),
        // child: Center(
        //   child: Image.asset('assets/images/logo.png',  width: 100, height: 50,),
        // ),
      ),
      
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: 
            Text("What genre would you like to watch?", style: TextStyle(fontSize: 30, color: Colors.white),),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: 
            Text("Please choose at least 3 genres that you are interested in", style: TextStyle(fontSize: 15, color: Colors.white),),
          ),
          SizedBox(
            height: 50,
          ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                MyBox(text: 'Action'),
                MyBox(text: 'Animation'),
                MyBox(text: 'Comedy'),
                MyBox(text: 'Crime'),
              ],
            ),
            SizedBox(
              width: 50,
             ),
            Column(
              children: [
                MyBox(text: 'Drama'),
                MyBox(text: 'Family'),
                MyBox(text: 'Horror'),
                MyBox(text: 'Sci-Fi'),
              ],
            ),
            SizedBox(
              height: 30,
             ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
              width: 250,
              height: 60,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xff168AAD),
              ),
              child: TextButton( 
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Exit',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ),
          SizedBox(
            width: 800,
          ),
          Container(
              width: 250,
              height: 60,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xff168AAD),
              ),
              child: TextButton( 
                onPressed: () {
                  Navigator.pushNamed(context, "/main");
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ),
        ],)

      ]),
      );
      }
}