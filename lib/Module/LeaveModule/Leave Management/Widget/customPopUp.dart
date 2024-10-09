import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskflow_application/Module/LeaveModule/LeaveForm%20Screen/LeaveFormScreen.dart';
import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../../../Widgets/Global Widgets/customNoBoldText.dart';
import '../../../Widgets/Global Widgets/customText.dart';
import 'WrapTextWidget_AB.dart';

customPopUp(BuildContext context,String description,intialDate,endDate,totalDays)async {
  String message=description;
  AlertDialog alert = AlertDialog(
    title: customText(text: "Leave Status", fontSize: screenWidth/20, fontColor: blackColor),
    backgroundColor: whiteColor,
    content:  Container(
      margin: EdgeInsets.zero,
      width: screenWidth*0.85,
      height: screenHeight/3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(text: "Application for Casual Leave", fontSize: screenWidth/24, fontColor: primary),
          SizedBox(height: screenHeight/40,),
          customNoBoldText(text: "Meesage", fontSize: screenWidth/25, fontColor: blackColor),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: darkgreyColor,width: 1,)
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: customNoBoldText(text: message, fontSize: screenWidth/28, fontColor: blackColor),
              ),
            ),
          ),
          SizedBox(height: screenHeight/40,),
          WrapText(title: "Total Days", value: totalDays),
          WrapText(title: "Start from", value: initialDate.toString()),
          WrapText(title: "Re-joining Date", value: endDate),
        ],
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //DisApprove
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              width: screenWidth/4,
              height: screenHeight/25,
              decoration: BoxDecoration(
                  color: Colors.redAccent.shade100,
                  borderRadius: BorderRadius.circular(screenWidth/40),
                  boxShadow: [
                    BoxShadow(
                        color: CupertinoColors.systemGrey4,
                        offset: Offset(2, 2),
                        blurRadius: 2
                    )
                  ]
              ),
              child: Center(child: customNoBoldText(text: "Dispprove", fontSize: screenWidth/24, fontColor: blackColor)),
            ),
          ),
          //Approve
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              width: screenWidth/4,
              height: screenHeight/25,
              decoration: BoxDecoration(
                  color: Colors.green.shade200,
                  borderRadius: BorderRadius.circular(screenWidth/40),
                  boxShadow: [
                    BoxShadow(
                        color: CupertinoColors.systemGrey2,
                        offset: Offset(2, 2),
                        blurRadius: 2
                    )
                  ]
              ),
              child: Center(child: customNoBoldText(text: "Approve", fontSize: screenWidth/24, fontColor: blackColor)),
            ),
          ),

        ],
      )
    ],
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  
  }
