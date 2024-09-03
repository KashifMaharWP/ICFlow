import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';

class WrapText extends StatelessWidget {
final String? title;
final String? value;

WrapText({
  @required this.title,
  @required this.value
});

@override
Widget build(BuildContext context) {
  return Wrap(
      children:[
        Text("${title} :",style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: blackColor,
                fontSize: screenWidth/28,
                fontWeight: FontWeight.w500
            )
        ),),

        Text("${value}",style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: primary,
                fontSize: screenWidth/25,
                fontWeight: FontWeight.w500
            )
        ),),
      ]
  );
}
}