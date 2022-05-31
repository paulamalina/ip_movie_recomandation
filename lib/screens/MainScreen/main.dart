import 'package:http/http.dart' as http;
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ip_movie_recomandation/widgets/big_logout_button.dart';
import 'package:ip_movie_recomandation/widgets/big_search_field.dart';
import 'package:ip_movie_recomandation/widgets/image_button.dart';
import 'package:ip_movie_recomandation/widgets/small_logout_button.dart';
import 'package:ip_movie_recomandation/widgets/main_genre_button.dart';
import 'package:ip_movie_recomandation/models/searched_movie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ip_movie_recomandation/data/data.dart';

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
  String toSearch = "NULL";
  int carouselMaxNumber = 10;
  String headerText = "For you";
  List<Widget> carouselItems = [];
  Widget myCarousel = Container();
  bool isFinish = false;
  List<SearchedMovie> foundMovies = [];
  bool isLargeScreen = true;
  double imgWidth = 300;
  double imgHeight = 250;
  int recommendedNumber = 10;

  void populateLinks() {
    trailerLink = "link";
    movieLink = "link";
  }

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

  String authToken = token;

  void callGenreGetter(String genre) {
    test = 3;
    toSearch = genre;
    headerText = genre;
    setState(() {});
  }

  void callMovieGetter(String name) {
    test = 1;
    toSearch = name;
    headerText = "Search results";
    setState(() {});
  }

  Future fetchAllGenreMovie(String genre) async {
    final response = await http.get(
        Uri.parse(
            'http://157.230.114.95:8090/api/v1/movies/search/genre/' + genre),
        headers: {"Authorization": authToken});

    if (response.statusCode == 200) {
      headerText = genre;
      genreListLeft.clear();
      foundMovies = [];
      foundMovies = searchedMovieFromJson(response.body);
      if (foundMovies.isNotEmpty) {
        for (int i = 0; i < foundMovies.length; i++) {
          genreListLeft.add(ImageButton(
              image: Image.network(foundMovies[i].thumbnailLink),
              text: foundMovies[i].name));
        }
        return genreListLeft;
      }
    }
    test = 2;
    setState(() {});
    throw Exception("Error at fetching data!");
  }

  Future fetchGenreMovie(String genre) async {
    final response = await http.get(
        Uri.parse(
            'http://157.230.114.95:8090/api/v1/movies/search/genre/' + genre),
        headers: {"Authorization": authToken});

    if (response.statusCode == 200) {
      List<SearchedMovie> genreList = searchedMovieFromJson(response.body);
      if (genreList.isNotEmpty) {
        return genreList;
      }
    }
    throw Exception("Error at fetching data!");
  }

  Future fetchRecommendedMovie(int number) async {
    final response = await http.get(
        Uri.parse('http://157.230.114.95:8090/api/v1/recommendation/' +
            number.toString()),
        headers: {"Authorization": authToken});

    if (response.statusCode == 200) {
      searchedList.clear();
      foundMovies = [];
      foundMovies = searchedMovieFromJson(response.body);
      if (foundMovies.isNotEmpty) {
        populateList(recommendedList);
        return recommendedList;
      }
    }
    throw Exception("Error at fetching data!");
  }

  Future fetchMovie(String name) async {
    final response = await http.get(
        Uri.parse(
            'http://157.230.114.95:8090/api/v1/movies/search/name/' + name),
        headers: {"Authorization": authToken});
    if (response.statusCode == 200) {
      searchedList.clear();
      foundMovies = [];
      foundMovies = searchedMovieFromJson(response.body);
      if (foundMovies.isNotEmpty) {
        populateList(searchedList);
        return searchedList;
      }
    }
    test = 2;
    setState(() {});
    throw Exception("Error at fetching data!");
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
          image: Image.network(foundMovies[i].thumbnailLink),
          text: foundMovies[i].name));
    }
  }

  Container displayGenreMovie() {
    // ignore: avoid_unnecessary_containers
    return Container(
        child: FutureBuilder(
      future: fetchAllGenreMovie(toSearch),
      builder: (context, snapshotGenreSearch) {
        if (snapshotGenreSearch.data == null) {
          return Container(
            child: null,
          );
        } else {
          genreListLeft = snapshotGenreSearch.data as List<ImageButton>;
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 40,
            children: genreListLeft,
          );
        }
      },
    ));
  }

  Container displayMovieReturned() {
    // ignore: avoid_unnecessary_containers
    return Container(
        child: FutureBuilder(
      future: fetchMovie(toSearch),
      builder: (context, snapshotSearch) {
        if (snapshotSearch.data == null) {
          return Container(
            child: null,
          );
        } else {
          searchedList = snapshotSearch.data as List<ImageButton>;
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 40,
            children: searchedList,
          );
        }
      },
    ));
  }

  Container noMovieReturned() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(children: const [
        SizedBox(height: 80),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text("Nothing Found",
              style: TextStyle(
                  color: Color(0xFFCAEEE4),
                  fontSize: 80,
                  fontWeight: FontWeight.w200)),
        ),
        SizedBox(height: 30),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text("Sorry, but nothing matched your search terms",
              style: TextStyle(
                  color: Color(0xFFCAEEE4),
                  fontSize: 40,
                  fontWeight: FontWeight.w200)),
        ),
        SizedBox(height: 100),
      ]),
    );
  }

  Widget initGenreCarousel(List<SearchedMovie> genreMovies) {
    Widget carousel = Container();
    List<Widget> items = [];
    List<ImageButton> images = [];

    //Populate list
    for (int i = 0; i < genreMovies.length && i < carouselMaxNumber; i++) {
      images.add(ImageButton(
          image: Image.network(genreMovies[i].thumbnailLink),
          text: genreMovies[i].name));
    }
    //Init Carousel
    items = images;
    carousel = Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: CarouselSlider(
        items: items,
        options: CarouselOptions(
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          viewportFraction: MediaQuery.of(context).size.width > 800 ? 0.3 : 1,
          height: 400,
          scrollDirection: Axis.horizontal,
        ),
        carouselController: CarouselController(),
      ),
    );

    return carousel;
  }

  void initCarousel() {
    myCarousel = Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: CarouselSlider(
        items: carouselItems,
        options: CarouselOptions(
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
    carouselItems = rememberRecommended;
  }

  Container normalPrint() {
    // ignore: avoid_unnecessary_containers
    return Container(
        child: Wrap(alignment: WrapAlignment.center, spacing: 40, children: [
      FutureBuilder(
        future: fetchRecommendedMovie(recommendedNumber),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: null,
            );
          } else {
            rememberRecommended = snapshot.data as List<ImageButton>;
            initImages();
            initCarousel();
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Recommended Movies",
                  style: TextStyle(
                      color: Color(0xFFCAEEE4),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                myCarousel,
              ],
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
            Widget carouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Action",
                  style: TextStyle(
                      color: Color(0xFFCAEEE4),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                carouselGenreChild,
              ],
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
            Widget carouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Comedy",
                  style: TextStyle(
                      color: Color(0xFFCAEEE4),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                carouselGenreChild,
              ],
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
            Widget carouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Drama",
                  style: TextStyle(
                      color: Color(0xFFCAEEE4),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                carouselGenreChild,
              ],
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
            Widget carouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Fantasy",
                  style: TextStyle(
                      color: Color(0xFFCAEEE4),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                carouselGenreChild,
              ],
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
            Widget carouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Romantic",
                  style: TextStyle(
                      color: Color(0xFFCAEEE4),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                carouselGenreChild,
              ],
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
            Widget carouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Horror",
                  style: TextStyle(
                      color: Color(0xFFCAEEE4),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                carouselGenreChild,
              ],
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
            Widget carouselGenreChild =
                initGenreCarousel(snapshotAction.data as List<SearchedMovie>);
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Sci-Fi",
                  style: TextStyle(
                      color: Color(0xFFCAEEE4),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                carouselGenreChild,
              ],
            );
          }
        },
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    setDimentions();
    if (recommendedList.isNotEmpty) {
      initImages();
      initCarousel();
    }

    return Container(
      decoration: const BoxDecoration(
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
          title: SizedBox(
              width: 60,
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/images/LogoSvg2.svg",
                  height: 100,
                ),
                onPressed: () {
                  new Future.delayed(const Duration(seconds: 3), () {
                    populateLinks();
                    Navigator.pushNamed(context, "/main");
                  });
                },
              )
              /*
            child: SvgPicture.asset(
              "assets/images/logoClean.svg",
            ),
            */
              ),
          actions: [
            BigSearchField(
              returnSearch: callMovieGetter,
            ),
            // MediaQuery.of(context).size.width > 500
            //     ? BigSearchField(
            //         returnSearch: callMovieGetter,
            //       )
            //     : SmallSearchField(
            //         returnSearch: callMovieGetter,
            //       ),
            const SizedBox(width: 20),
            IconButton(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              icon: const Icon(
                Icons.person,
                color: Color(0xFFCAEEE4),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/changeProfile');
              },
            ),
            const SizedBox(width: 20),
            isLargeScreen ? const BigLogoutButton() : const SmallLogoutButton(),
            const SizedBox(
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
                        boxShadow: const [
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
                                const SizedBox(
                                  height: 30,
                                ),
                                BorderedText(
                                  strokeWidth: 4.0,
                                  strokeColor: const Color(0xFF2B6086),
                                  child: Text(headerText,
                                      style: const TextStyle(
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
                        boxShadow: const [
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
