import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ip_movie_recomandation/widgets/my_button.dart';


//import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'globals.dart' as globals;
import 'package:ip_movie_recomandation/widgets/loading_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
  
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  

  double containerWidth=600;
  double containerHeight=600;
  bool isSmallScreen=false;
  bool isLargeScreen=true;
  void setValue(){
    if(MediaQuery.of(context).size.width >= 700){
      setState(() {
        containerWidth=600;
        containerHeight=600;
        isSmallScreen=false;
        isLargeScreen=true;
      });
    }else{
      setState(() {
        containerWidth=double.infinity;
        containerHeight=double.infinity;
        isSmallScreen=true;
        isLargeScreen=false;

      });
    }
  }
  void navigateToChoose() {
    Navigator.pushNamed(context, "/choose");
  }
  @override
  Widget build(BuildContext context) {
     //LoadingScreen(WelcomeScreen());
     //Function(WelcomeScreen());
     if(globals.nr==0){
       globals.nr=1;
     return AnimatedSplashScreen(
      splash: 'assets/images/logo.png',
      //backgroundColor = Color.fromRGBO(52, 160, 164, 1),
      nextScreen: const WelcomeScreen(),
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
    );
     }
    setValue();
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 7,
          )
        ],
        gradient: LinearGradient(colors: [
          Colors.white, Color.fromRGBO(52, 160, 164, 1)
          ],
           begin: Alignment.topCenter,
           end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: containerWidth,
            height:containerHeight,
            decoration: BoxDecoration(
              color: Colors.teal,
              boxShadow: isLargeScreen ? [
                const BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 2,
                )
              ] : null,
              borderRadius: isLargeScreen ? BorderRadius.circular(50.0) : null,
              
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/LogoSvg2.svg", height: 100,
                ),
                SizedBox(
                  width: 400,
                  height: 50,
                  
                  child: BorderedText(
                    strokeWidth: 4.0,
                    strokeColor: const Color(0xFF2B6086),
                    child: const Text('Let\'s find a movie', style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,

                    ),),
                  ),
                ),
                Center(
                  child: SvgPicture.asset(
                    "assets/images/welcome.svg",
                  ),
                ),
                  SizedBox(
                    width: 160,
                    height: 50,
                    child: MyButton(
                        text: 'Get started',
                        buttonMethod: navigateToChoose,
                      ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
