import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../widgets/MyTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final myNameController = TextEditingController();
  final myPasswordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('LOGIN SCREEN'),
      // ),
      backgroundColor: Color(0xFF34A0A4),
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(hintText: 'Paula Malina', text: 'Name', controller: myNameController,),
              SizedBox(
                height: 10,
              ),
              MyTextField(hintText: '1234:)', text: 'Password',obscureText: true,controller: myPasswordController,),
            ],
          ),
        ),
      ),
    );
  }
}