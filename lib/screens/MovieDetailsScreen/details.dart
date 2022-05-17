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
// Widget commentChild(data) {
//     return ListView(
//       children: [
//         for (var i = 0; i < data.length; i++)
//           Padding(
//             padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
//             child: ListTile(
//               leading: GestureDetector(
//                 onTap: () async {
//                   // Display the image in large form.
//                   print("Comment Clicked");
//                 },
//                 child: Container(
//                   height: 50.0,
//                   width: 50.0,
//                   decoration: new BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: new BorderRadius.all(Radius.circular(50))),
//                   child: CircleAvatar(
//                       radius: 50,
//                       backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
//                 ),
//               ),
//               title: Text(
//                 data[i]['name'],
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(data[i]['message']),
//             ),
//           )
//       ],
//     );
//   }
 
  
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //SvgPicture.asset('assets/images/logo.svg'),
          
                               Center(child:  SvgPicture.asset(
                  "assets/images/LogoSvg2.svg", height: 100,
                ),),
          //       Center(child: comm.CommentBox( userImage:
          //     "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
          // child: commentChild(filedata),
          // labelText: 'Write a comment...',
          // withBorder: false,
          // errorText: 'Comment cannot be blank',
          // sendButtonMethod: () {
          //   if (formKey.currentState!.validate()) {
          //     print(commentController.text);
          //     setState(() {
          //       var value = {
          //         'name': 'New User',
          //         'pic':
          //             'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
          //         'message': commentController.text
          //       };
          //       filedata.insert(0, value);
          //     });
          //     commentController.clear();
          //     FocusScope.of(context).unfocus();
          //   } else {
          //     print("Not validated");
          //   }
          // },
          // formKey: formKey,
          // commentController: commentController,
          // backgroundColor: Colors.black,
          // textColor: Colors.white,
          // sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white) ,),),
                              
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
                            color: Color(0xFFCAEEE4),
                            fontSize: 20,
                          ),
                        ),
                      ),
                       Padding(
                         padding: const EdgeInsets.only(top: 25.0),
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
