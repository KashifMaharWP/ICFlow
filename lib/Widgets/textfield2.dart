import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextFieldWidget2 extends StatefulWidget {
  TextFieldWidget2(
      {super.key,
      required this.widgetcontroller,
      required this.fieldName,
        this.widgeticon,
      required  this.isPasswordField,
      this.keyboardtype,
      });

  //SETTING THE PARAMETER FOR THE widgets
  TextEditingController widgetcontroller = TextEditingController();
  IconData? widgeticon;
  String fieldName = "sample";
  bool isPasswordField = false;
  TextInputType? keyboardtype = TextInputType.text;

  @override
  State<TextFieldWidget2> createState() => TextFieldWidget2State();
}

class TextFieldWidget2State extends State<TextFieldWidget2> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      color: Colors.white.withOpacity(0.7),
      shadowColor: Colors.red.shade700.withOpacity(0.3),
      child: TextFormField(
          obscureText: widget.isPasswordField
              ? showPassword
              ? false
              : true
              : false,
        scrollPhysics: const BouncingScrollPhysics(),
        keyboardType: widget.keyboardtype,
        controller: widget.widgetcontroller,
        decoration: InputDecoration(
            //prefixIcon: Icon(widget.widgeticon),
            suffixIcon: widget.isPasswordField
                ? GestureDetector(
                onTap: () {
                  setState(() {
                    showPassword = showPassword ? false : true;
                  });
                },
                child: Icon(showPassword
                    ? CupertinoIcons.lock_open_fill
                    : CupertinoIcons.lock_fill))
                : const IgnorePointer(),
            hintText: widget.fieldName,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1))
            //label: Text(widget.fieldName),
            ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your ${widget.fieldName}";
          }
          return null;
        },
      ),
    );
  }
}
