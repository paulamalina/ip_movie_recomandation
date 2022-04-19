import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors(34A0A4),
    body: Column(   
      child: Column(
        children: [
          child: Container(
            width: 1440,
            height: 58,
            decoration: BoxDecoration(
                 color: Colors(76C893),
              ),
          
          Row(
            crossAxisAlignemt: CrossAxisAlignement.start,
            children: [
              Image.asset('assets/images/logo.png'),
            ],
          ),
        ),

        Container(
            decoration: const BoxDecoration(
              width: 347,
              height: 58,
              color: Colors(1A759F),
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              
            ),
            child: Text(('Let\'s find a movie', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
        Padding(
            padding: const EdgeInsets.all(80),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors(76C893),
                borderRadius: const BorderRadius.all(Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Center(child: SvgPicture.asset('images/Welcome2.svg')),
                ],
              ),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          
          height: 58,
            
          decoration: const BoxDecoration(
              color: Colors(1A759F),
              borderRadius: const BorderRadius.all(Radius.circular(40)),            
            ),
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/choose");
                } ,
                child: Text('Get Started', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
          ]
        ),
        ]
      )
    )
  );
}