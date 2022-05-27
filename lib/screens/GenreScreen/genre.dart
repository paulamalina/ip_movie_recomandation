import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ip_movie_recomandation/widgets/MyButton.dart';
import '../../data/data.dart';
import '../../widgets/MyBox.dart';
import 'package:http/http.dart' as http;

class GenreScreen extends StatefulWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {

  showLoaderDialog(BuildContext context) {
    postGenres();
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
            Navigator.pushNamed(context, '/rating');
          });
          return alert;
        });
  }
  
  
  final pressAttention = ButtonStyle;

  bool button1IsPressed=false;
  bool button2IsPressed=false;
  bool button3IsPressed=false;
  bool button4IsPressed=false;
  bool button5IsPressed=false;
  bool button6IsPressed=false;
  bool button7IsPressed=false;

  double containerWidth = 800;
  double containerHeight = 800;
  bool isSmallScreen = false;
  bool isLargeScreen = true;

  String authToken = "";


  void postGenre(int id) async{
    final Uri apiUrl = Uri.parse("http://157.230.114.95:8090/api/v1/genre/reviews");

    final response= await http.post(
        apiUrl,
        body: jsonEncode({
          "id": "$id"
        }),
        headers: {
          "Authorization" : token,
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
          "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type": "application/json",
    });
    if(response.statusCode==201){
      print("binee");
    }else{
      print(response.statusCode);
    }
  }

  void postGenres(){
    if(button1IsPressed){
      postGenre(1);
    }
    if(button2IsPressed){
      postGenre(2);
    }
    if(button3IsPressed){
      postGenre(3);
    }
    if(button4IsPressed){
      postGenre(4);
    }
    if(button5IsPressed){
      postGenre(5);
    }
    if(button6IsPressed){
      postGenre(6);
    }
    if(button7IsPressed){
      postGenre(7);
    }
  }

  void setValue() {
    if (MediaQuery.of(context).size.width >= 700) {
      setState(() {
        containerWidth = 800;
        containerHeight = 800;
        isSmallScreen = false;
        isLargeScreen = true;
      });
    } else {
      setState(() {
        containerWidth = double.infinity;
        containerHeight = double.infinity;
        isSmallScreen = true;
        isLargeScreen = false;
      });
    }
  }

  void navigateToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  void applyAndNavigateToRating() {
    Navigator.pushNamed(context, '/rating');
  }

  void postPrefGenre(){

  }

  @override
  Widget build(BuildContext context) {
    setValue();

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 7,
          )
        ],
        gradient: LinearGradient(
            colors: [Colors.white, Color.fromRGBO(52, 160, 164, 1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, //
        body: Center(
          child: Container(
            width: containerWidth,
            height: containerHeight,
            decoration: BoxDecoration(
              boxShadow: isLargeScreen
                  ? [
                      BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
              borderRadius: isLargeScreen ? BorderRadius.circular(50.0) : null,
              color: Colors.teal,
            ),
            child: ListView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "What genre would you like to watch?",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      "Please choose at least 3 genres that you are interested in",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          spacing: 50,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  MyBox(text: 'Action', CallbackFunction: (bool value ) {
                                    print("Action : $value");
                                    button1IsPressed=value;

                                  },),
                                  MyBox(text: 'Comedy', CallbackFunction: (bool value) {
                                    print("Comedy : $value");
                                    button2IsPressed=value;
                                  },),
                                  MyBox(text: 'Drama', CallbackFunction: (bool value) {
                                    print("Drama : $value");
                                    button3IsPressed=value;
                                  },),
                                  MyBox(text: 'Fantasy', CallbackFunction: (bool value) {
                                    print("Fantasy : $value");
                                    button4IsPressed=value;
                                  },),
                                  SizedBox(
                                    width: 30,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  MyBox(text: 'Romantic', CallbackFunction: (bool value) {
                                    print("Romantic : $value");
                                    button5IsPressed=value;
                                  },),
                                  MyBox(text: 'Scary', CallbackFunction: (bool value) {
                                    print("Scary : $value");
                                    button6IsPressed=value;
                                  },),
                                  MyBox(text: 'Sci-Fi', CallbackFunction: (bool value) {
                                    print("SF : $value");
                                    button7IsPressed=value;
                                  },),
                                  SizedBox(
                                    width: 30,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyButton(
                        text: "Back",
                        buttonMethod: navigateToRegister,
                      ),
                      MyButton(
                        text: "Next",
                        buttonMethod: (){
                          showLoaderDialog(context);
                          //applyAndNavigateToRating();
                        },
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
