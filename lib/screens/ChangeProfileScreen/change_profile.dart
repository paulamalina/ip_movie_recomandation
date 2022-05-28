import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ip_movie_recomandation/widgets/my_button.dart';
import '../../widgets/my_text_field.dart';

class ChangeProfieScreen extends StatefulWidget {
  const ChangeProfieScreen({Key? key}) : super(key: key);

  @override
  State<ChangeProfieScreen> createState() => _ChangeProfieScreen();
}

class _ChangeProfieScreen extends State<ChangeProfieScreen> {
  final _formKey = GlobalKey<FormState>();
  double containerWidth = 1000;
  double containerHeight = 900;
  bool isSmallScreen = false;
  bool isLargeScreen = true;
  bool backWasPressed = false;

  void setValue() {
    if (MediaQuery.of(context).size.width >= 700) {
      setState(() {
        containerWidth = 1000;
        containerHeight = 900;
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

  void navigateBackToMain() {
    setState(() {
      backWasPressed = true;
      print(backWasPressed);
    });
    Navigator.pushNamed(context, '/main');
  }

  void navigateToMain() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/main');
    }
  }

  final myPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    setValue();
    return Container(
      decoration: const BoxDecoration(
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
                      const BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
              borderRadius: isLargeScreen ? BorderRadius.circular(50.0) : null,
              color: Colors.teal,
            ),
            child: Form(
              key: _formKey,
              child: Center(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(
                      "assets/images/LogoSvg2.svg",
                      height: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Change your profile",
                            style: TextStyle(
                              color: Color(0xFFB5E48C),
                              fontSize: 25,
                            ),
                          )),
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                            child: Wrap(
                              spacing: 50,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    MyTextField(
                                        formFieldValidator: (text) {
                                          if (!backWasPressed &&
                                              (text == null ||
                                                  text.isEmpty ||
                                                  !RegExp(r"^[A-Z][a-z]*((-|\s)[A-Z][a-z]*)+$")
                                                      .hasMatch(text))) {
                                            print("invalid la validare");
                                            return "Invalid name";
                                          }
                                          return null;
                                        },
                                        hintText: 'Popescu Maria',
                                        text: 'Name',
                                        controller: TextEditingController()),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MyTextField(
                                        formFieldValidator: (text) {
                                          if (!backWasPressed &&
                                              (text == null ||
                                                  text.isEmpty ||
                                                  !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                                                      .hasMatch(text))) {
                                            return "Invalid email address";
                                          }
                                          return null;
                                        },
                                        hintText: 'popescu.maria@gmail.com',
                                        text: 'Email',
                                        controller: TextEditingController()),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ))),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 70, right: 70),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyButton(
                                text: "Back",
                                buttonMethod: navigateBackToMain,
                              ),
                              MyButton(
                                text: "Apply",
                                buttonMethod: navigateToMain,
                              ),
                            ]))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
