import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:ip_movie_recomandation/widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import 'package:ip_movie_recomandation/data/data.dart';
import 'package:http/http.dart' as http;

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

  String authToken = token;

  String name = "";
  String email = "";
  int id = -1;

  final myNameController = TextEditingController();
  final myEmailController = TextEditingController();

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
    });
    Navigator.pushNamed(context, '/main');
  }

  void navigateToMain() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/main');
    }
  }

  Future<int> getID() async {
    final Uri apiUrl = Uri.parse("http://157.230.114.95:8090/api/v1/identity");
    final response = await http.get(apiUrl, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      "Content-Type": "application/json",
      "Authorization": token
    });
    var data = jsonDecode(response.body);
    id = data["id"];

    return id;
  }

  void updateUserProfile() async {
    var id2 = await Future.value(getID());

    final Uri apiUrl =
        Uri.parse("http://157.230.114.95:8090/api/v1/users/" + id2.toString());
    final response = await http.put(apiUrl,
        body: jsonEncode(
            {"email": email, "name": name, "profileImageLink": "link"}),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type": "application/json",
          "Authorization": authToken
        });

    if (response.statusCode == 204) {
      showPopUp("Your account was updated!");
      token = response.headers["authorization"] as String;
      navigateToMain();
      return null;
    } else {
      showPopUp("There was a problem!");
    }
  }

  showPopUp(String popUpText) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                popUpText,
                style: const TextStyle(color: Colors.teal),
              ),
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

  void applyAndNavigateToMain() {
    updateUserProfile();
    /*if (_formKey.currentState!.validate()) {
      updateUserProfile();
    }*/
  }

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
                                                !RegExp(r"^(?=.{2,25}$)(\w{2,}(\s?\w{2,})?)$")
                                                    .hasMatch(text))) {
                                          name = myNameController.text;
                                          return "Invalid name";
                                        }
                                        name = myNameController.text;
                                        return null;
                                      },
                                      hintText: 'Popescu Maria',
                                      text: 'Name',
                                      controller: myNameController,
                                      begin: 0.0,
                                      end: 0.5,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MyTextField(
                                      formFieldValidator: (text) {
                                        if (!backWasPressed &&
                                            (text == null ||
                                                text.isEmpty ||
                                                !RegExp(r"^(?=.{5,30})[\w-\.]+@([\w-]+\.)+[\w-]{2,5}$")
                                                    .hasMatch(text))) {
                                          email = myEmailController.text;
                                          return "Invalid email address";
                                        }
                                        email = myEmailController.text;
                                        return null;
                                      },
                                      hintText: 'popescu.maria@gmail.com',
                                      text: 'Email',
                                      controller: myEmailController,
                                      begin: 0.5,
                                      end: 1.0,
                                    ),
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
                                buttonMethod: applyAndNavigateToMain,
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
