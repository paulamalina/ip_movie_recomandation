import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  late final _ratingController;
  late double _rating;


  double _initialRating = 2.0;
  IconData? _selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.teal,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                height: 700,
                width: 700,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  // color: Color(0xFFB9D0B3),
                  color: Colors.white,
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Colors.white,
                  //     Colors.teal,
                  //     Colors.white
                  //   ],
                  // ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //SvgPicture.asset('assets/images/logo.svg'),
                            Image.asset('assets/images/logo.png', width: 100, height: 100,),
                            Text(
                              'Avatar',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 40,
                              ),
                            ),
                            //stars
                            RatingBar.builder(
                              initialRating: _initialRating,
                              minRating: 1,
                              direction:  Axis.horizontal,
                              allowHalfRating: true,
                              unratedColor: Colors.amber.withAlpha(50),
                              itemCount: 5,
                              itemSize: 50.0,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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

                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Image.asset('assets/images/image1.png', width: 300, height: 300,),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50,right: 50),
                      child: Text(
                          'Avatar derives from a Sanskrit word meaning "descent," and when it first appeared in English in the late 18th century, it referred to the descent of a deity to the earth—typically, the incarnation in earthly form of Vishnu or another Hindu deity. It later came to refer to any incarnation in human form, and then to any embodiment (such as that of a concept or philosophy), whether or not in the form of a person. In the age of technology, avatar has developed another sense—it can now be used for the image that a person chooses as his or her "embodiment" in an electronic medium.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
              child: Center(
                child: _controller.value.isInitialized ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                ) : Container(),
              ),
            ),
            MaterialButton(onPressed: (){
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 40,
              ),),
          ],
        ),
      ),
    );
  }
}
