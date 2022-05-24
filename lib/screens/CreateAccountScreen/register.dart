import 'dart:convert';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ip_movie_recomandation/data/data.dart';
import 'package:ip_movie_recomandation/screens/RatingScreen/rating.dart';
import 'package:ip_movie_recomandation/widgets/MyTextField.dart';
import 'package:ip_movie_recomandation/widgets/MyButton.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../models/movieListModel.dart';
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

  double containerWidth = 700;
  double containerHeight = 850;
  bool isSmallScreen = false;
  bool isLargeScreen = true;
  bool isPressed = false;
  bool isFinish = false;
  bool isLoading = true;

  String email="";
  String password="";
  String gender="";
  String name="";
  String birthday="";
  String phoneNumber="";
  String country="";

  String errorText="Error registering user!";

  showLoaderDialog(BuildContext context) {
    createUser();
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
            Navigator.of(context).pop(true);
            if(isCreatedUser){
              Navigator.pushNamed(context, '/genre');
            }else{
              showAlert(context);
            }
          });
          return alert;
        });
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(errorText),
          actions: [
            TextButton(                     // FlatButton widget is used to make a text to work like a button
              onPressed: () {
                Navigator.of(context).pop(true);              },             // function used to perform after pressing the button
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);              },
              child: Text('OK'),
            ),
          ],
        ));
  }

  void logUser() async {
    final Uri apiUrl = Uri.parse("http://157.230.114.95:8090/api/v1/login");
    final response = await http.post(apiUrl,
        body: jsonEncode({
          "email": email,
          "password": password
        }),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type": "application/json",
        });
    if (response.statusCode == 200) {
      print("ok, am fost logat cu succes");
      token = response.headers["authorization"] as String;
      print("token : " + token);
    } else {
      print("not ok, nu am fost logat cu succes");
      print("Status code la login : ${response.statusCode}");

    }
  }

  bool isCreatedUser=false;
  void createUser() async {
    print("sunt in functie");
    print(email);
    print(name);
    print(password);
    print(gender);
    final Uri apiUrl =
        Uri.parse("http://157.230.114.95:8090/api/v1/users/register");
    final response = await http.post(apiUrl,
        body: jsonEncode({
          "email": email,
          "name": name,
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

    switch(response.statusCode){
      case 201: {
        isCreatedUser=true;
        print("Ok, am fost inregistrat cu succes");
        logUser();
      }
      break;
      case 409: {
        errorText="Email address already in use!";
        isCreatedUser=false;
      }
      break;
      default: {
        print(" eroare la register ${response.statusCode}");
      }
    }
  }

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
    // if (_formKey.currentState!.validate()) {
    //   createUser();
    //   showLoaderDialog(context);
    //   token="";
    //   Navigator.pushNamed(context, '/genre');
    // }else{
    //   print("nu sunt date valide");
    // }
    showLoaderDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    setValue();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (isFinish) {
    //     Navigator.pushNamed(
    //       context, "/genre"
    //     );
    //   }
    // });
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




// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   static const String _title = 'Flutter Code Sample';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: const Center(
//           child: MyStatelessWidget(),
//         ),
//       ),
//     );
//   }
// }
//
// class MyStatelessWidget extends StatelessWidget {
//   const MyStatelessWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () => showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('AlertDialog Title'),
//           content: const Text('AlertDialog description'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.pop(context, 'Cancel'),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, 'OK'),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       ),
//       child: const Text('Show Dialog'),
//     );
//   }
// }