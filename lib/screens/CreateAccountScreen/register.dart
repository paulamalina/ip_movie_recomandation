import 'dart:convert';

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

  Future<Object> createUser() async {
    print("sunt in functie");
    final Uri apiUrl =
        Uri.parse("http://157.230.114.95:8090/api/user/register");
    final response = await http.post(apiUrl,
        body: jsonEncode({
          "name": "Paula",
          "email": "pastraguspaula@gmail.com",
          "password": "anaaremere",
          "gender": "F",
          "birthdate": "2001-02-14",
          "country": "Romania",
          "phoneNumber": "0758000000",
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
    Navigator.pushNamed(context, '/genre');
  }

  @override
  Widget build(BuildContext context) {
    setValue();
    return Container(

      decoration: BoxDecoration(
        color: Color(0xFF99D98C),
        gradient: LinearGradient(
          /*
          colors: [
            Colors.white,
            Color(0xFF99D98C),
          ],
          */
          colors: [Colors.white, Color.fromRGBO(52, 160, 164, 1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              //color: Color(0xFF34A0A4),
              color: Colors.teal,
              borderRadius: isLargeScreen ? BorderRadius.circular(50) : null,
              boxShadow: isLargeScreen
                  ? [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 7,
                      ),
                    ]
                  : null,
            ),
            child: ListView(
              children: [
                Center(
                  //child: SvgPicture.asset('assets/images/logoClean.svg', width: 300, height: 200,),
                  child:  SvgPicture.asset(
                  "assets/images/LogoSvg2.svg", height: 100,
                ),
                ),
                Center(
                    child: MyTextField(
                  hintText: 'Popescu Maria',
                  text: 'Name',
                  controller: myNameController,
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: MyTextField(
                  hintText: 'name@gmail.com',
                  text: 'Email',
                  controller: myEmailController,
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: MyTextField(
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
                  hintText: 'M/F',
                  text: 'Gender',
                  controller: myGenderController,
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: MyTextField(
                  hintText: 'Year.Month.Day',
                  text: 'Birthdate',
                  controller: myBirthdateController,
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: MyTextField(
                  hintText: 'Romania',
                  text: 'Country',
                  controller: myCountryController,
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: MyTextField(
                  hintText: '07xx xxx xxx',
                  text: 'Phone Number',
                  controller: myPhoneNumberController,
                )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
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
    );
  }
}
