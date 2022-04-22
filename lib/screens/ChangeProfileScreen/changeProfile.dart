import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/MyTextField.dart';

class ChangeProfieScreen extends StatefulWidget {
  const ChangeProfieScreen({Key? key}) : super(key: key);

  @override
  State<ChangeProfieScreen> createState() => _ChangeProfieScreen();
}

class _ChangeProfieScreen extends State<ChangeProfieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF34A0A4),
      body: Center(
        child: Column(
          children: [
            Container(
                child: Image.asset(
              "/images/logo.png",
              height: 100,
              width: 100,
            )),
            Container(
                child: Text(
              "Change your profile",
              style: TextStyle(
                color: Color(0xFF1A759F),
                fontWeight: FontWeight.bold,
              ),
            )),
            Container(
                child: Center(
                    child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: 300,
                      child: MyTextField(
                          hintText: 'Popescu Maria',
                          text: 'Name',
                          controller: TextEditingController()),
                    ),
                    Container(
                      width: 300,
                      child: MyTextField(
                          hintText: 'popescu.maria@gmail.com',
                          text: 'Email',
                          controller: TextEditingController()),
                    ),
                    Container(
                      width: 300,
                      child: MyTextField(
                          hintText: 'gotta-Hide-It',
                          text: 'Password',
                          controller: TextEditingController()),
                    ),
                    Container(
                      width: 300,
                      child: MyTextField(
                          hintText: '21',
                          text: 'Age',
                          controller: TextEditingController()),
                    ),
                  ],
                ),
                SizedBox(
                  width: 150,
                ),
                Column(
                  children: [
                    Container(
                      width: 300,
                      child: MyTextField(
                          hintText: '12-02-1999',
                          text: 'Birthday',
                          controller: TextEditingController()),
                    ),
                    Container(
                      width: 300,
                      child: MyTextField(
                          hintText: 'Romania',
                          text: 'Country',
                          controller: TextEditingController()),
                    ),
                    Container(
                      width: 300,
                      child: MyTextField(
                          hintText: 'I love movies!',
                          text: 'Bio',
                          controller: TextEditingController()),
                    ),
                  ],
                )
              ],
            ))),
            Container(
                child: SizedBox(
              height: 50,
            )),
            Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Color(0xFFCAEEE4),
                ),
                child: TextButton(
                  onPressed: () {
                    // verify and apply profile changes
                    Navigator.pushNamed(context, '/main');
                  },
                  child: const Text(
                    "Apply",
                    style: TextStyle(
                      color: Color(0xFF1A759F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Container(
                child: SizedBox(
              height: 50,
            )),
            Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Color(0xFFCAEEE4),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/main');
                  },
                  child: const Text(
                    "Back",
                    style: TextStyle(
                      color: Color(0xFF1A759F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
