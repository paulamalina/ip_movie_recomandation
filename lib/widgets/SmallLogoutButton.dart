import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallLogoutButton extends StatelessWidget {
  const SmallLogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      color: Color(0xFF1A759F).withOpacity(0.5),
      onPressed: () {
        Navigator.pushNamed(context, '/choose');
      },
    );
  }
}
