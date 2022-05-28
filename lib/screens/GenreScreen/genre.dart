
import 'package:flutter/material.dart';
import 'package:ip_movie_recomandation/widgets/my_button.dart';
import '../../widgets/my_box.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {

  showLoaderDialog(BuildContext context) {
    postGenres();
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
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
      decoration: const BoxDecoration(
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
                      const BoxShadow(
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      "What genre would you like to watch?",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: Text(
                      "Please choose at least 3 genres that you are interested in",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        spacing: 50,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              MyBox(text: 'Action', callbackFunction: (bool value ) {

                                button1IsPressed=value;

                              },),
                              MyBox(text: 'Comedy', callbackFunction: (bool value) {

                                button2IsPressed=value;
                              },),
                              MyBox(text: 'Drama', callbackFunction: (bool value) {

                                button3IsPressed=value;
                              },),
                              MyBox(text: 'Fantasy', callbackFunction: (bool value) {

                                button4IsPressed=value;
                              },),
                              const SizedBox(
                                width: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              MyBox(text: 'Romantic', callbackFunction: (bool value) {

                                button5IsPressed=value;
                              },),
                              MyBox(text: 'Scary', callbackFunction: (bool value) {

                                button6IsPressed=value;
                              },),
                              MyBox(text: 'Sci-Fi', callbackFunction: (bool value) {
                                button7IsPressed=value;
                              },),
                              const SizedBox(
                                width: 30,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
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
