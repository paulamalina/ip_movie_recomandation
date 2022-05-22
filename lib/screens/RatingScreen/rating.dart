import 'package:flutter/material.dart';
import 'package:ip_movie_recomandation/widgets/MyButton.dart';
import '../MainScreen/main.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart' as http;

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  // @override
  void function() {
    if (globals.Index == 0) {
      globals.image = 'assets/images/image1.png';
      globals.Index++;
    } else if (globals.Index == 1) {
      globals.image = 'assets/images/image2.png';
      globals.Index++;
    } else if (globals.Index == 2) {
      globals.image = 'assets/images/image3.png';
      globals.Index++;
    } else if (globals.Index == 3) {
      globals.image = 'assets/images/image4.png';
      globals.Index++;
    } else if (globals.Index == 4) {
      globals.image = 'assets/images/image5.png';
      globals.redirect = "/main";
      globals.Index++;
    }
  }

  void getMovies() async {
    print("------------");
    print(authToken);
    print("------------");

    final Uri apiUrl =
        Uri.parse("http://157.230.114.95:8090/api/v1/movie/profiler");
    final response = await http.get(apiUrl, headers: {
      "Authorization": authToken,
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      "Content-Type": "application/json",
    });

    print(response.statusCode);
  }

  void navigateToRating() {
    Navigator.pushNamed(context, globals.redirect);
  }

  void goToMain() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
        settings: RouteSettings(
          arguments: authToken,
        ),
      ),
    );
  }

  void reduceIndex() {
    globals.Index--;
  }

  double containerWidth = 700;
  double containerHeight = 850;
  bool isSmallScreen = false;
  bool isLargeScreen = true;

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

  String authToken = "";

  @override
  Widget build(BuildContext context) {
    // function();
    // setValue();
    authToken = ModalRoute.of(context)!.settings.arguments as String;
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
        body: Center(
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
                            child: Image.asset(globals.image),
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
                                    //function();
                                    goToMain();
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
                                    //function();
                                    goToMain();
                                    Navigator.pushNamed(context, '/main');
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
                                    //function();
                                    goToMain();
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
                                    //function();
                                    goToMain();
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
                            goToMain();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    //Image.asset('./assets/images/image1.jpg');
  }
}
