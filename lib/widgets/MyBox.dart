
import 'package:flutter/material.dart';

class MyBox extends StatefulWidget {
  final String text;
  const MyBox({Key? key, required this.text}) : super(key: key);

  @override
  State<MyBox> createState() => _MyBoxState();
}

class _MyBoxState extends State<MyBox> {
  Color boxColor = Color.fromRGBO(202, 238, 228, 1);
  Color boxColorPressed = Color(0xffC5EAA4);
  Color currentBoxCol = Color(0xffC5EAA4);
  bool ispressed = false;

  void updateValue() {
    if (ispressed) {
      setState(() {
        currentBoxCol = Color.fromARGB(255, 121, 234, 202);
      });
    } else {
      setState(() {
        currentBoxCol = Color(0xffCAEEE4);
      });
    }
  }

 @override
  Widget build(BuildContext context) { 
    updateValue();
    return 
    InkWell(
      child:
      Container(
        width: 300,
        height: 92,
        padding: EdgeInsets.only(left: 30, right: 30),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), 
              ),
            ],
            borderRadius: BorderRadius.circular(30.0),
            color: currentBoxCol,
        ),
        child: Center(
          child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 23,
                  color: Color(0xff168AAD),
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        ),
    
    onTap:(){
      setState(() {
        ispressed = !ispressed;
      });
    },
    );
    
  }
}