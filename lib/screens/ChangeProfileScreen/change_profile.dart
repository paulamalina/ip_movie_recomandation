import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:ip_movie_recomandation/widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import 'package:ip_movie_recomandation/data/data.dart';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String email;
  final String name;
  final String role;

  User(
    this.id,
    this.email,
    this.name,
    this.role,
  );
  factory User.fromMap(Map<String, dynamic> json) {
    return User(json['email'], json['id'], json['name'], json['role']);
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['email'], json['id'], json['name'], json['role']);
  }
}

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

    print("LoggedInUser: " + id.toString());

    print(response.body);

    return id;
  }

/*
  Future<int> getID() async {
    String idFromGet = "";
    print("Se va face get la id");

    final response = await http.get(
        Uri.parse('http://157.230.114.95:8090/api/v1/identity'),
        headers: {"Authorization": authToken});

    if (response.statusCode == 200) {
      print("LoggedInUser: " +
          User.fromJson(json.decode(response.body)).id.toString());
      print(User.fromJson(json.decode(response.body)).email);
      print(User.fromJson(json.decode(response.body)).name);

      return User.fromJson(json.decode(response.body)).id.toInt();
    } else {
      throw Exception("Error getting logged user id!");
    }
  }*/

  void updateUserProfile() async {
    //id = getID();
    var id2 = await Future.value(getID());

    print("id-ul dupa get este: " + id2.toString());

    final Uri apiUrl =
        Uri.parse("http://157.230.114.95:8090/api/v1/users/" + id2.toString());
    final response = await http.put(apiUrl,
        body: jsonEncode({
          "email": email,
          "name": name,
        }),
        headers: {"Authorization": authToken});

    print(response.statusCode);
    print(apiUrl);
    print("http://157.230.114.95:8090/api/v1/users/" + id2.toString());
    print(response.body);

    if (response.statusCode == 201) {
      print("PUT successfully done");
      navigateToMain();
      return null;
    } else if (response.statusCode == 204) {
      return null;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized to update data!");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden to update data!");
    } else {
      throw Exception("User not found!");
    }
  }

  void applyAndNavigateToMain() {
    if (_formKey.currentState!.validate()) {
      updateUserProfile();
    }
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
                                                !RegExp(r"^[A-Z][a-z]*((-|\s)[A-Z][a-z]*)+$")
                                                    .hasMatch(text))) {
                                          return "Invalid name";
                                        }
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
                                                !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                                                    .hasMatch(text))) {
                                          return "Invalid email address";
                                        }
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
