import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ip_movie_recomandation/widgets/BigSearchField.dart';

class SmallSearchField extends StatefulWidget {
  const SmallSearchField({
    Key? key,
  }) : super(key: key);

  @override
  State<SmallSearchField> createState() => _SmallSearchField();
}

enum SmallSearchIcon { itemOne, itemTwo, itemThree, itemFour }

class _SmallSearchField extends State<SmallSearchField> {
  bool popUpIsOpen = false;

  void updatePopUpState() {
    if (popUpIsOpen == true) {
      setState(() {
        popUpIsOpen = false;
      });
    } else {
      setState(() {
        popUpIsOpen = true;
      });
    }
  }

  void showOrCloseSearchPopUp() {
    updatePopUpState();
    if (popUpIsOpen == true) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SmallSearchIcon>(
        // Callback that sets the selected popup menu item.
        //icon: const Icon(Icons.search),
        icon: const Icon(
          Icons.search,
          color: Color(0xFFCAEEE4),
        ),
        onSelected: (SmallSearchIcon item) {
          setState(() {});
        },
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<SmallSearchIcon>>[
              PopupMenuItem(
                  value: SmallSearchIcon.itemOne,
                  child: Container(
                    color: Colors.red,
                    child: BigSearchField(
                      returnSearch: () {},
                    ),
                  ))
            ]);

    Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Color(0xFFCAEEE4),
        border: Border.all(color: Color(0xFF2B6086), width: 2),
      ),
      child: Center(
          child: IconButton(
        icon: const Icon(Icons.search),
        color: Color(0xFF1A759F).withOpacity(0.5),
        onPressed: () {
          showOrCloseSearchPopUp();
        },
      )),
    );
  }
}
