import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ip_movie_recomandation/screens/RatingScreen/rating.dart';
import 'package:ip_movie_recomandation/widgets/MyButton.dart';

import '../../data/data.dart';
import '../../widgets/MyBox.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final pressAttention = ButtonStyle;

  double containerWidth = 800;
  double containerHeight = 800;
  bool isSmallScreen = false;
  bool isLargeScreen = true;

  String authToken = "";

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
    //Navigator.pushNamed(context, '/main');
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
                                  MyBox(text: 'Action'),
                                  MyBox(text: 'Comedy'),
                                  MyBox(text: 'Drama'),
                                  MyBox(text: 'Fantasy'),
                                  SizedBox(
                                    width: 30,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  MyBox(text: 'Romantic'),
                                  MyBox(text: 'Scary'),
                                  MyBox(text: 'Sci-Fi'),
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
                        buttonMethod: applyAndNavigateToRating,
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
