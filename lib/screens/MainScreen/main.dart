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

//CLICKABLE BUTTONS WITH IMAGES + NOTIF/PROFILE ? + BUTOANE IN LISTA
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

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Color(0xFF1A759F),
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
            child: Icon(Icons.notifications),
          ),
          SizedBox(width: 20),
          Container(
            child: IconButton(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              icon: const Icon(Icons.person),
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
        backgroundColor: Color(0xffB5E48C),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: Center(
                    child: const Text(
                  "Saved movies",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                )),
                textColor: Colors.white,
                //onTap: () {
                //},
              ),
              ListTile(
                title: Center(
                    child: const Text(
                  "For you",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                )),
                textColor: Color(0xFF1A759F),
              ),
              ListTile(
                title: Center(
                    child: const Text(
                  "Top rated",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                )),
                textColor: Colors.white,
              ),
              ListTile(
                title: Center(
                    child: const Text(
                  "Hidden gems",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                )),
                textColor: Colors.white,
              ),
              ListTile(
                title: Center(
                    child: const Text(
                  "Trending",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                )),
                textColor: Colors.white,
              ),
              ListTile(
                title: Center(
                    child: const Text(
                  "Classics",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                )),
                textColor: Colors.white,
              ),
              ListTile(
                title: Center(
                    child: const Text(
                  "~other options",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                )),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          SingleChildScrollView(
            controller: ScrollController(),
            child: Row(
              children: [
                Container(
                  width: 30,
                ),
                Column(
                  children: [
                    Container(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 125,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A759F),
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("For you",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          ToggleButton(),
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 1.25,
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                        color: Color(0xFF1A759F),
                        borderRadius: BorderRadius.circular(60.0),
                      ),
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
