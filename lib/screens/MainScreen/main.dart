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
import 'package:carousel_slider/carousel_slider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<ImageButton> searchedList = [];
  List<ImageButton> recommendedList = [];
  List<ImageButton> rememberRecommended = [];
  String urlRecommandation = 'http://157.230.114.95:8090/api/v1/recommendation/';
  String urlSearch = 'http://157.230.114.95:8090/api/v1/movie/search/';

  int test = 0;
  List<Widget> CarouselItems = [];
  Widget MyCarousel = Container();
  bool isFinish = false;
  List<SearchedMovie> foundMovies = [];
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

  String authToken =
      "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJybWloYWxhY2hlQGdtYWlsLmNvbSIsImF1dGhvcml0aWVzIjpbeyJhdXRob3JpdHkiOiJtb3ZpZXM6cmVhZCJ9LHsiYXV0aG9yaXR5IjoiUk9MRV9VU0VSIn1dLCJpYXQiOjE2NTMxNDg0NTEsImV4cCI6MTY1NDMwMDgwMH0.07c60BOq7QjTZHVzuITSMSAZuoIlvOKyjVqrA-LB9PENNQnWe7ftbOc4rCMh71Hy601slCiwL4_XpOaYXOnU_w";

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

  void callRecommendGetter() {
    fetchRecommendedMovie(10);
    showLoaderDialog(context);
    setState(() {});
  }

  void callGenreGetter() {
    Navigator.pushNamed(context, '/main');
  }

  void callMovieGetter(String name) {
    fetchMovie(name);
    showLoaderDialog(context);
    setState(() {});
  }

  Future fetchRecommendedMovie(int number) async {
    final response = await http.get(
        Uri.parse(urlRecommandation +
            number.toString()),
        headers: {"Authorization": authToken});

    if (response.statusCode == 404) {
      test = 2;
      throw Exception("Error at fetching data!");
    } else if (response.statusCode == 200) {
      searchedList.clear();
      foundMovies = [];
      foundMovies = searchedMovieFromJson(response.body);
      if (foundMovies.length <= 0) {
        test = 2;
        throw Exception("Error at fetching data!");
      } else {
        populateList(recommendedList);
        return recommendedList;
      }
    } else {
      test = 2;
      throw Exception("Error at fetching data!");
    }
  }

  void fetchMovie(String name) async {
    final response = await http.get(
        Uri.parse(urlSearch + name),
        headers: {"Authorization": authToken});

    if (response.statusCode == 404) {
      test = 2;
    } else if (response.statusCode == 200) {
      test = 1;
      searchedList.clear();
      foundMovies = [];
      foundMovies = searchedMovieFromJson(response.body);
      if (foundMovies.length <= 0) {
        test = 2;
      } else {
        populateList(searchedList);
      }
    } else {
      test = 2;
      throw Exception("Error at fetching data!");
    }
  }

  Container manageContent() {
    if (test == 0) {
      return normalPrint();
    }
    if (test == 1) {
      return displayMovieReturned();
    }
    return noMovieReturned();
  }

  void populateList(List<ImageButton> buttonList) {
    for (int i = 0; i < foundMovies.length; i++) {
      buttonList.add(ImageButton(
          image: Image.asset("assets/images/image1.png"),
          text: foundMovies[i].name));
    }
  }

  Container displayMovieReturned() {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 40,
        children: searchedList,
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

  void initCarousel() {
    MyCarousel = Padding(
      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: CarouselSlider(
        items: CarouselItems,
        options: CarouselOptions(
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          viewportFraction: 0.3,
          height: 400,
          scrollDirection: Axis.horizontal,
        ),
        carouselController: CarouselController(),
      ),
    );
  }

  void initImages() {
    CarouselItems = rememberRecommended;
  }

  Container normalPrint() {
    if (!recommendedList.isEmpty) {
      return Container(
        child: MyCarousel,
      );
    } else {
      return Container(
          child: Wrap(alignment: WrapAlignment.center, spacing: 40, children: [
        FutureBuilder(
          future: fetchRecommendedMovie(10),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Text("Loading..."),
              );
            } else {
              rememberRecommended = snapshot.data as List<ImageButton>;
              initImages();
              initCarousel();
              return Container(
                child: MyCarousel,
              );
            }
          },
        )
      ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    setDimentions();
    if (!recommendedList.isEmpty) {
      initImages();
      initCarousel();
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color.fromRGBO(52, 160, 164, 1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Container(
              width: 60,
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/images/LogoSvg2.svg",
                  height: 100,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/main");
                },
              )
            ),

          actions: [
            isLargeScreen
                ? BigSearchField(
                    returnSearch: callMovieGetter,
                  )
                : SmallSearchField(
                    returnSearch: callMovieGetter,
                  ),
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
                    buttonMethod: callGenreGetter,
                  ))
                ),
                
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Comedy",
                    buttonMethod: callGenreGetter,
                  )),
                ),

                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Drama",
                    buttonMethod: callGenreGetter,
                  )),
                ),

                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Fantasy",
                    buttonMethod: callGenreGetter,
                  )),
                ),

                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Romantic",
                    buttonMethod: callGenreGetter,
                  )),
                ),
                
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Horror",
                    buttonMethod: callGenreGetter,
                  )),
                ),

                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Sci-Fi",
                    buttonMethod: callGenreGetter,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                        Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Color(0xFFCAEEE4),
                              border: Border.all(
                                  color: Color(0xFF2B6086), width: 2),
                            ),

                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/main");
                              },
                              child: Text(
                                "Watchlist",
                                style: const TextStyle(
                                  color: Color(0xFF1A759F),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),

                  Container(
                    height: 30,
                  ),
                  
                  Container(
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
