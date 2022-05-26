import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ip_movie_recomandation/data/data.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/MyButton.dart';

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
  late double _rating;
  // late VideoPlayerController _controller;

  double containerWidth = 800;
  double containerHeight = 800;
  bool isSmallScreen = false;
  bool isLargeScreen = true;

  TextStyle textStyle=TextStyle(
    color: Colors.white
  );
  TextStyle titleStyle=TextStyle(
      color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  String trailerLink="";
  @override
  void initState() {
  //   // TODO: implement initState
  //   _controller = VideoPlayerController.network(
  //       trailerLink,
  //       httpHeaders: {
  //         "Authorization" : token,
  //       })
  //     ..addListener(() => setState(() {}))
  //     ..setLooping(true)
  //     ..initialize().then((_) => _controller.pause());
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
          trailerLink=data[i]["trailerLink"];
          currentId=data[i]["id"];
          // _controller = VideoPlayerController.network(
          //     "http://157.230.114.95:8090/api/v1/files/file_295749543.mp4",
          // httpHeaders: {
          //       "Authorization" : authToken,
          // })
          //   ..addListener(() => setState(() {}))
          //   ..setLooping(true)
          //   ..initialize().then((_) => _controller.pause());
          return data[i];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setValue();
    return Container(
      decoration: BoxDecoration(
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
            isLargeScreen ? SizedBox(
              height: 50,
            ) : Container(),
            FutureBuilder(
              future: getDetailsForMovie(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return SizedBox(
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
                                BoxShadow(
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
                                padding: EdgeInsets.only(right: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20, left: 20),
                                        child: Center(child: Text(titleText, style: titleStyle,),
                                        ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(child: Text("$releaseDate  |  $ageRestriction +  | $duration min |  $genre ",style: textStyle,)),
                                    SizedBox(
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
                                      itemPadding: EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        _selectedIcon ?? Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          _rating = rating;
                                          print(_rating);
                                        });
                                      },
                                      updateOnDrag: true,
                                    ),
                                    SizedBox(
                                      height: 20,
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
              height: 100,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyButton(
                        text: 'Back',
                        textStyle: TextStyle(
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
                        textStyle: TextStyle(
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
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 7,
                    ),
                  ]
                      : null,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text("    Watch the trailer here ", style: TextStyle(
                            color: Colors.white,
                            fontSize: 30
                        ),),
                        Icon(
                            Icons.arrow_downward
                        ),
                      ],
                    ),
                    //TODO Video HERE
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
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 7,
                    ),
                  ]
                      : null,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text("    Watch the movie here ", style: TextStyle(
                          color: Colors.white,
                          fontSize: 30
                        ),),
                        Icon(
                            Icons.arrow_downward
                        ),
                      ],
                    ),
                    //TODO Video HERE
                  ],
                ),
              ),
            ),
            // Column(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
            //       child: Center(
            //         child: _controller.value.isInitialized
            //             ? AspectRatio(
            //           aspectRatio: _controller.value.aspectRatio,
            //           child: VideoPlayer(_controller),
            //         )
            //             : Container(),
            //       ),
            //     ),
            //     MaterialButton(
            //       onPressed: () {
            //         setState(() {
            //           _controller.value.isPlaying
            //               ? _controller.pause()
            //               : _controller.play();
            //         });
            //       },
            //       child: Icon(
            //         _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            //         size: 40,
            //       ),
            //     ),
            //   ],
            // )
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
