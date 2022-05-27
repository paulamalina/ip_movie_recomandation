import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:ip_movie_recomandation/widgets/my_button.dart';

import '../../data/data.dart';
import '../../widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isFinish = false;
  bool isLoggedIn = false;

  final _formKey = GlobalKey<FormState>();
  void logUser() async {
    if (kDebugMode) {
      print(email);
    }
    if (kDebugMode) {
      print(password);
    }
    final Uri apiUrl = Uri.parse("http://157.230.114.95:8090/api/v1/login");
    final response = await http.post(apiUrl,
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type": "application/json",
        });

    token = response.headers["authorization"] as String;

    if (kDebugMode) {
      print("Response: ${response.statusCode}");
    }
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("ok, am fost logat cu succes");
      }
      setState(() {
        isLoggedIn = true;
      });
    } else {
      if (kDebugMode) {
        print("not ok, nu am fost logat cu succes");
      }
    }
  }

  showLoaderDialog(BuildContext context) {
    logUser();
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
            if (isLoggedIn) {
              Navigator.pushNamed(context, '/main');
            } else {
              showAlert(context);
            }
          });
          return alert;
        });
  }

  String errorText = "Failed to login!";

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(errorText),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  String email = "";
  String password = "";
  double containerWidth = 600;
  double containerHeight = 600;
  bool isSmallScreen = false;
  bool isLargeScreen = true;
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

  void navigateToChoose() {
    Navigator.pushNamed(context, "/choose");
  }

  void navigateToDetails() {
    if (_formKey.currentState!.validate()) {
      logUser();
      Navigator.pushNamed(context, "/details");
    }
  }

  void login() {
    showLoaderDialog(context);
  }

  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    setValue();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color.fromRGBO(52, 160, 164, 1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Form(
            key: _formKey,
            child: Container(
              height: containerHeight,
              width: containerWidth,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: isLargeScreen ? BorderRadius.circular(50) : null,
                boxShadow: isLargeScreen
                    ? [
                        const BoxShadow(
                          blurRadius: 7,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      //child: SvgPicture.asset('assets/images/logoClean.svg', width: 300, height: 200,),
                      child: SvgPicture.asset(
                        "assets/images/LogoSvg2.svg",
                        height: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 85,
                  ),
                  SizedBox(
                    width: 300,
                    child: MyTextField(
                        formFieldValidator: (text) {
                          email = myEmailController.text;
                          return null;
                        },
                        hintText: 'email@gmail.com',
                        text: 'Email',
                        controller: myEmailController),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: MyTextField(
                        formFieldValidator: (text) {
                          password = myPasswordController.text;
                          return null;
                        },
                        hintText: 'password',
                        text: 'Password',
                        controller: myPasswordController,
                        obscureText: true),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, right: 70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyButton(
                          text: 'Back',
                          buttonMethod: navigateToChoose,
                        ),
                        MyButton(
                          text: 'Login',
                          buttonMethod: () {
                            login();
                          },
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
    );
  }
}
