import 'package:flutter/material.dart';
import 'package:ip_movie_recomandation/widgets/big_search_field.dart';

class SmallSearchField extends StatefulWidget {
  final Function returnSearch;

  const SmallSearchField({
    Key? key,
    required this.returnSearch,
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
    return Theme(
      data: Theme.of(context).copyWith(
        cardColor: Colors.transparent,
        shadowColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: PopupMenuButton<SmallSearchIcon>(
          // Callback that sets the selected popup menu item.
          //icon: const Icon(Icons.search),
          //color: Colors.transparent,
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
                    child: BigSearchField(returnSearch: widget.returnSearch))
              ]),
    );

  }
}
