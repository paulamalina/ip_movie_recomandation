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
  List<ImageButton> genreListLeft = [];
  List<ImageButton> recommendedList = [];
  List<ImageButton> rememberRecommended = [];

  int test = 0;
  int carouselMaxNumber = 10;
  String headerText = "For you";
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

  void callGenreGetter(String genre) {
    fetchVoidGenreMovie(genre);
    showLoaderDialog(context);
    setState(() {});
  }

  void callMovieGetter(String name) {
    fetchMovie(name);
    showLoaderDialog(context);
    setState(() {});
  }

  void fetchVoidGenreMovie(String genre) async {
    final response = await http.get(
        Uri.parse(
            'http://157.230.114.95:8090/api/v1/movies/search/genre/' + genre),
        headers: {"Authorization": authToken});

    if (response.statusCode == 404) {
      test = 2;
      throw Exception("Error at fetching data!");
    } else if (response.statusCode == 200) {
      headerText = genre;
      genreListLeft.clear();
      foundMovies = [];
      foundMovies = searchedMovieFromJson(response.body);
      if (foundMovies.length <= 0) {
        test = 2;
        throw Exception("Error at fetching data!");
      } else {
        test = 3;
        for (int i = 0; i < foundMovies.length; i++) {
          genreListLeft.add(ImageButton(
              image: Image.asset("assets/images/image1.png"),
              text: foundMovies[i].name));
        }
      }
    } else {
      test = 2;
      throw Exception("Error at fetching data!");
    }
  }

  Future fetchGenreMovie(String genre) async {
    final response = await http.get(
        Uri.parse(
            'http://157.230.114.95:8090/api/v1/movies/search/genre/' + genre),
        headers: {"Authorization": authToken});

    if (response.statusCode == 404) {
      throw Exception("Error at fetching data!");
    } else if (response.statusCode == 200) {
      List<SearchedMovie> genreList = searchedMovieFromJson(response.body);
      if (genreList.length <= 0) {
        throw Exception("Error at fetching data!");
      } else {
        return genreList;
      }
    } else {
      throw Exception("Error at fetching data!");
    }
  }

  Future fetchRecommendedMovie(int number) async {
    final response = await http.get(
        Uri.parse('http://157.230.114.95:8090/api/v1/recommendation/' +
            number.toString()),
        headers: {"Authorization": authToken});

    if (response.statusCode == 404) {
      throw Exception("Error at fetching data!");
    } else if (response.statusCode == 200) {
      searchedList.clear();
      foundMovies = [];
      foundMovies = searchedMovieFromJson(response.body);
      if (foundMovies.length <= 0) {
        throw Exception("Error at fetching data!");
      } else {
        populateList(recommendedList);
        return recommendedList;
      }
    } else {
      throw Exception("Error at fetching data!");
    }
  }

  void fetchMovie(String name) async {
    final response = await http.get(
        Uri.parse(
            'http://157.230.114.95:8090/api/v1/movies/search/name/' + name),
        headers: {"Authorization": authToken});
    if (response.statusCode == 404) {
      test = 2;
    } else if (response.statusCode == 200) {
      test = 1;
      headerText = "Search results";
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
    if (test == 2) {
      return noMovieReturned();
    }
    return displayGenreMovie();
  }

  void populateList(List<ImageButton> buttonList) {
    for (int i = 0; i < foundMovies.length; i++) {
      buttonList.add(ImageButton(
          image: Image.asset("assets/images/image1.png"),
          text: foundMovies[i].name));
    }
  }

  Container displayGenreMovie() {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 40,
        children: genreListLeft,
      ),
    );
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

  Widget initGenreCarousel(List<SearchedMovie> genreMovies) {
    Widget Carousel = Container();
    List<Widget> Items = [];
    List<ImageButton> Images = [];

    //Populate list
    for (int i = 0; i < genreMovies.length && i < carouselMaxNumber; i++) {
      Images.add(ImageButton(
          image: Image.asset("assets/images/image1.png"),
          text: genreMovies[i].name));
    }
    //Init Carousel
    Items = Images;
    Carousel = Padding(
      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: CarouselSlider(
        items: Items,
        options: CarouselOptions(
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          viewportFraction: MediaQuery.of(context).size.width > 800 ? 0.3 : 1,
          height: 400,
          scrollDirection: Axis.horizontal,
        ),
        carouselController: CarouselController(),
      ),
    );

    return Carousel;
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
          viewportFraction: MediaQuery.of(context).size.width > 800 ? 0.3 : 1,
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
    return Container(
        child: Wrap(alignment: WrapAlignment.center, spacing: 40, children: [
      FutureBuilder(
        future: fetchRecommendedMovie(carouselMaxNumber),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: null,
            );
          } else {
            rememberRecommended = snapshot.data as List<ImageButton>;
            initImages();
            initCarousel();
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Recommended Movies",
                    style: TextStyle(
                        color: Color(0xFFCAEEE4),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  MyCarousel,
                ],
              ),
            );
          }
        },
      ),
      FutureBuilder(
        future: fetchGenreMovie("Action"),
        builder: (context, snapshotAction) {
          if (snapshotAction.data == null) {
            return Container(
              child: null,
            );
          } else {
            Widget CarouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Action",
                    style: TextStyle(
                        color: Color(0xFFCAEEE4),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  CarouselGenreChild,
                ],
              ),
            );
          }
        },
      ),
      FutureBuilder(
        future: fetchGenreMovie("Comedy"),
        builder: (context, snapshotAction) {
          if (snapshotAction.data == null) {
            return Container(
              child: null,
            );
          } else {
            Widget CarouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Comedy",
                    style: TextStyle(
                        color: Color(0xFFCAEEE4),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  CarouselGenreChild,
                ],
              ),
            );
          }
        },
      ),
      FutureBuilder(
        future: fetchGenreMovie("Drama"),
        builder: (context, snapshotAction) {
          if (snapshotAction.data == null) {
            return Container(
              child: null,
            );
          } else {
            Widget CarouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Drama",
                    style: TextStyle(
                        color: Color(0xFFCAEEE4),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  CarouselGenreChild,
                ],
              ),
            );
          }
        },
      ),
      FutureBuilder(
        future: fetchGenreMovie("Fantasy"),
        builder: (context, snapshotAction) {
          if (snapshotAction.data == null) {
            return Container(
              child: null,
            );
          } else {
            Widget CarouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Fantasy",
                    style: TextStyle(
                        color: Color(0xFFCAEEE4),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  CarouselGenreChild,
                ],
              ),
            );
          }
        },
      ),
      FutureBuilder(
        future: fetchGenreMovie("Romantic"),
        builder: (context, snapshotAction) {
          if (snapshotAction.data == null) {
            return Container(
              child: null,
            );
          } else {
            Widget CarouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Romantic",
                    style: TextStyle(
                        color: Color(0xFFCAEEE4),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  CarouselGenreChild,
                ],
              ),
            );
          }
        },
      ),
      FutureBuilder(
        future: fetchGenreMovie("Scary"),
        builder: (context, snapshotAction) {
          if (snapshotAction.data == null) {
            return Container(
              child: null,
            );
          } else {
            Widget CarouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Horror",
                    style: TextStyle(
                        color: Color(0xFFCAEEE4),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  CarouselGenreChild,
                ],
              ),
            );
          }
        },
      ),
      FutureBuilder(
        future: fetchGenreMovie("Sci-Fi"),
        builder: (context, snapshotAction) {
          if (snapshotAction.data == null) {
            return Container(
              child: null,
            );
          } else {
            Widget CarouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sci-Fi",
                    style: TextStyle(
                        color: Color(0xFFCAEEE4),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  CarouselGenreChild,
                ],
              ),
            );
          }
        },
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    setDimentions();
    if (!recommendedList.isEmpty) {
      initImages();
      initCarousel();
    }
    //authToken = ModalRoute.of(context)!.settings.arguments as String;

    //print("Main: $authToken");
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
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/images/LogoSvg2.svg",
                  height: 100,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/main");
                },
              )
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
                : SmallSearchField(
                    returnSearch: callMovieGetter,
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
                    buttonMethod: () {
                      callGenreGetter("Action");
                    },
                  )),
                  //onTap: () {
                  //},
                ),
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Comedy",
                    buttonMethod: () {
                      callGenreGetter("Comedy");
                    },
                  )),
                ),
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Drama",
                    buttonMethod: () {
                      callGenreGetter("Drama");
                    },
                  )),
                ),
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Fantasy",
                    buttonMethod: () {
                      callGenreGetter("Fantasy");
                    },
                  )),
                ),
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Romantic",
                    buttonMethod: () {
                      callGenreGetter("Romantic");
                    },
                  )),
                ),
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Horror",
                    buttonMethod: () {
                      callGenreGetter("Scary");
                    },
                  )),
                ),
                ListTile(
                  title: Center(
                      child: MainGenreButton(
                    text: "Sci-Fi",
                    buttonMethod: () {
                      callGenreGetter("Sci-Fi");
                    },
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
                      child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 40,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                BorderedText(
                                  strokeWidth: 4.0,
                                  strokeColor: Color(0xFF2B6086),
                                  child: Text(headerText,
                                      style: TextStyle(
                                          color: Color(0xFFCAEEE4),
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            )
                          ])),
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
