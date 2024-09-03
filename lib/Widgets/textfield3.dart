import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget3 extends StatefulWidget {
  TextFieldWidget3(
      {super.key,
      required this.title,
      required this.controller,
      required this.maxLine});
  String title;
  TextEditingController controller;
  int maxLine;

  @override
  State<TextFieldWidget3> createState() => _TextFieldWidget3State();
}

class _TextFieldWidget3State extends State<TextFieldWidget3> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLine,
      controller: widget.controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.title,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2),
        ),
      ),
    );
  }
}
