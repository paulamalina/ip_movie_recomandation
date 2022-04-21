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
    print("sunt in functie");
    final Uri apiUrl=Uri.parse("http://157.230.114.95:8090/api/user/register");
    final response=await http.post(apiUrl, body: jsonEncode({
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
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      "Content-Type":"application/json",
    });

    print(response.request);
    if(response.statusCode==200){
      final String responseString=response.body;
      print("ok");
      return modelFromJson(responseString);
    }else{
      print(response.statusCode);
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
    //print(myNameController.text);
    return Scaffold(
      backgroundColor: Color(0xFF99D98C),
      body: ListView(
        children: [
          Container(
            height: 30,
            color: Color(0xFF1A759F),
          ),
          Stack(
            children: [
              Container(
                height: 600,
                decoration: BoxDecoration(
                    color: Color(0xFF1A759F),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))
                ),
              ),
              Positioned(
                  child: Center(
                    child: Container(
                      height: 900,
                      width: 800,
                      decoration: BoxDecoration(
                        color: Color(0xFF34A0A4),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            //child: SvgPicture.asset('assets/images/logoClean.svg', width: 300, height: 200,),
                            child: Image.asset('assets/images/logo.png',  width: 150, height: 100,),
                          ),
                          MyTextField(hintText: 'Popescu Maria', text: 'Name',controller: myNameController,),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextField(hintText: 'name@gmail.com', text: 'Email',controller: myEmailController,),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextField(hintText: 'password', text: 'Password',obscureText: true, controller: myPasswordController,),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextField(hintText: 'M/F', text: 'Gender', controller: myGenderController,),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextField(hintText: 'Year.Month.Day', text: 'Birthdate', controller: myBirthdateController,),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color(0xff52B69A),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      print(myNameController.text);
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
                                  width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color(0xffB5E48C),
                                  ),
                                  child: TextButton(
                                    onPressed: () async{
                                      //createUser();
                                      print("sunt in functie");
                                      try{
                                        final Uri apiUrl=Uri.parse("http://157.230.114.95:53426/api/user/register");
                                        final response=await http.post(apiUrl, body: jsonEncode({
                                          "name": "Ina",
                                          "email": "ina@gmail.com",
                                          "password": "anaaremere",
                                          "gender": "F",
                                          "birthdate": "2001-02-14",
                                          "country": "Romania",
                                          "phoneNumber": "0758000000",
                                        }),
                                            headers: {
                                              "Access-Control-Allow-Origin": "*",
                                              "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
                                              "Content-Type":"application/json",
                                            });

                                        print(response.request);
                                      }catch(e){
                                        print(e);
                                      }

                                      Navigator.pushNamed(context, '/genre');
                                    } ,
                                    child: Text('Register',style: TextStyle(
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
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


