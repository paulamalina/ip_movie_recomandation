import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:bordered_text/bordered_text.dart';
import 'package:ip_movie_recomandation/widgets/MyButton.dart';

import '../../widgets/MyTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  void logUser() async{
    final Uri apiUrl=Uri.parse("http://157.230.114.95:8090/login");
    final response=await http.post(apiUrl, body: jsonEncode({
      "username": "Malina",
      "password": "1234xyz",
    }),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type":"application/json",
        });

    if(response.statusCode==200){
      print("ok, am fost logat cu succes");
    }else{
      print("not ok, nu am fost logat cu succes");
    }
  }
  double containerWidth=600;
  double containerHeight=600;
  bool isSmallScreen=false;
  bool isLargeScreen=true;
  void setValue(){
    if(MediaQuery.of(context).size.width >= 700){
      setState(() {
        containerWidth=600;
        containerHeight=600;
        isSmallScreen=false;
        isLargeScreen=true;
      });
    }else{
      setState(() {
        containerWidth=double.infinity;
        containerHeight=double.infinity;
        isSmallScreen=true;
        isLargeScreen=false;

      });
    }
  }
   void navigateToChoose() {
    Navigator.pushNamed(context, "/choose");
  }
   void navigateToDetails() {
    Navigator.pushNamed(context, "/details");
  }


  final myNameController = TextEditingController();
  final myPasswordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    setValue();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white, Color.fromRGBO(52, 160, 164, 1)
          ],
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
              color: Colors.teal,
              borderRadius: isLargeScreen ? BorderRadius.circular(50) : null,
              boxShadow: isLargeScreen ? [
                BoxShadow(
                   blurRadius: 7,
                  spreadRadius: 2,
                ),
              ] : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    //child: SvgPicture.asset('assets/images/logoClean.svg', width: 300, height: 200,),
                    child: Image.asset('assets/images/logo.png', height: 100,),
                  ),
                ),
                SizedBox(
                  height: 85,
                ),
                Container(
                  width: 300,
                    child: MyTextField(hintText: 'Popescu Maria', text: 'Name', controller: myNameController),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 300,
                    child: MyTextField(hintText: 'password', text: 'Password', controller: myPasswordController, obscureText: true),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(                        
                        child: MyButton(
                          text: 'Back',
                        buttonMethod: navigateToChoose,
                        ),
                      ),
                      Container(
                        child: MyButton(
                          text: 'Login',
                        buttonMethod: navigateToDetails,
                          ),
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