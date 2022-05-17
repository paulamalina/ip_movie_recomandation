import 'package:http/http.dart' as http;
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
import 'package:ip_movie_recomandation/widgets/MainGenreButton.dart';
import 'package:ip_movie_recomandation/models/searchedMovie.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int test = 0;
  bool isFinish = false;
  List<SearchedMovie> foundMovies = [];
  String foundMovieName = 'null';
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

  String authToken = "";

  showLoaderDialog(BuildContext context) {
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
            setState(() {
              isFinish = true;
            });
            Navigator.of(context).pop(true);
          });
          return alert;
        });
  }

  void testGenre() {
    Navigator.pushNamed(context, '/main');
  }

  void callMovieGetter(String name) {
    fetchMovie(name);
    showLoaderDialog(context);
    //final searchedMovie = searchedMovieFromJson(fetchMovie(name).toString());
    setState(() {});
    //test = 0;
  }

  void fetchMovie(String name) async {
    final response = await http.get(
        Uri.parse('http://157.230.114.95:8090/api/v1/movie/search/' + name),
        headers: {"Authorization": authToken});

    print(response.statusCode);
    if (response.statusCode == 404) {
      test = 2;
    } else if (response.statusCode == 200) {
      test = 1;
      foundMovies = searchedMovieFromJson(response.body);
      if (foundMovies.length <= 0) test = 2;
    } else {
      test = 2;
      throw Exception("Error at fetching data!");
    }
  }

  Container manageContent() {
    if (test == 0) return normalPrint();
    if (test == 1) return displayMovieReturned();
    return noMovieReturned();
  }

  List<ImageButton> foundMovieList = [];

  void populateList() {
    for (int i = 0; i < foundMovies.length; i++) {
      foundMovieList.add(ImageButton(
          image: Image.asset("assets/images/image1.png"),
          text: foundMovies[i].name));
    }
  }

  Container displayMovieReturned() {
    populateList();
    return Container(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 40,
        children: foundMovieList,
      ),
    );
  }

  Container noMovieReturned() {
    return Container(
      child: Column(children: [
        SizedBox(height: 80),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text("Nothing Found",
              style: const TextStyle(
                  color: Color(0xFFCAEEE4),
                  fontSize: 80,
                  fontWeight: FontWeight.w200)),
        ),
        SizedBox(height: 30),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text("Sorry, but nothing matched your search terms",
              style: const TextStyle(
                  color: Color(0xFFCAEEE4),
                  fontSize: 40,
                  fontWeight: FontWeight.w200)),
        ),
        SizedBox(height: 100),
      ]),
    );
  }

  Container normalPrint() {
    return Container(
        child: Wrap(alignment: WrapAlignment.center, spacing: 40, children: [
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
    ]));
  }

  @override
  Widget build(BuildContext context) {
    setDimentions();
    authToken = ModalRoute.of(context)!.settings.arguments as String;

    print("Main: $authToken");
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
            child: SvgPicture.asset(
              "assets/images/LogoSvg2.svg",
              height: 100,
            ),
            /*
            child: SvgPicture.asset(
              "assets/images/logoClean.svg",
            ),
            */
          ),
          actions: [
            isLargeScreen
                ? BigSearchField(
                    returnSearch: callMovieGetter,
                  )
                : SmallSearchField(),
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
                      child: MainGenreButton(
                    text: "Action",
                    buttonMethod: testGenre,
                  )),
                  //onTap: () {
                  //},
                ),
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Comedy",
                    buttonMethod: testGenre,
                  )),
                ),
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Drama",
                    buttonMethod: testGenre,
                  )),
                ),
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Fantasy",
                    buttonMethod: testGenre,
                  )),
                ),
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Romantic",
                    buttonMethod: testGenre,
                  )),
                ),
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Scary",
                    buttonMethod: testGenre,
                  )),
                ),
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Sci-Fi",
                    buttonMethod: testGenre,
                  )),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
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
                      //height: MediaQuery.of(context).size.height * 1.5,
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
                      child: manageContent()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
