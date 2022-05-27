import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({Key? key}) : super(key: key);


  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) => ToggleButtons(
    borderRadius: BorderRadius.circular(50.0),
    isSelected: isSelected,
    fillColor: const Color(0xFFCAEEE4),
    borderWidth: 2,
    borderColor: const Color(0xFF2B6086),
    selectedBorderColor: const Color(0xFF2B6086),
    color: const Color(0xFFCAEEE4),
    selectedColor: const Color(0xFF1A759F),
    renderBorder: true,
    highlightColor: Colors.white,
    children: const <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text('Movies',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text('Watch List',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    ],
    onPressed: (int newIndex) {
      setState(() {
        for (int index = 0; index < isSelected.length; index++) {
          if (index == newIndex) {
            isSelected[index] = true;
          } else {
            isSelected[index] = false;
          }
        }
      });
    },
  );
}
