import 'dart:async';
//import 'package:employee_management_app/Model/AttendanceCheckInModel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Attendance%20History/Attendance%20History%20Shimmer/AttendanceHistoryShimmerScreen.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Attendance%20History/Screen/AtdHistoryScreen.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Attendance%20Screen/Functions/CountWeekDays.dart';

import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../Class/CheckInClass.dart';
import '../Functions/Location_Tracker.dart';
import '../Provider/attendanceProvider.dart';
import '../Functions/midNightTimer.dart';
import '../Widgets/SimpleCard.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  String checkIn = '--|--';
  String checkOut = '--|--';
  double progressvalue = 20;
  String CurrentMonth = DateFormat("MMMM").format(DateTime.now());
  int monthWorkingHrs = 0;
  bool load=false;


  @override
  void initState() {
    super.initState();
    final atdProvider = Provider.of<AttendanceProvider>(context, listen: false);
    atdProvider.loadCheckInStatus();
    atdProvider.countTotalWorkedMin(context, CurrentMonth);
  }
  void refresh(){
    final atdProvider = Provider.of<AttendanceProvider>(context, listen: false);
    atdProvider.countTotalWorkedMin(context, CurrentMonth);
    }

  showLoaderDialog(BuildContext context){
    AlertDialog alert = AlertDialog(
      content: Container(
        width: screenWidth / 2, // Set the desired width
        height: screenHeight / 6, // Set the desired height
        child: Center(
          child: LoadingAnimationWidget.hexagonDots(color: primary, size: screenWidth / 5),
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  Future confirmAttendance(String title, BuildContext context) async {
    // Capture the Provider value before the dialog dismisses
    final attendanceProvider = Provider.of<AttendanceProvider>(context, listen: false);
    bool isCheckedIn = attendanceProvider.ischeckedIn;
    bool isLoading=attendanceProvider.isLoading;

    // Show the confirm dialog
    bool shouldProceed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Confirm Attendance",
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
                    child: customText(
                      "Are you sure you want to $title?",
                      screenWidth / 18,
                      blackColor,
                    ),
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
                        vertical: screenWidth / 80, horizontal: screenWidth / 10),
                    child: customText("No", screenWidth / 22, blackColor),
                  ),
                ),
                SizedBox(width: screenWidth / 50),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, true); // Indicate that the user confirmed
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
                        vertical: screenWidth / 80, horizontal: screenWidth / 10),
                    child: customText("Yes", screenWidth / 22, blackColor),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    // If the user confirmed
    if (shouldProceed == true) {
      // Show the loading dialog
      showLoaderDialog(context);
        if (!isCheckedIn) {
          await getCurrentLocationCheckInTime(context);
        } else {
          await getCurrentLocationCheckOutTime(context);
        }
        Navigator.pop(context);

    }
  }



  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Attendance",
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: screenWidth / 15,
                    fontWeight: FontWeight.bold,
                    color: primary)),
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: bodyContainer()
        ),
      );
    }

    //page bodyContainer
    Widget bodyContainer(){
        return Column(
      children: [
        //top Body Container with Today status and view Attendance Button
        topBodyContainer(),

        //Today Check In and Check Out Status
        todayCheckInOutStatus(),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          text: TextSpan(
                              text: DateTime.now().day.toString(),
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: screenWidth / 15,
                                    fontWeight: FontWeight.w500,
                                    color: primary),
                              ),
                              children: [
                                TextSpan(
                                  text: DateFormat(' MMMM yyyy')
                                      .format(DateTime.now()),
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: screenWidth / 18,
                                        fontWeight: FontWeight.w500,
                                        color: lightBlackColor),
                                  ),
                                )
                              ]))),
                  StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1)),
                      builder: (context, snapshot) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            DateFormat('hh:mm:ss:a')
                                .format(DateTime.now()),
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: screenWidth / 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold)),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),

        //Attendance Button Container
        attendanceButton(),
        SizedBox(
          height: screenHeight / 50,
        ),

        monthWorkHrStatus(),

      ],
    ) ;
}

    Widget topBodyContainer(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Today's Status",
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: lightBlackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth / 15,
                )),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AtdHistoryScreen()));
          },
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.solidEye,
                size: screenWidth / 15,
              ),
              SizedBox(
                width: screenWidth / 40,
              ),
              Text(
                "View",
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: screenWidth / 25,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ],
    );
    }

    Widget todayCheckInOutStatus(){
    return Consumer<AttendanceProvider>(
        builder: (context, atdProvider, child) {
          return Container(
            margin: EdgeInsets.only(top: 10, bottom: 30),
            height: 150,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(2, 6))
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Check In",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth / 25)),
                        ),
                        Text(
                          CheckInClass.checkInTime,
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth / 15)),
                        ),
                      ],
                    )),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Check Out",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth / 25)),
                        ),
                        Text(
                          CheckInClass.checkOutTime,
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth / 15)),
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
    }
    Widget attendanceButton(){
      final atdProvider = Provider.of<AttendanceProvider>(context);
    return Container(
        margin: EdgeInsets.zero,
        width: screenWidth/2.3,
        height: screenHeight/4,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: CupertinoColors.systemGrey2,
                offset: Offset(2, 2),
                blurRadius: 4,
                spreadRadius: 2
            )
          ],
          shape: BoxShape.circle,
          gradient: LinearGradient(colors:
          atdProvider.isDisabled==false
              ?atdProvider.ischeckedIn == true
              ? [
            Colors.cyan,
            Colors.blue
          ]
              :[
            Colors.pink,
            Colors.redAccent
          ]:[
            Colors.black12,
            Colors.white38
          ]
          ),
        ),
        child:  InkWell(
          onTap:atdProvider.isDisabled == false? (){
            if(atdProvider.ischeckedIn==true)
            {
              confirmAttendance("Check Out",context);
            }
            else{
              confirmAttendance("Check In",context);
            }

          }
              :(){},
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child:atdProvider.ischeckedIn == true
                  ? customText("Check Out", screenWidth/22, whiteColor)
                  : customText("Check In", screenWidth/22, whiteColor)
          ),
        )
    );
    }
    Widget customText(String text, double fontSize, Color fontColor){
    return Text("${text}",style: GoogleFonts.roboto(
      textStyle: (
      TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontWeight: FontWeight.w400,
      )
      )
    ),);
    }

    Widget monthWorkHrStatus(){
      int workingHrs = Provider.of<AttendanceProvider>(context).countMonthWorkingHrs(context);
      final atdProvider = Provider.of<AttendanceProvider>(context);
      return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "${DateFormat(' MMMM').format(DateTime.now())} Status",
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth / 15,
                )),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SimpleCustomCard(
              label: "Working Hours",
              progressValue: "${workingHrs}",
              color: blackColor,
              headingColor: primary,
              backgroundColor: whiteColor,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),

            Consumer<AttendanceProvider>(
                builder: (context, provider, child) {
                  return SimpleCustomCard(
                    label: "Remaining",
                    progressValue: "${atdProvider.remWorkingHrs} : ${atdProvider.remWorkingMin}",
                    color: blackColor,
                    headingColor: primary,
                    backgroundColor: whiteColor,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  );

                })
          ],
        ),
      ],
    );
    }

  }

