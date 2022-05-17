import 'dart:convert';

import 'dart:ui';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ip_movie_recomandation/screens/RatingScreen/rating.dart';
import 'package:ip_movie_recomandation/widgets/MyTextField.dart';
import 'package:ip_movie_recomandation/widgets/MyButton.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../GenreScreen/genre.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final myNameController = TextEditingController();
  final myPasswordController = TextEditingController();
  final myEmailController = TextEditingController();
  final myGenderController = TextEditingController();
  final myBirthdateController = TextEditingController();
  final myCountryController = TextEditingController();
  final myPhoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String authorizationToken = "token";

  bool isPressed = false;
  bool isFinish = false;
  String get AuthorizationToken => authorizationToken;

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              isFinish = true;
            });
            Navigator.of(context).pop(true);
          });
          return alert;
        });
  }

  bool isLoading = true;

  void logUser() async {
    final Uri apiUrl = Uri.parse("http://157.230.114.95:8090/api/v1/login");
    final response = await http.post(apiUrl,
        body: jsonEncode({
          "email": "stefanmihalache1302@gmail.com",
          "password": "123456789"
        }),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type": "application/json",
        });

    print("-----");
    print("${response.headers["authorization"]}");
    authorizationToken = response.headers["authorization"] as String;

    print("-----");
    if (response.statusCode == 200) {
      print("ok, am fost logat cu succes");
    } else {
      print("not ok, nu am fost logat cu succes");
      print(response.statusCode);
    }
  }

  Future<Object> createUser() async {
    // print("sunt in functie");
    // final Uri apiUrl =
    //     Uri.parse("http://157.230.114.95:8090/api/v1/user/register");
    // final response = await http.post(apiUrl,
    //     body: jsonEncode({
    //       "email": "maria16@gmail.com",
    //       "name": "Maria",
    //       "password": "1234567890",
    //       "gender": "F",
    //       "birthdate": "2002-06-11",
    //       "country": "ro",
    //       "phoneNumber": "0748104800"
    //
    //     }),
    //     headers: {
    //       "Access-Control-Allow-Origin": "*",
    //       "Access-Control-Allow-Methods":
    //           "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    //       "Content-Type": "application/json",
    //     });

    // print(response.request);
    // if (response.statusCode == 201) {
    //   final String responseString = response.body;
    //   print("ok");
    //   print(responseString);
    //   Map<String, String> responseHearders=response.headers;
    //   print(responseHearders.toString());
    //   logUser();
    //   return modelFromJson(responseString);
    // } else {
    //   print(response.statusCode);
    //   return 1;
    // }

    logUser();
    return 1;
  }

  double containerWidth = 700;
  double containerHeight = 850;
  String name = "Paula";
  String email = "pastraguspaula@gmail.com";
  String password = "anaaremere";
  String gender = "F";
  String birthday = "2001-02-14";
  String country = "Romania";
  String phoneNumber = "0758000000";
  bool isSmallScreen = false;
  bool isLargeScreen = true;

  void setValue() {
    if (MediaQuery.of(context).size.width >= 700) {
      setState(() {
        containerWidth = 700;
        containerHeight = 850;
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myNameController.dispose();
    myPasswordController.dispose();
    myPhoneNumberController.dispose();
    myCountryController.dispose();
    myBirthdateController.dispose();
    myGenderController.dispose();
    myEmailController.dispose();
  }

  void goBack() {
    Navigator.pop(context);
  }

  void register() {
    createUser();

    showLoaderDialog(context); // if(isLoading){
    //   showLoaderDialog(context);
    // }else{
    // if(authorizationToken!="token"){
    //   Navigator.pushNamed(context, "genre");
    // }else{
    //   showLoaderDialog(context);
    // }
    // if(isFinish){
    //   Navigator.push(context, MaterialPageRoute(
    //     builder: (context) => GenreScreen(),
    //     settings: RouteSettings(
    //       arguments: authorizationToken,
    //     ),
    //   ),
    //   );
    // }
    if (_formKey.currentState!.validate()) {
      createUser();
      Navigator.pushNamed(context, '/genre');
    }
  }

  @override
  Widget build(BuildContext context) {
    setValue();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      if (isFinish) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GenreScreen(),
            settings: RouteSettings(
              arguments: authorizationToken,
            ),
          ),
        );
      }
    });
    // if(isFinish){
    //   Navigator.push(context, MaterialPageRoute(
    //     builder: (context) => GenreScreen(),
    //     settings: RouteSettings(
    //       arguments: authorizationToken,
    //     ),
    //   ),
    //   );
    // }
    // if(authorizationToken!="token"){
    //   Navigator.push(context, MaterialPageRoute(
    //     builder: (context) => GenreScreen(),
    //     settings: RouteSettings(
    //       arguments: authorizationToken,
    //     ),
    //   ),
    //   );
    // }else{
    //   if(isPressed)
    //   showLoaderDialog(context);
    // }
    //register();
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF99D98C),
        gradient: LinearGradient(
          colors: [Colors.white, Color.fromRGBO(52, 160, 164, 1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                //height: containerHeight,
                width: containerWidth,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius:
                      isLargeScreen ? BorderRadius.circular(50) : null,
                  boxShadow: isLargeScreen
                      ? [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 7,
                          ),
                        ]
                      : null,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SvgPicture.asset(
                            "assets/images/LogoSvg2.svg",
                            height: 100,
                          ),
                        ),
                      ),
                      Center(
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
                        controller: myNameController,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
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
                        hintText: 'name@gmail.com',
                        text: 'Email',
                        controller: myEmailController,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: MyTextField(
                        //12+ caractere, cel putin o cifra, o litera mare, o litera mica, un caracter special
                        formFieldValidator: (text) {
                          if (text == null ||
                              text.isEmpty ||
                              !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&_]{12,}$")
                                  .hasMatch(text)) {
                            return "Invalid password";
                          }
                          return null;
                        },
                        hintText: 'password',
                        text: 'Password',
                        obscureText: true,
                        controller: myPasswordController,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: MyTextField(
                        formFieldValidator: (text) {
                          if (text == null ||
                              text.isEmpty ||
                              !RegExp(r"(M|F)").hasMatch(text)) {
                            return "Invalid gender";
                          }
                          return null;
                        },
                        hintText: 'M/F',
                        text: 'Gender',
                        controller: myGenderController,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: MyTextField(
                        //februarie are tot timpul 29 de zile!
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
                        controller: myBirthdateController,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
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
                        controller: myCountryController,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: MyTextField(
                        formFieldValidator: (text) {
                          if (text == null ||
                              text.isEmpty ||
                              !RegExp(r"^07[0-9]{8}$").hasMatch(text)) {
                            return "Invalid phone number";
                          }
                          return null;
                        },
                        hintText: '07xxxxxxxx',
                        text: 'Phone Number',
                        controller: myPhoneNumberController,
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyButton(
                              text: "Back",
                              buttonMethod: goBack,
                            ),
                            MyButton(
                              text: 'Register',
                              buttonMethod: register,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
