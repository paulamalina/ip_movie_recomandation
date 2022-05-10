import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigSearchField extends StatelessWidget {
  const BigSearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
          color: Color(0xFFCAEEE4),
          border: Border.all(color: Color(0xFF2B6086), width: 2),
      ),
      child: Center(
          child: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color(0xFF1A759F).withOpacity(0.5), width: 2),
          ),
          hintStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A759F).withOpacity(0.5),
          ),
          hintText: "Search",
          suffixIcon: Icon(
            Icons.search,
            color: Color(0xFF1A759F).withOpacity(0.5),
          ),
        ),
      )),
    );
  }
}
