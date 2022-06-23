import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final controller, hintText, suffixIcon, keyBoardType, secure;
  const TextFieldWidget(
      {required this.controller,
      required this.secure,
      required this.suffixIcon,
      required this.hintText,
      required this.keyBoardType,
      Key? key})
      : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SizedBox(
      width: w * .8,
      child: TextField(
        obscureText: widget.secure,
        controller: widget.controller,
        keyboardType: widget.keyBoardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: Icon(widget.suffixIcon),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
