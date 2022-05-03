import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ip_movie_recomandation/widgets/Toggle.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Container(
            width: 200,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Color(0xffB5E48C),
            ),
            child: Center(
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF1A759F).withOpacity(0.5), width: 2),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A759F).withOpacity(0.5),
                    ),
                    hintText: "Search",
                    suffixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF1A759F).withOpacity(0.5),
                    ),
                  ),
                )),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Icon(Icons.notifications),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/changeProfile');
              },
            ),
          ),
          Container(
            width: 130,
            height: 40,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Color(0xffB5E48C),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/choose');
              },
              child: Text(
                'Log out',
                style: TextStyle(
                  color: Color(0xFF1A759F),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
          ),
        ],
      ),
      body: Row(
        children: [
          Drawer(
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
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                        )),
                    textColor: Colors.white,
                    //onTap: () {
                    //},
                  ),
                  ListTile(
                    title: Center(
                        child: const Text(
                          "For you",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                        )),
                    textColor: Color(0xFF1A759F),
                  ),
                  ListTile(
                    title: Center(
                        child: const Text(
                          "Top rated",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                        )),
                    textColor: Colors.white,
                  ),
                  ListTile(
                    title: Center(
                        child: const Text(
                          "Hidden gems",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                        )),
                    textColor: Colors.white,
                  ),
                  ListTile(
                    title: Center(
                        child: const Text(
                          "Trending",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                        )),
                    textColor: Colors.white,
                  ),
                  ListTile(
                    title: Center(
                        child: const Text(
                          "Classics",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                        )),
                    textColor: Colors.white,
                  ),
                  ListTile(
                    title: Center(
                        child: const Text(
                          "~other options",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                        )),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Row(
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
                    width: 350,
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
                    height: 500,
                    width: 1000,
                    decoration: BoxDecoration(
                      color: Color(0xFF1A759F),
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}  
