import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
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
            height: containerHeight,
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Color(0xFFCAEEE4),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Color(0xFF1A759F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Color(0xFFCAEEE4),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xFF1A759F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Color(0xFFCAEEE4),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: Color(0xFF1A759F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
