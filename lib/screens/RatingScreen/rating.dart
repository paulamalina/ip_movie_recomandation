import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ip_movie_recomandation/widgets/MyButton.dart';
import '../../data/data.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart' as http;


class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double containerWidth = 700;
  double containerHeight = 850;
  bool isSmallScreen = false;
  bool isLargeScreen = true;

  String image1="";
  String image2="";
  String image3="";
  String image4="";
  String image5="";

  List<String> thumbnailLink=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void function() {
    if (globals.Index == 0) {
      globals.image = image1;
      globals.Index++;
    } else if (globals.Index == 1) {
      globals.image = image2;
      globals.Index++;
    } else if (globals.Index == 2) {
      globals.image = image3;
      globals.Index++;
    } else if (globals.Index == 3) {
      globals.image = image4;
      globals.Index++;
    } else if (globals.Index == 4) {
      globals.image = image5;
      globals.redirect = "/main";
      globals.Index++;
    }
  }

  Future getMovies() async {
    final Uri apiUrl =
        Uri.parse("http://157.230.114.95:8090/api/v1/movies");
    final response = await http.get(apiUrl, headers: {
      "Authorization": token,
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      "Content-Type": "application/json"
    });

    print(response.statusCode);

    List data=jsonDecode(response.body);

    if(response.statusCode==200){
      print(data.length);
      // for(int i=0;i<data.length;i++){
      //   print(data[i]["thumbnailLink"]);
      //   thumbnailLink[i]=data[i]["thumbnailLink"];
      // }
      image1=data[0]["thumbnailLink"];
      image2=data[1]["thumbnailLink"];
      image3=data[2]["thumbnailLink"];
      image4=data[3]["thumbnailLink"];
      image5=data[4]["thumbnailLink"];
      function();
      print("data");
      return data;
    }

  }

  void navigateToRating() {
    Navigator.pushNamed(context, globals.redirect);
  }

  void goToMain() {
    Navigator.pushNamed(
      context,
      '/main'
    );
  }

  void reduceIndex() {
    globals.Index--;
  }

  void setValue() {
    if (MediaQuery.of(context).size.width >= 700) {
      setState(() {
        containerWidth = 700;
        containerHeight = 850;
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
        backgroundColor: Colors.transparent,
        body:       FutureBuilder(
          future: getMovies(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: SizedBox(
                  width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                ),
              );
            } else {
              print("aoco");
              print(globals.image);
              return Center(
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
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          child: Stack(
                            children: [
                              Center(
                                child: Align(
                                  alignment: FractionalOffset(0.5, 0.1),
                                  //child: Image.asset(globals.image),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 50, bottom: 20),
                                    child: Image.network(
                                      globals.image,
                                      width: 400,
                                      height: 450,
                                      headers: {
                                      "Authorization" : token
                                    },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  spacing: 20,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.0),
                                        color: Color.fromARGB(255, 202, 238, 228),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, globals.redirect);
                                        },
                                        child: Text(
                                          'Awful',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.0),
                                        color: Color.fromARGB(255, 181, 238, 228),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, globals.redirect);
                                        },
                                        child: Text(
                                          'Average',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  spacing: 20,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.0),
                                        color: Color.fromARGB(255, 128, 239, 216),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, globals.redirect);
                                        },
                                        child: Text(
                                          'Good',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.0),
                                        color: Color.fromARGB(255, 51, 233, 196),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, globals.redirect);
                                        },
                                        child: Text(
                                          'Amazing',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              child: MyButton(
                                text: 'Skip',
                                buttonMethod: () {
                                  Navigator.pushNamed(context, globals.redirect);
//getImage();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
