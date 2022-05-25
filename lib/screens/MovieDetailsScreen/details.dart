import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ip_movie_recomandation/widgets/MyButton.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:comment_box/comment/comment.dart' as comm;

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _controller.play());
  }

  void navigateToChoose() {
    Navigator.pushNamed(context, "/choose");
  }

  void navigateToComment() {
    Navigator.pushNamed(context, "/commentBox");
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'Adeleye Ayodeji',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
  ];

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  late final _ratingController;
  late double _rating;

  double _initialRating = 2.0;
  IconData? _selectedIcon;

  double containerWidth = 600;
  double containerHeight = 600;
  bool isSmallScreen = false;
  bool isLargeScreen = true;
  void setValue() {
    if (MediaQuery.of(context).size.width >= 700) {
      setState(() {
        containerWidth = 600;
        containerHeight = 600;
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
  @override
  Widget build(BuildContext context) {
    setValue();
    return Container(
      decoration: BoxDecoration(
        gradient: !isSmallScreen ? LinearGradient(
          colors: [Colors.white, Color.fromRGBO(52, 160, 164, 1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ) : null,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            isLargeScreen ? 
            SizedBox(
              height: 100,
              width: 400,
            ) : Container(),
            Center(
              child: Container(
                height: 1000,
                width: 1000,
                decoration: BoxDecoration(
                    borderRadius: isLargeScreen ? BorderRadius.circular(50) : null,
                    // color: Color(0xFFB9D0B3),
                    color: Colors.teal,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 2,
                      )
                    ]
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Colors.white,
                    //     Colors.teal,
                    //     Colors.white
                    //   ],
                    // ),

                    ),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              "assets/images/LogoSvg2.svg",
                              height: 90,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Wrap(
                                  spacing: 50,
                                  alignment: WrapAlignment.center,
                                  children: [
                                  Container(
                                    //color: Colors.red,
                                    child: Column(
                                      children:[
                                        SizedBox(
                                          height: 150,
                                        ),
                                        Text(
                                          'Avatar',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                          ),
                                        ),
                                        //stars
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 50.0),
                                          child: RatingBar.builder(
                                            initialRating: _initialRating,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            unratedColor: Colors.amber.withAlpha(50),
                                            itemCount: 5,
                                            itemSize: 50.0,
                                            itemPadding:
                                                EdgeInsets.symmetric(horizontal: 4.0),
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
                                        ),
                                      ]),
                                  ),
                                    Container(
                                      //color: Colors.purple,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/image1.png',
                                            width: 450,
                                            height: 450,
                                          ),
                                      ],)
                                    ),
                                ],),
                              ],),
                          ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50, right: 50),
                              child: Text(
                                'Avatar derives from a Sanskrit word meaning "descent," and when it first appeared in English in the late 18th century, it referred to the descent of a deity to the earth—typically, the incarnation in earthly form of Vishnu or another Hindu deity. It later came to refer to any incarnation in human form, and then to any embodiment (such as that of a concept or philosophy), whether or not in the form of a person. In the age of technology, avatar has developed another sense—it can now be used for the image that a person chooses as his or her "embodiment" in an electronic medium.',
                                style: TextStyle(
                                  color: Color(0xFFCAEEE4),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                                  height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: SizedBox(
                                  width: 160,
                                  height: 50,
                                  child: MyButton(
                                    text: 'Back',
                                    buttonMethod: navigateToChoose,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: SizedBox(
                                  width: 160,
                                  height: 50,
                                  child: MyButton(
                                    text: 'Comment',
                                    buttonMethod: navigateToComment,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: 2,
                                ),
                              ],
                            ),

                          ]),
                      ),
                // child: Container(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               //SvgPicture.asset('assets/images/logo.svg'),

                //               Center(
                //                 child: SvgPicture.asset(
                //                   "assets/images/LogoSvg2.svg",
                //                   height: 100,
                //                 ),
                //               ),

                //               SizedBox(
                //                 width: 40,
                //               ),
                //               Image.asset(
                //                 'assets/images/image1.png',
                //                 width: 500,
                //                 height: 500,
                //               ),
                //               Text(
                //                 'Avatar',
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 40,
                //                 ),
                //               ),
                //               //stars
                //               Padding(
                //                 padding: const EdgeInsets.only(bottom: 50.0),
                //                 child: RatingBar.builder(
                //                   initialRating: _initialRating,
                //                   minRating: 1,
                //                   direction: Axis.horizontal,
                //                   allowHalfRating: true,
                //                   unratedColor: Colors.amber.withAlpha(50),
                //                   itemCount: 5,
                //                   itemSize: 50.0,
                //                   itemPadding:
                //                       EdgeInsets.symmetric(horizontal: 4.0),
                //                   itemBuilder: (context, _) => Icon(
                //                     _selectedIcon ?? Icons.star,
                //                     color: Colors.amber,
                //                   ),
                //                   onRatingUpdate: (rating) {
                //                     setState(() {
                //                       _rating = rating;
                //                     });
                //                   },
                //                   updateOnDrag: true,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 50, right: 50),
                //         child: Text(
                //           'Avatar derives from a Sanskrit word meaning "descent," and when it first appeared in English in the late 18th century, it referred to the descent of a deity to the earth—typically, the incarnation in earthly form of Vishnu or another Hindu deity. It later came to refer to any incarnation in human form, and then to any embodiment (such as that of a concept or philosophy), whether or not in the form of a person. In the age of technology, avatar has developed another sense—it can now be used for the image that a person chooses as his or her "embodiment" in an electronic medium.',
                //           style: TextStyle(
                //             color: Color(0xFFCAEEE4),
                //             fontSize: 20,
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //             height: 20,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           SizedBox(
                //             height: 2,
                //           ),
                //           Padding(
                //           padding: const EdgeInsets.only(top: 10.0),
                //           child: SizedBox(
                //             width: 160,
                //             height: 50,
                //             child: MyButton(
                //               text: 'Back',
                //               buttonMethod: navigateToChoose,
                //             ),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(top: 10.0),
                //           child: SizedBox(
                //             width: 160,
                //             height: 50,
                //             child: MyButton(
                //               text: 'Comment',
                //               buttonMethod: navigateToComment,
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //             height: 2,
                //           ),
                //         ],
                //       ),
                //       // DropdownButton(

                //       //   items: items, 
                //       //   onChanged: onChanged
                //       // )
                //     ],
                //   ),
                // ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
              child: Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(),
              ),
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
