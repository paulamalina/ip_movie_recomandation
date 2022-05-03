import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 7,
          )
        ],
        gradient: LinearGradient(colors: [Colors.white, Color.fromRGBO(52, 160, 164, 1)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
           backgroundColor: Color.fromRGBO(26, 117, 159, 1),   
           title: Container(
             width: 60,
             child: Image.asset(
               "assets/images/logo.png",
             ),
           ),

        ),
        body: Center(
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 2,
                )
              ],
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.teal,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
