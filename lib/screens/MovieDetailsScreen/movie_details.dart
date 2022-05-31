import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ip_movie_recomandation/data/data.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/my_button.dart';

class FieldValidator{
  static String? validateComment(String value){
    if (value.isEmpty) return 'Enter Comment!';

    return null;
  }
}

class MovieDetailsScreen1 extends StatefulWidget {
  const MovieDetailsScreen1({Key? key}) : super(key: key);

  @override
  _MovieDetailsScreen1State createState() => _MovieDetailsScreen1State();
}

class _MovieDetailsScreen1State extends State<MovieDetailsScreen1> {

  String title = "";
  String description = "";
  int ageRestriction = 0;
  String releaseDate = "";
  String summary = "";
  String genre = "";
  String imageLink = "";
  IconData? _selectedIcon;
  int duration=0;
  double averageRatingStars=0.0;
  double _rating=0.0;
  double containerWidth = 800;
  double containerHeight = 800;
  bool isSmallScreen = false;
  bool isLargeScreen = true;
  TextStyle textStyle=const TextStyle(
      color: Colors.white,
    fontSize: 23,
  );
  TextStyle titleStyle=const TextStyle(
    color: Colors.white,
    fontSize: 23,
    fontWeight: FontWeight.bold,
  );
  String responseRatingSubmit='';

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;


  late VideoPlayerController _controller1;
  late Future<void> _initializeVideoPlayerFuture1;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      trailerLink,
    );
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller1 = VideoPlayerController.network(
      movieLink,
    );
    _initializeVideoPlayerFuture1 = _controller1.initialize();

    super.initState();
  }
  void setValue() {
    if (MediaQuery.of(context).size.width > 700) {
      setState(() {
        containerWidth = MediaQuery.of(context).size.width - 200;
        containerHeight = 800;
        isSmallScreen = false;
        isLargeScreen = true;
      });
    } else {
      setState(() {
        containerWidth = MediaQuery.of(context).size.width;
        containerHeight = 850;
        isSmallScreen = true;
        isLargeScreen = false;
      });
    }
  }

  Future getDetailsForMovie() async {
    final Uri apiUrl = Uri.parse(
        "http://157.230.114.95:8090/api/v1/movies/search/name/" + titleText);
    final response = await http.get(apiUrl, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      "Content-Type": "application/json",
      "Authorization": token
    });
    List data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (int i = 0; i < data.length; i++) {
        if (data[i]["name"] == titleText) {
          description = data[i]["description"];
          summary = data[i]["summary"];
          releaseDate = data[i]["releaseDate"];
          ageRestriction = data[i]["ageRestriction"];
          genre = data[i]["movieGenres"][0]["genre"];
          imageLink = data[i]["thumbnailLink"];
          duration=data[i]["duration"];
          averageRatingStars=data[i]["averageRatingStars"];
          _rating=averageRatingStars.ceilToDouble();
          currentId=data[i]["id"];
          return data[i];
        }
      }
    }
  }



  showPopUp(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(responseRatingSubmit, style: const TextStyle(color: Colors.teal),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('OK'),
            ),
          ],
        ));
  }
  void postRating() async{
    final Uri apiUrl = Uri.parse(
        "http://157.230.114.95:8090/api/v1/reviews");
    final response = await http.post(
        apiUrl,
        body: jsonEncode({
          "movie": {
            "id": currentId,
          },
          "reviewValue": _rating
        }),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type": "application/json",
          "Authorization": token
        });
    if(response.statusCode==201){
      responseRatingSubmit="Thank you for your review!";
      showPopUp();
    }else{
      responseRatingSubmit="There was an error submitting the review! Please try again later!";
    }
  }
  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    setValue();
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF99D98C),
        gradient: LinearGradient(
          colors: [Colors.white, Color.fromRGBO(52, 160, 164, 1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            isLargeScreen ? const SizedBox(
              height: 50,
            ) : Container(),
            FutureBuilder(
              future: getDetailsForMovie(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SizedBox(
                    child: Center(child: CircularProgressIndicator()),
                    width: 100,
                    height: 100,
                  );
                } else {
                  return Center(
                    child: Container(
                      width: containerWidth,
                      height: containerHeight,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius:
                        isLargeScreen ? BorderRadius.circular(50) : null,
                        boxShadow: isLargeScreen
                            ? [
                          const BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 7,
                          ),
                        ]
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Wrap(
                            spacing: 20,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: 30, top: 30),
                                  child: MediaQuery.of(context).size.width>=950 ? Image.network(
                                    imageLink,
                                    width: 200,
                                    headers: {"Authorization": token},
                                  ) : Center(
                                    child: Image.network(
                                      imageLink,
                                      width: 200,
                                      headers: {"Authorization": token},
                                    ),
                                  )
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width >900 ? 500 : double.infinity,
                                padding: const EdgeInsets.only(right: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(right: 20, left: 20),
                                      child: Center(child: Text(titleText, style: titleStyle,),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(child: Text("$releaseDate  |  $ageRestriction +  | $duration min |  $genre ",style: textStyle,)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    RatingBar.builder(
                                      initialRating: averageRatingStars,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      unratedColor:
                                      Colors.amber.withAlpha(50),
                                      itemCount: 5,
                                      itemSize: 50.0,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        _selectedIcon ?? Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          _rating = rating;
                                        });
                                      },
                                      updateOnDrag: true,
                                    ),
                                    Center(
                                      child: Container(
                                        width: 130,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50.0),
                                          color: const Color(0xFFCAEEE4),
                                          //border: Border.all(color: Color(0xFF2B6086), width: 2),
                                        ),
                                        child: TextButton(onPressed: (){
                                          postRating();
                                        }, child: const Text("Submit rating", style: TextStyle(
                                          color: Colors.teal,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),),),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 30, right: 30, left: 50),
                                      child: Text(description, style: textStyle,),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                              padding: const EdgeInsets.only(top: 30, right: 50, left: 50),
                              child: Text(summary, style: textStyle)),
                          // SizedBox(
                          //   height: double.infinity,
                          // ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: containerWidth,
                height: containerHeight,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius:
                  isLargeScreen ? BorderRadius.circular(50) : null,
                  boxShadow: isLargeScreen
                      ? [
                    const BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 7,
                    ),
                  ]
                      : null,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: const [
                        Text("    Watch the trailer here ", style: TextStyle(
                            color: Colors.white,
                            fontSize: 30
                        ),),
                        Icon(
                            Icons.arrow_downward
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // If the VideoPlayerController has finished initialization, use
                          // the data it provides to limit the aspect ratio of the video.
                          return Container(
                            width: containerWidth,
                              height: containerHeight-300,
                              child: VideoPlayer(_controller),
                          );
                        } else {
                          // If the VideoPlayerController is still initializing, show a
                          // loading spinner.
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    FloatingActionButton(
                      heroTag: "button1",
                      backgroundColor: Colors.greenAccent,
                      onPressed: () {
                        // Wrap the play or pause in a call to `setState`. This ensures the
                        // correct icon is shown.
                        setState(() {
                          // If the video is playing, pause it.
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            // If the video is paused, play it.
                            _controller.play();
                          }
                        });
                      },
                      // Display the correct icon depending on the state of the player.
                      child: Icon(
                        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: containerWidth,
                height: containerHeight,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius:
                  isLargeScreen ? BorderRadius.circular(50) : null,
                  boxShadow: isLargeScreen
                      ? [
                    const BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 7,
                    ),
                  ]
                      : null,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: const [
                        Text(" Watch the movie here ", style: TextStyle(
                            color: Colors.white,
                            fontSize: 30
                        ),),
                        Icon(
                            Icons.arrow_downward
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    FutureBuilder(
                      future: _initializeVideoPlayerFuture1,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // If the VideoPlayerController has finished initialization, use
                          // the data it provides to limit the aspect ratio of the video.
                          return Container(
                            width: containerWidth,
                            height: containerHeight-300,
                            child: VideoPlayer(_controller1),
                          );
                        } else {
                          // If the VideoPlayerController is still initializing, show a
                          // loading spinner.
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    FloatingActionButton(
                      heroTag: "button2",
                      backgroundColor: Colors.greenAccent,
                      onPressed: () {
                        // Wrap the play or pause in a call to `setState`. This ensures the
                        // correct icon is shown.
                        setState(() {
                          // If the video is playing, pause it.
                          if (_controller1.value.isPlaying) {
                            _controller1.pause();
                          } else {
                            // If the video is paused, play it.
                            _controller1.play();
                          }
                        });
                      },
                      // Display the correct icon depending on the state of the player.
                      child: Icon(
                        _controller1.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyButton(
                        text: 'Back',
                        textStyle: const TextStyle(
                          color: Color(0xFF1A759F),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        width: 120,
                        height: 40,
                        buttonMethod: (){

                          Navigator.pop(context);
                        },
                      ),
                      MyButton(
                        text: 'Comment',
                        textStyle: const TextStyle(
                          color: Color(0xFF1A759F),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        width: 120,
                        height: 40,
                        buttonMethod: (){

                          Navigator.pushNamed(context, '/commentBox');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}