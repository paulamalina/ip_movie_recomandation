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
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _controller.play());
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
            Colors.white, Color.fromRGBO(52, 160, 164, 1)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
       
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            SizedBox(
              height: 100,
              width: 400,
            ),
            Center(
              child: Container(
                height: 1100,
                width: 700,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  // color: Color(0xFFB9D0B3),
                  color: Color(0xFF34A0A4),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //SvgPicture.asset('assets/images/logo.svg'),
          
                               Center(child: Image.asset('assets/images/logo.png', width: 100, height: 100,)),
                              
                                 SizedBox(
                            width: 50,
                          ),
                          Image.asset('assets/images/image1.png', width: 500, height: 500,),
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
                              ),
                          
                            ],
                          ),

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
                       Padding(
                         padding: const EdgeInsets.only(top: 25.0),
                         child: SizedBox(
                    width: 160,
                    height: 50,
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 202, 238, 228)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              ),
                          )

                      ),
                      onPressed: (){
                      Navigator.pushNamed(context, "/choose");
                      },
                      child: Center(
                          child: Text('Back', style: TextStyle(
                            color: Color(0xFF1A759F),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),),
                      ),
                    ),
                  ),
                       ),
                    ],
                  ),
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
