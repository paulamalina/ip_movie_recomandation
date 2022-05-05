import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ip_movie_recomandation/widgets/MyButton.dart';

import '../../widgets/MyTextField.dart';
import '../../widgets/ResponsiveTextField.dart';
import '../../widgets/BioTextField.dart';

class ChangeProfieScreen extends StatefulWidget {
  const ChangeProfieScreen({Key? key}) : super(key: key);

  @override
  State<ChangeProfieScreen> createState() => _ChangeProfieScreen();
}

class _ChangeProfieScreen extends State<ChangeProfieScreen> {
  double containerWidth = 1000;
  double containerHeight = 900;
  bool isSmallScreen = false;
  bool isLargeScreen = true;
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

  void navigateToMain() {
    Navigator.pushNamed(context, '/main');
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
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Image.asset(
                    "/images/logo.png",
                    height: 100,
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    child: Align(
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Center(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                              child: Wrap(
                                spacing: 50,
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: MyTextField(
                                              hintText: 'Popescu Maria',
                                              text: 'Name',
                                              controller:
                                                  TextEditingController()),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: MyTextField(
                                              hintText:
                                                  'popescu.maria@gmail.com',
                                              text: 'Email',
                                              controller:
                                                  TextEditingController()),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: MyTextField(
                                              hintText: 'strongpassword225200',
                                              text: 'Password',
                                              controller:
                                                  TextEditingController()),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: MyTextField(
                                              hintText: 'strongpassword225200',
                                              text: 'Confirm Password',
                                              controller:
                                                  TextEditingController()),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: MyTextField(
                                              hintText: '21',
                                              text: 'Age',
                                              controller:
                                                  TextEditingController()),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: MyTextField(
                                              hintText: '12-02-1999',
                                              text: 'Birthday',
                                              controller:
                                                  TextEditingController()),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: MyTextField(
                                              hintText: 'Romania',
                                              text: 'Country',
                                              controller:
                                                  TextEditingController()),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: MyTextField(
                                              hintText: 'I love movies!',
                                              text: 'Bio',
                                              controller:
                                                  TextEditingController()),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )))),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 70, right: 70),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyButton(
                              text: "Apply",
                              buttonMethod: navigateToMain,
                            ),
                            MyButton(
                              text: "Back",
                              buttonMethod: navigateToMain,
                            )
                          ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
