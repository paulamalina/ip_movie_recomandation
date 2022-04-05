import 'package:flutter/material.dart';
import 'package:ip_movie_recomandation/widgets/MyTextField.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create account'),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(hintText: 'Paula Malina', text: 'Name',),
              SizedBox(
                height: 10,
              ),
              MyTextField(hintText: 'pastraguspaula@gmail.com', text: 'Email',),
              SizedBox(
                height: 10,
              ),
              MyTextField(hintText: '1234:)', text: 'Password',obsureText: true,)

            ],
          ),
        ),
      ),
    );
  }
}