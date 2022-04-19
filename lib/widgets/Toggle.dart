import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) => Container(
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(50.0),
          isSelected: isSelected,
          fillColor: Color(0xffB5E48C),
          borderWidth: 2,
          borderColor: Colors.white,
          selectedBorderColor: Colors.white,
          color: Colors.white,
          selectedColor: Color(0xFF1A759F),
          renderBorder: true,
          highlightColor: Colors.white,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('Movies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('TV shows',
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
        ),
      );
}
