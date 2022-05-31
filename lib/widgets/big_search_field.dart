import 'package:flutter/material.dart';

class BigSearchField extends StatefulWidget {
  final Function returnSearch;

  const BigSearchField({
    Key? key,
    required this.returnSearch,
  }) : super(key: key);

  @override
  State<BigSearchField> createState() => _BigSearchFieldState();
}

class _BigSearchFieldState extends State<BigSearchField> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: const Color(0xFFCAEEE4),
        border: Border.all(color: const Color(0xFF2B6086), width: 2),
      ),
      child: Center(
          child: TextField(
        controller: searchController,
        style: const TextStyle(
          color: Color(0xFF1A759F),
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: const Color(0xFF1A759F).withOpacity(0.5), width: 2),
          ),
          hintStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A759F).withOpacity(0.5),
          ),
          hintText: "Search",
          suffixIcon: Icon(
            Icons.search,
            color: const Color(0xFF1A759F).withOpacity(0.5),
          ),
        ),
        onSubmitted: (value) {
          widget.returnSearch(searchController.text);
        },
      )),
    );
  }
}
