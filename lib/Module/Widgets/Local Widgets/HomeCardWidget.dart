import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCard extends StatelessWidget {
  final String labelText;
  final String labelText2;
  final Color fontPrimaryColor;
  final Color backgroundColor;
  final double screenWidth;
  final double screenHeight;

  HomeCard({
    required this.labelText,
    required this.labelText2,
    required this.fontPrimaryColor,
    required this.backgroundColor,
    required this.screenWidth,
    required this.screenHeight,
  });
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: screenWidth/2.3,
      height: screenHeight/10,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${labelText}",style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  color: fontPrimaryColor,
                  fontSize: screenWidth/20,
                  fontWeight: FontWeight.bold
              )
          ),),
          Text("${labelText2}",style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  fontSize: screenWidth/20,
                  fontWeight: FontWeight.bold
              )
          ),),
        ],
      ),
    );
  }
}