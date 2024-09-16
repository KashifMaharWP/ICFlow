
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class customNoBoldText extends StatefulWidget {
  final double fontSize;
  final Color fontColor;
  final String text;
  const customNoBoldText({
    required this.text,
    required this.fontSize,
    required this.fontColor,

  });

  @override
  State<customNoBoldText> createState() => _customNoBoldTextState();
}

class _customNoBoldTextState extends State<customNoBoldText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text,style: GoogleFonts.nunito(
        textStyle: TextStyle(
            color: widget.fontColor,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.normal
        )
    ),);
  }
}