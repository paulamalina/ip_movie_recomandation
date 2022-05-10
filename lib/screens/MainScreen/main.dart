import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/widgets.dart';
import 'package:ip_movie_recomandation/widgets/BigLogoutButton.dart';
import 'package:ip_movie_recomandation/widgets/BigSearchField.dart';
import 'package:ip_movie_recomandation/widgets/ImageButton.dart';
import 'package:ip_movie_recomandation/widgets/Toggle.dart';
import 'package:ip_movie_recomandation/widgets/SmallLogoutButton.dart';
import 'package:ip_movie_recomandation/widgets/SmallSearchField.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLargeScreen = true;
  double imgWidth = 300;
  double imgHeight = 250;

  void setDimentions() {
    if (MediaQuery.of(context).size.width <= 700) {
      setState(() {
        isLargeScreen = false;
      });
    } else {
      setState(() {
        isLargeScreen = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setDimentions();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          /*
          colors: [
            Colors.white,
            Color(0xFF99D98C),
          ],
          */
          colors: [Colors.white, Color.fromRGBO(52, 160, 164, 1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          //backgroundColor: Color(0xFF1A759F),
          backgroundColor: Colors.teal,
          title: Container(
            width: 60,
            child: Image.asset(
              "assets/images/logo.png",
            ),
            /*
            child: SvgPicture.asset(
              "assets/images/logoClean.svg",
            ),
            */
          ),
          actions: [
            isLargeScreen ? BigSearchField() : SmallSearchField(),
            SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Icon(
                Icons.notifications,
                color: Color(0xFFCAEEE4),
              ),
            ),
            SizedBox(width: 20),
            Container(
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                icon: const Icon(
                  Icons.person,
                 color: Color(0xFFCAEEE4),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/changeProfile');
                },
              ),
            ),
            SizedBox(width: 20),
            isLargeScreen ? BigLogoutButton() : SmallLogoutButton(),
            Container(
              width: 40,
              height: 40,
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.teal,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  title: Center(
                      child: const Text(
                    "Saved",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                  )),
                  textColor: Color(0xFFCAEEE4),
                  //onTap: () {
                  //},
                ),
                ListTile(
                  title: Center(
                      child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Color(0xFFCAEEE4),
                      border: Border.all(color: Color(0xFF2B6086), width: 2),
                    ),
                    child: Center(
                      child: const Text(
                        "For you",
                        style: const TextStyle(
                          color: Color(0xFF1A759F),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )),
                  textColor: Color(0xFFCAEEE4),
                ),
                ListTile(
                  title: Center(
                      child: const Text(
                    "Top rated",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                  )),
                  textColor: Color(0xFFCAEEE4),
                ),
                ListTile(
                  title: Center(
                      child: const Text(
                    "Hidden gems",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                  )),
                  textColor: Color(0xFFCAEEE4),
                ),
                ListTile(
                  title: Center(
                      child: const Text(
                    "Trending",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                  )),
                  textColor: Color(0xFFCAEEE4),
                ),
                ListTile(
                  title: Center(
                      child: const Text(
                    "Classics",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                  )),
                  textColor: Color(0xFFCAEEE4),
                ),
                ListTile(
                  title: Center(
                      child: const Text(
                    "~other options",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                  )),
                  textColor: Color(0xFFCAEEE4),
                ),
              ],
            ),
          ),
        ),
        body: 
            SingleChildScrollView(
              controller: ScrollController(),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.025,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 125,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(50.0),
                          boxShadow: [
                         BoxShadow(
                          blurRadius: 7,
                           spreadRadius: 2,
                        )
                      ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(30.0),
                              child: BorderedText(
                                strokeWidth: 4.0,
                                strokeColor: Color(0xFF2B6086),
                                child: Text("For you",
                                    style: TextStyle(
                                        color: Color(0xFFCAEEE4),
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            ToggleButton(),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 1.5,
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7,
                           spreadRadius: 2,
                        )
                      ],
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 40,
                              children: [
                                ImageButton(
                                  text: "film1",
                                  image: Image.asset(
                                    "assets/images/image1.png",
                                    width: imgWidth,
                                    height: imgHeight,
                                  ),
                                ),
                                ImageButton(
                                  text: "film2",
                                  image: Image.asset(
                                    "assets/images/image1.png",
                                    width: imgWidth,
                                    height: imgHeight,
                                  ),
                                ),
                                ImageButton(
                                  text: "film3",
                                  image: Image.asset(
                                    "assets/images/image1.png",
                                    width: imgWidth,
                                    height: imgHeight,
                                  ),
                                ),
                                ImageButton(
                                  text: "film4",
                                  image: Image.asset(
                                    "assets/images/image1.png",
                                    width: imgWidth,
                                    height: imgHeight,
                                  ),
                                ),
                                ImageButton(
                                  text: "film5",
                                  image: Image.asset(
                                    "assets/images/image1.png",
                                    width: imgWidth,
                                    height: imgHeight,
                                  ),
                                ),
                                ImageButton(
                                  text: "film6",
                                  image: Image.asset(
                                    "assets/images/image1.png",
                                    width: imgWidth,
                                    height: imgHeight,
                                  ),
                                ),
                                ImageButton(
                                  text: "film7",
                                  image: Image.asset(
                                    "assets/images/image1.png",
                                    width: imgWidth,
                                    height: imgHeight,
                                  ),
                                ),
                                ImageButton(
                                  text: "film8",
                                  image: Image.asset(
                                    "assets/images/image1.png",
                                    width: imgWidth,
                                    height: imgHeight,
                                  ),
                                ),
                                ImageButton(
                                  text: "film9",
                                  image: Image.asset(
                                    "assets/images/image1.png",
                                    width: imgWidth,
                                    height: imgHeight,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ),
      
    );
  }
}
