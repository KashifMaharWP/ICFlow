import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget(
      {super.key,
      required this.widgetcontroller,
      required this.fieldName,
      required this.widgeticon,
      required this.isPasswordField,
      this.keyboardtype});

  //SETTING THE PARAMETER FOR THE widgets
  TextEditingController widgetcontroller = TextEditingController();
  IconData widgeticon = CupertinoIcons.alt;
  String fieldName = "sample";
  bool isPasswordField = false;
  TextInputType? keyboardtype = TextInputType.text;

  @override
  State<TextFieldWidget> createState() => TextFieldWidgetState();
}

class TextFieldWidgetState extends State<TextFieldWidget> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardtype,
      obscureText: widget.isPasswordField
          ? showPassword
              ? false
              : true
          : false,
      controller: widget.widgetcontroller,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.widgeticon),
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
        //label: Text(widget.fieldName),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your ${widget.fieldName}";
        }
        return null;
      },
    );
  }
}
