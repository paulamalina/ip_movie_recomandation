import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

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
  
  final _formKey = GlobalKey<FormState>();
  double containerWidth = 1000;
  double containerHeight = 900;
  bool isSmallScreen = false;
  bool isLargeScreen = true;
  String logo = "assets/images/LogoSvg2.svg";

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
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/main');
    }
  }

  final myPasswordController = TextEditingController();
  
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

            child: Form(
              key: _formKey,
              
              child: Center(  
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      child: SvgPicture.asset(
                        logo,
                        height: 100,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      decoration: BoxDecoration(),
                      child: Align(
                          alignment: Alignment.center,
                          
                          child: BorderedText(
                            strokeWidth: 4.0,
                            strokeColor: Color(0xFF2B6086),
                            child: Text(
                              "Change your profile",
                              
                              style: TextStyle(                          
                                color: Color(0xFFCAEEE4),                              
                                fontSize: 25,
                                
                              ),
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
                                                formFieldValidator: (text) {
                                                  if (text == null ||
                                                      text.isEmpty ||
                                                      !RegExp(r"^[A-Z][a-z]*((-|\s)[A-Z][a-z]*)+$")
                                                          .hasMatch(text)) {
                                                    return "Invalid name";
                                                  }
                                                  return null;
                                                },
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
                                                formFieldValidator: (text) {
                                                  if (text == null ||
                                                      text.isEmpty ||
                                                      !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                                                          .hasMatch(text)) {
                                                    return "Invalid email address";
                                                  }
                                                  return null;
                                                },
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
                                                formFieldValidator: (text) {
                                                  if (text == null ||
                                                      text.isEmpty ||
                                                      !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&_]{12,}$")
                                                          .hasMatch(text)) {
                                                    return "Invalid password";
                                                  }
                                                  return null;
                                                },
                                                obscureText: true,
                                                hintText:
                                                    'strongpassword225200',
                                                text: 'Password',
                                                controller:
                                                    myPasswordController),
                                          ),

                                          SizedBox(
                                            height: 10,
                                          ),

                                          Container(
                                            child: MyTextField(
                                                formFieldValidator: (text) {
                                                  if (text == null ||
                                                      text.isEmpty ||
                                                      text !=
                                                          myPasswordController
                                                              .text ||
                                                      !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&_]{12,}$")
                                                          .hasMatch(text)) {
                                                    return "Invalid password";
                                                  }
                                                  return null;
                                                },
                                                obscureText: true,
                                                hintText:
                                                    'strongpassword225200',
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
                                                formFieldValidator: (text) {
                                                  if (text == null ||
                                                      text.isEmpty ||
                                                      !RegExp(r"^[1-9][0-9]$")
                                                          .hasMatch(text)) {
                                                    return "Invalid age";
                                                  }
                                                  return null;
                                                },
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
                                                formFieldValidator: (text) {
                                                  if (text == null ||
                                                      text.isEmpty ||
                                                      !RegExp(r"^(19[0-9][0-9]|20[0-1][0-9]).(((0[1,3,5,7,8]|1[0,2]).([0-2][0-9]|3[0-1]))|((0[4,5,9]|11).([0-2][0-9]|30))|(02.[0-2][0-9]))$")
                                                          .hasMatch(text)) {
                                                    return "Invalid date";
                                                  }
                                                  return null;
                                                },
                                                hintText: 'Year.Month.Day',
                                                text: 'Birthdate',
                                                controller:
                                                    TextEditingController()),
                                          ),

                                          SizedBox(
                                            height: 10,
                                          ),

                                          Container(
                                            child: MyTextField(
                                                formFieldValidator: (text) {
                                                  if (text == null ||
                                                      text.isEmpty ||
                                                      !RegExp(r"^[A-Z][a-z]*((-|\s)[A-Z][a-z]*)*$")
                                                          .hasMatch(text)) {
                                                    return "Invalid country";
                                                  }
                                                  return null;
                                                },
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
                                                formFieldValidator: (text) {
                                                  if (text == null ||
                                                      text.isEmpty) {
                                                    return 'Invalid bio';
                                                  }
                                                },
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
                                text: "Back",
                                buttonMethod: navigateToMain,
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
