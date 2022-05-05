import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  @override
  Widget build(BuildContext context) {
    setValue();
    return Container(
      decoration: BoxDecoration(
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
              boxShadow: isLargeScreen ? [
                BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 2,
                )
              ] : null,
              borderRadius: isLargeScreen ? BorderRadius.circular(50.0) : null,
              color: Colors.teal,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png", width: 100, height: 100,
                ),
                Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(50.0),
                   color: Color.fromRGBO(26, 117, 159, 1),
                    ),
                  child: Center(
                    child: Text('Let\'s find a movie', style: TextStyle(
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
                    width: 200,
                    height: 50,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(26, 117, 159, 1)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            ),
                        )

                      ),
                      onPressed: (){
                      Navigator.pushNamed(context, "/choose");
                      },
                      child: Text('Get started', style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      ),),
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
