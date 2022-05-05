import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallSearchField extends StatelessWidget {
  const SmallSearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Color(0xffB5E48C),
      ),
      child: Center(
          child: IconButton(
        icon: const Icon(Icons.search),
        color: Color(0xFF1A759F).withOpacity(0.5),
        onPressed: () {
          //call function that displays a searchbar for small screens
        },
      )),
    );
  }
}
