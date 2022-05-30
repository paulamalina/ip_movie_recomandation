import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final String text;
  final bool obscureText;
  final FormFieldValidator formFieldValidator;
  final TextEditingController controller;
  final double begin;
  final double end;

  const MyTextField(
      {Key? key,
      required this.formFieldValidator,
      required this.hintText,
      required this.text,
      this.obscureText = false,
      required this.controller,
      required this.begin,
      required this.end,
      })
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  // late final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve:  Interval(widget.begin, widget.end, curve: Curves.fastOutSlowIn),
  // );

  late Animation<double> fadeInAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(widget.begin, widget.end, curve: Curves.fastOutSlowIn)));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeInAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BorderedText(
            strokeWidth: 4.0,
            strokeColor: const Color(0xFF2B6086),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Color(0xFFCAEEE4),
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: const Color(0xFFEDF8FF),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: const Color(0xFF2B6086), width: 2),
            ),
            child: TextFormField(
              validator: widget.formFieldValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              maxLines: 1,
              controller: widget.controller,
              obscureText: widget.obscureText,
              cursorColor: const Color(0xFF34A0A4),
              style: const TextStyle(
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF34A0A4),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                hintStyle: const TextStyle(
                  color: Color(0xFFBBBFC2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
