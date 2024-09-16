import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class customText extends StatefulWidget {
  final double fontSize;
  final Color fontColor;
  final String text;
  const customText({
    required this.text,
    required this.fontSize,
    required this.fontColor,

  });

  @override
  State<customText> createState() => _customTextState();
}

class _customTextState extends State<customText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text,style: GoogleFonts.nunito(
        textStyle: TextStyle(
            color: widget.fontColor,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.w500
        )
    ),);
  }
}



