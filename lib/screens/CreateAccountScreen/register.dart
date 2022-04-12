import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ip_movie_recomandation/request/model.dart';
import 'package:ip_movie_recomandation/widgets/MyTextField.dart';
import 'package:http/http.dart' as http;
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final myNameController = TextEditingController();
  final myPasswordController= TextEditingController();
  final myEmailController=TextEditingController();
  final myGenderController=TextEditingController();
  final myBirthdateController=TextEditingController();
  final myCountryController=TextEditingController();
  final myPhoneNumberController=TextEditingController();


  Future<Object> createUser() async{
    final Uri apiUrl=Uri.parse("http://localhost:8090/api/register");
    final response=await http.post(apiUrl, body: jsonEncode({
      "name": "Paula",
      "email": "ex@gmail.com",
      "password": "1234",
      "gender": "F",
      "birthdate": "11.06.2002",
      "country": "Romania",
      "phoneNumber": "0758000000",
    }),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      "Content-Type":"application/json",
    });

    if(response.statusCode==200){
      final String responseString=response.body;
      print("ok");
      return modelFromJson(responseString);
    }else{
      print("notok");
      return 1;
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
  @override
  Widget build(BuildContext context) {
    print(myNameController.text);
    return Scaffold(
      backgroundColor: Color(0xFF34A0A4),
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(hintText: 'Paula Malina', text: 'Name',controller: myNameController,),
              SizedBox(
                height: 10,
              ),
              MyTextField(hintText: 'pastraguspaula@gmail.com', text: 'Email',controller: myEmailController,),
              SizedBox(
                height: 10,
              ),
              MyTextField(hintText: '1234:)', text: 'Password',obscureText: true, controller: myPasswordController,),
              SizedBox(
                height: 10,
              ),
              MyTextField(hintText: 'M/F', text: 'Gender', controller: myGenderController,),
              SizedBox(
                height: 10,
              ),
              MyTextField(hintText: '14.02.2001', text: 'Birthdate', controller: myBirthdateController,),
              SizedBox(
                height: 10,
              ),
              MyTextField(hintText: 'Romania', text: 'Country', controller: myCountryController,),
              SizedBox(
                height: 10,
              ),
              MyTextField(hintText: '07xx xxx xxx', text: 'Phone Number', controller: myPhoneNumberController,),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.greenAccent,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      } ,
                      child: Text('Back',style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.greenAccent,
                    ),
                    child: TextButton(
                      onPressed: () {
                        createUser();
                        Navigator.pushNamed(context, "/main");
                      } ,
                      child: Text('Next',style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}