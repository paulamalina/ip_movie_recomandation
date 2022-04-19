
import 'package:flutter/material.dart';

class MyBox extends StatefulWidget {
  final String text;
  const MyBox({Key? key, required this.text}) : super(key: key);

  @override
  State<MyBox> createState() => _MyBoxState();
}

class _MyBoxState extends State<MyBox> {
  Color boxColor = Color(0xffC5EAA4);
  bool ispressed = false;

 @override
  Widget build(BuildContext context) { 
    return Container(
        width: 300,
        height: 92,
        padding: EdgeInsets.only(left: 40, right: 60),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(10.0),
            color: ispressed ? Color(0xffCAEEE4) : boxColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              )
            ),
            TextButton( 
              onPressed: () => setState(() => ispressed = !ispressed),
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 23,
                  color: Color(0xff168AAD),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
    );
  }
}