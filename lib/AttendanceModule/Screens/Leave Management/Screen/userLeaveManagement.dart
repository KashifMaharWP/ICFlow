import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Leave%20Management/Widget/WrapTextWidget_AB.dart';

import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../../Attendance Screen/Widgets/SimpleCard.dart';
import '../../LeaveForm Screen/LeaveFormScreen.dart';


class userLeaveManagement extends StatefulWidget {
  const userLeaveManagement({super.key});

  @override
  State<userLeaveManagement> createState() => _userLeaveManagementState();
}

class _userLeaveManagementState extends State<userLeaveManagement> {
  @override
  Future OpenApplyLeave()=>showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text("Application Status",style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: blackColor,
                fontSize: screenWidth/20,
                fontWeight: FontWeight.w500
            )
        ),),
        content: Builder(builder: (context){
          return Container(
            height: screenHeight/10,
            width: screenWidth*0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WrapText(title: "Approved Days", value: " 2"),
                WrapText(title: "Start from", value: " ${DateFormat('EEE dd MMM yyyy').format(DateTime.now())}"),
                WrapText(title: "Re-joining Date", value: " ${DateFormat('EEE dd MMM yy').format(DateTime.now())}"),
              ],
            ),
          );
        }),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text("data"),
          ),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
            }, child: Text("OK",style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  color: primary,
                  fontSize: screenWidth/28,
                  fontWeight: FontWeight.w500
              )
          ),)
          )
        ],
      )
  );

  void applyForLeave(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveFormScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave",style: GoogleFonts.roboto(
            textStyle: TextStyle(
                fontSize: screenWidth/15,
                fontWeight: FontWeight.bold,
                color: primary
            )
        ),),
      ),

      body: Column(
        children: [
           Stack(
              children: [
                Container(
                  height: screenHeight/3.5,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                            color: lightBlackColor,
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: Offset(2, 4)
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(screenWidth/20),
                        bottomLeft: Radius.circular(screenWidth/20),
                      )
                  ),),

                Positioned(
                  top: screenHeight/14,
                  left: screenWidth/13,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width:screenWidth*0.85,
                        height: screenHeight/8,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: lightBlackColor,
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  offset: Offset(2, 4)
                              ),
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundColor: whiteColor,
                                radius: screenWidth/16,
                                child: Icon(
                                  FontAwesomeIcons.fileCircleCheck,
                                  color: lightBlackColor,
                                )),
                            Text("You Have 2 Leave Balance",style: GoogleFonts.roboto(
                                color: whiteColor,
                                fontSize: screenWidth/22,
                                fontWeight: FontWeight.w600
                            ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight/6,
                  left: screenWidth*0.84,
                  child: InkWell(
                    onTap: (){
                      applyForLeave();
                    },
                    child: CircleAvatar(
                        backgroundColor: lightBlackColor,
                        radius: screenWidth/15,
                        child: Icon(
                          FontAwesomeIcons.plus,
                        color: whiteColor,
                        ),
                      ),
                    ),

                )
              ],
            ),

          SizedBox(
            height: screenHeight/20,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth/20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("${DateFormat(' MMMM').format(DateTime.now())} Status",style: GoogleFonts.roboto(
                      textStyle:TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize:screenWidth/15,
                      )
                  ),),
                ),
                SizedBox(
                  height: 5,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleCustomCard(
                      label: "Early Leave",
                      progressValue: "8",
                      color: blackColor,
                      headingColor: primary,
                      backgroundColor: whiteColor,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,

                    ),
                    SimpleCustomCard(
                      label: "On Time",
                      progressValue: "20",
                      color: blackColor,
                      headingColor: primary,
                      backgroundColor: whiteColor,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                  ],
                ),

                SizedBox(
                  height: screenHeight/35,
                ),

              ],
            ),
          ),

          SizedBox(
            height: screenHeight/20,
          ),

          Expanded(
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenWidth/20),
                  topRight: Radius.circular(screenWidth/20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: lightBlackColor,
                    offset: Offset(-2, -2),
                    blurRadius: 8
                  )
                ]
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight/80,),
                  Text("Leave Application Status",style: GoogleFonts.roboto(
                      textStyle:TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize:screenWidth/15,
                      )
                  ),),
                  SizedBox(height: screenHeight/80,),

                  Container(
                    width: screenWidth,
                    height: 1,
                    color: CupertinoColors.systemGrey2,
                  ),
                  SizedBox(height: screenHeight/80,),

                  Expanded(
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: OpenApplyLeave,
                            child: Container(
                              margin: EdgeInsets.all(screenWidth/50),
                              padding: EdgeInsets.symmetric(vertical: 10,),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(screenWidth/20),
                                boxShadow: [
                                  BoxShadow(
                                    color: CupertinoColors.systemGrey2,
                                    offset: Offset(2, 2),
                                    blurRadius: 10
                                  )
                                ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_month),
                                  Text("${DateFormat('EEE dd MMM yyyy').format(DateTime.now())} Applied",style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: primary,
                                          fontSize: screenWidth/28,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: screenWidth/50,horizontal: screenHeight/20),
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: lightBlackColor,
                                            offset: Offset(2, 2),
                                            blurRadius: 5,
                                          )
                                        ]
                                    ),
                                    child: Text("Status",style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: screenWidth/35,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),),
                                  ),
                                ],
                              )
                              /*ListTile(
                                  leading: const Icon(Icons.calendar_month),
                                  trailing: Container(
                                    padding: EdgeInsets.symmetric(vertical: screenWidth/50,horizontal: screenHeight/20),
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: lightBlackColor,
                                          offset: Offset(2, 2),
                                          blurRadius: 5,
                                        )
                                      ]
                                    ),
                                    child: Text("Status",style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        fontSize: screenWidth/35,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),),
                                  ),
                                  title: Text("${DateFormat('EEE dd MMM yyyy').format(DateTime.now())} Applied")),*/
                            ),
                          );
                        }),
                  ),

                ],
              ),
            ),
          )



        ],
      ),
    );
  }
}
