import 'dart:async';
//import 'package:employee_management_app/Model/AttendanceCheckInModel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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

  Future<void> showLoadingDialog(
      BuildContext context,
      ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

// to hide our current dialog
  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

    @override
    Widget build(BuildContext context) {
      int workingHrs = Provider.of<AttendanceProvider>(context).countMonthWorkingHrs(context);
      final atdProvider = Provider.of<AttendanceProvider>(context);

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
            child: Column(
              children: [
                Row(
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
                ),
                Consumer<AttendanceProvider>(
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
                    }),
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
                Container(
                  margin: EdgeInsets.only(top: screenWidth / 15),
                  child: atdProvider.isDisabled == false
                      ? Builder(builder: (context) {
                    final GlobalKey<SlideActionState> key = GlobalKey();
                    return SlideAction(
                      //enabled: atdProvider.isLoading,
                        submittedIcon: Icon(FontAwesomeIcons.check),
                        text: atdProvider.ischeckedIn == true
                            ? "Slide to Check Out"
                            : "Slide to Check In",
                        textStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: lightBlackColor,
                              fontSize: screenWidth / 20,
                              fontWeight: FontWeight.bold),
                        ),
                        sliderButtonIcon: Icon(CupertinoIcons.arrow_right,color: whiteColor,),
                        outerColor: Colors.white,
                        innerColor: atdProvider.ischeckedIn == true
                            ? lightBlackColor
                            : primary,
                        elevation: 10,
                        key: key,
                        onSubmit: () async {
                          key.currentState!.reset();
                          showLoadingDialog(context);
                          refresh();
                          if (atdProvider.ischeckedIn == true) {
                            getCurrentLocationCheckOutTime(context);
                          } else {
                            getCurrentLocationCheckInTime(context);
                          }
                          hideLoadingDialog(context);

                        });
                  })
                      : Container(
                    margin: EdgeInsets.only(top: screenWidth / 15),
                    padding:
                    EdgeInsets.symmetric(vertical: screenWidth / 55),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(screenWidth / 10)),
                        boxShadow: [
                          BoxShadow(
                            color: darkgreyColor,
                            offset: Offset(2, 2),
                            blurRadius: 10,
                          )
                        ]),
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenWidth / 50,
                        ),
                        CircleAvatar(
                          radius: screenWidth / 16,
                          backgroundColor: darkgreyColor,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: whiteColor,
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.5,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 15,
                ),

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
            )),
      );
    }
  }

