import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../../../Widgets/Global Widgets/customText.dart';
import '../../../Widgets/Global Widgets/loadingWidget.dart';
import '../Provider/LeaveFormProvider.dart';

Future confirmLeaveBox(
    File? file,
    BuildContext context,
    String teamHeadId,
    teamHeadEmail,
    teamHeadName,
    initialDate,
    endDate,
    totalDays,
    description) async {
  // Capture the Provider value before the dialog dismisses

  // Show the confirm dialog
  bool shouldProceed = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Confirm Leave Application",
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: blackColor,
              fontSize: screenWidth / 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        content: Builder(builder: (context) {
          return Container(
            padding: EdgeInsets.all(0),
            width: screenWidth * 0.85,
            child: Row(
              children: [
                Flexible(
                  child: customText(text: "Are you sure you want to apply for Leave?",
                      fontSize: screenWidth/22,
                      fontColor: blackColor),
                ),
              ],
            ),
          );
        }),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context, false);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(screenWidth / 20),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.systemGrey2,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: screenWidth / 80,
                      horizontal: screenWidth / 10),
                  child: customText(text:"No", fontSize:screenWidth / 22, fontColor:blackColor,),
                ),
              ),
              SizedBox(width: screenWidth / 50),
              InkWell(
                onTap: () {
                  Navigator.pop(
                      context, true); // Indicate that the user confirmed
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(screenWidth / 20),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.systemGrey2,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: screenWidth / 80,
                      horizontal: screenWidth / 10),
                  child:  customText(text:"Yes", fontSize:screenWidth / 22, fontColor:blackColor,),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
  if (shouldProceed == true) {
    // Show the loading dialog
    showLoaderDialog(context);
    await Provider.of<LeaveFormProvider>(context,listen: false).applyForLeave(
        file,
        context,
        teamHeadId,
        teamHeadEmail,
        teamHeadName,
        initialDate,
        endDate,
        totalDays,
        description,

    );
    Navigator.pop(context);
  }
  else{
    Provider.of<LeaveFormProvider>(context).setisSuccessful(false);
  }
}

