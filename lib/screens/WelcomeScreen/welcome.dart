
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Let\'s find a movie',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),),),
          Padding(
            padding: const EdgeInsets.all(80),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.cyan,
                borderRadius: const BorderRadius.all(Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Center(child: SvgPicture.asset('assets/images/welcome.svg')),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.greenAccent,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/choose");
                } ,
                child: Text('Get Started', style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

<<<<<<< Updated upstream
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.teal,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(child: Text('Let\'s find a movie',
//             style: TextStyle(
//               fontSize: 30,
//               color: Colors.white,
//             ),),),
//           Padding(
//             padding: const EdgeInsets.all(40),
//             child: Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Colors.cyan,
//                 borderRadius: const BorderRadius.all(Radius.circular(40)),
//               ),
//               child: Column(
//                 children: [
//                   Center(child: SvgPicture.asset('assets/images/welcome.svg')),
//                 ],
//               ),
//             ),
//           ),
//           Center(
//             child: Container(
//               width: 100,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50.0),
//                 color: Colors.greenAccent,
//               ),
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, "/choose");
//                 } ,
//                 child: Text('Get Started', style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
=======
>>>>>>> Stashed changes
