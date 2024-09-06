import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Attendance%20Screen/Provider/attendanceProvider.dart';

import '../../../Utills/Global Class/ColorHelper.dart';

class SimpleCustomCard extends StatelessWidget {
  final String label;
  final String progressValue;
  final Color color;
  final Color headingColor;
  final Color backgroundColor;
  final double screenWidth;
  final double screenHeight;

  SimpleCustomCard({
    required this.label,
    required this.progressValue,
    required this.color,
    required this.headingColor,
    required this.backgroundColor,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight/8,
      width: screenWidth/2.3,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              spreadRadius: 0.1,
                blurRadius: 5,
                offset: Offset(2,2),
              color: lightBlackColor
            )
          ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(progressValue,
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: headingColor,
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth/24
                    )
                ),),
          Text("${label}",
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color:color,
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth/28
                )
            ),),

        ],
      ),
    );
  }
}



