import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

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
      "username": "radustefan1302@gmail.com",
      "password": "nu fura parola"
    }),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type":"application/json",
        });


  }

  final myNameController = TextEditingController();
  final myPasswordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF99D98C),
      body: Stack(
        children: [
          Container(
            height: 600,
            decoration: BoxDecoration(
                color: Color(0xFF1A759F),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))
            ),
          ),
          Positioned(child: Center(
            child: Container(
              height: 700,
              width: 800,
              decoration: BoxDecoration(
                color: Color(0xFF34A0A4),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      //child: SvgPicture.asset('assets/images/logoClean.svg', width: 300, height: 200,),
                      child: Image.asset('assets/images/logo.png',  width: 250, height: 150,),
                    ),
                  ),
                  SizedBox(
                    height: 85,
                  ),
                  Container(
                    width: 300,
                      child: MyTextField(hintText: 'Paula Malina', text: 'Name', controller: myNameController),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 300,
                      child: MyTextField(hintText: '1234567890', text: 'Password', controller: myPasswordController, obscureText: true),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, right: 70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xff52B69A),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            } ,
                            child: Text('Back',style: TextStyle(
                              color: Color(0xFF34A0A4),
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xffB5E48C),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/main');
                            } ,
                            child: Text('Login',style: TextStyle(
                              color: Color(0xFF1A759F),
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),),
        ],
      ),
    );
  }
}