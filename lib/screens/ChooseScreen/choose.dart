import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ip_movie_recomandation/widgets/MyButton.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  double containerWidth = 600;
  double containerHeight = 600;
  bool isSmallScreen = false;
  bool isLargeScreen = true;
  String logo = "assets/images/LogoSvg2.svg";

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

  void navigateToLogin() {
    Navigator.pushNamed(context, "/login");
  }

  void navigateToRegister() {
    Navigator.pushNamed(context, "/register");
  }

  void goBack() {
    Navigator.pop(context);
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

        gradient: LinearGradient(
            colors: [Colors.white, Color.fromRGBO(52, 160, 164, 1)],
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
              boxShadow: isLargeScreen
                  ? [
                      BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
              borderRadius: isLargeScreen ? BorderRadius.circular(50.0) : null,
              color: Colors.teal,
            ),

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child:  SvgPicture.asset(
                  logo, height: 100,
                ),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: MyButton(
                        text: 'Log in',
                        buttonMethod: navigateToLogin,
                      ),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: MyButton(
                        text: 'Register',
                        buttonMethod: navigateToRegister,
                      ),
                    ),
                  ),
                  
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: MyButton(
                        text: 'Back',
                        buttonMethod: goBack,
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
