import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


import '../../widgets/MyBox.dart';


class GenreScreen extends StatefulWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}
class _GenreScreenState extends State<GenreScreen>{
  final pressAttention = ButtonStyle;

  double containerWidth=800;
  double containerHeight=800;
  bool isSmallScreen=false;
  bool isLargeScreen=true;
  void setValue(){
    if(MediaQuery.of(context).size.width >= 700){
      setState(() {
        containerWidth=800;
        containerHeight=800;
        isSmallScreen=false;
        isLargeScreen=true;
      });
    }else{
      setState(() {
        containerWidth=double.infinity;
        containerHeight=double.infinity;
        isSmallScreen=true;
        isLargeScreen=false;

      });
    }
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
        gradient: LinearGradient(colors: [
          Colors.white, Color.fromRGBO(52, 160, 164, 1)
        ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor:Colors.transparent, //
        body: Center(
          child: Container(
            width: containerWidth,
            height: containerHeight,
            decoration: BoxDecoration(
              boxShadow: isLargeScreen ? [
                BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 2,
                )
              ] : null,
              borderRadius: isLargeScreen ? BorderRadius.circular(50.0) : null,
              color: Colors.teal,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Container(
                      width: 150,
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
                  Container(
                      width: 150,
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
                          Navigator.pushNamed(context, "/rating");
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
                ],),
              )

            ]),
          ),
        ),
        ),
    );
      }
}