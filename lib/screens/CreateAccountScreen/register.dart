import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ip_movie_recomandation/request/model.dart';
import 'package:ip_movie_recomandation/widgets/MyTextField.dart';
import 'package:ip_movie_recomandation/widgets/MyButton.dart';
import 'package:http/http.dart' as http;

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

  Future<Object> createUser() async {
    print("sunt in functie");
    final Uri apiUrl =
        Uri.parse("http://157.230.114.95:8090/api/user/register");
    final response = await http.post(apiUrl,
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "gender": gender,
          "birthdate": birthday,
          "country": country,
          "phoneNumber": phoneNumber,
        }),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type": "application/json",
        });

    print(response.request);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print("ok");
      return modelFromJson(responseString);
    } else {
      print(response.statusCode);
      return 1;
    }
  }

  double containerWidth = 700;
  double containerHeight = 850;
  double padding = 20.0;
  String name = "";
  String email = "";
  String password = "";
  String gender = "";
  String birthday = "";
  String country = "";
  String phoneNumber = "";
  bool isSmallScreen = false;
  bool isLargeScreen = true;
  void setValue() {
    if (MediaQuery.of(context).size.width >= 700) {
      setState(() {
        padding = 20.0;
        containerWidth = 700;
        containerHeight = 850;
        isSmallScreen = false;
        isLargeScreen = true;
      });
    } else {
      setState(() {
        padding = 0;
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
    if (_formKey.currentState!.validate()) {
      createUser();
      Navigator.pushNamed(context, '/genre');
    }
  }

  @override
  Widget build(BuildContext context) {
    setValue();
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
              padding: EdgeInsets.all(padding),
              child: Container(
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
                          name = myNameController.text;
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
                          email = myEmailController.text;
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
                          password = myPasswordController.text;
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
                          gender = myGenderController.text;
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
                          birthday = myBirthdateController.text;
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
                          country = myCountryController.text;
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
                          phoneNumber = myPhoneNumberController.text;
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
