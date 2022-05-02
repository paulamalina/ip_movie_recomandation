import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/MyTextField.dart';
import '../../widgets/ResponsiveTextField.dart';
import '../../widgets/BioTextField.dart';

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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
                child: Image.asset(
              "/images/logo.png",
              height: MediaQuery.of(context).size.height * 0.15,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              decoration: BoxDecoration(),
              child: FittedBox(
                  child: Text(
                "Change your profile",
                style: TextStyle(
                  color: Color(0xFFB5E48C),
                ),
              )),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
                child: Center(
                    child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.11,
                      child: ResponsiveTextField(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width * 0.2,
                          hintText: 'Popescu Maria',
                          text: 'Name',
                          controller: TextEditingController()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.11,
                      child: ResponsiveTextField(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width * 0.2,
                          hintText: 'popescu.maria@gmail.com',
                          text: 'Email',
                          controller: TextEditingController()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.11,
                      child: ResponsiveTextField(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width * 0.2,
                          hintText: 'strongpassword225200',
                          text: 'Password',
                          controller: TextEditingController()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.11,
                      child: ResponsiveTextField(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width * 0.2,
                          hintText: '21',
                          text: 'Age',
                          controller: TextEditingController()),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.11,
                      child: ResponsiveTextField(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width * 0.2,
                          hintText: '12-02-1999',
                          text: 'Birthday',
                          controller: TextEditingController()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.11,
                      child: ResponsiveTextField(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width * 0.2,
                          hintText: 'Romania',
                          text: 'Country',
                          controller: TextEditingController()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: BioTextField(
                          height: MediaQuery.of(context).size.height * 0.37,
                          width: MediaQuery.of(context).size.width * 0.2,
                          textHeight:
                              MediaQuery.of(context).size.height * 0.031,
                          hintText: 'I love movies!',
                          text: 'Bio',
                          controller: TextEditingController()),
                    ),
                  ],
                )
              ],
            ))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.04,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.04,
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
