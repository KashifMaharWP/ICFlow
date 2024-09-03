
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Leave%20Management/Widget/WrapTextWidget_AB.dart';
import 'package:taskflow_application/AttendanceModule/Utills/Global%20Class/ScreenSize.dart';

import '../../../Utills/Global Class/ColorHelper.dart';

class teamLeadLeaveManagement extends StatefulWidget {
  const teamLeadLeaveManagement({super.key});

  @override
  State<teamLeadLeaveManagement> createState() => _teamLeadLeaveManagementState();
}

class _teamLeadLeaveManagementState extends State<teamLeadLeaveManagement> {
  DateTime? initialDate;
  DateTime? lastDate;
  int countdays=0;
  DateRangePickerController _dateRangePickerController = DateRangePickerController();

  @override
  Future LeavePopUp()=>showDialog(
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
            padding: EdgeInsets.all(0),
            width: screenWidth*0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sfDatePicker(),
                SizedBox(height: screenHeight/40,),
                WrapText(title: "Total Days", value: " 2"),
                WrapText(title: "Start from", value: " ${DateFormat('EEE dd MMM yyyy').format(DateTime.now())}"),
                WrapText(title: "Re-joining Date", value: " ${DateFormat('EEE dd MMM yy').format(DateTime.now())}"),
                Text("ICreativez Technology Nawabshah Branch"),
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

//Date Range Picker Functions
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      setState(() {
        initialDate = args.value.startDate;
        lastDate = args.value.endDate;
      });
    }
  }

  int _calculateDaysBetween(DateTime? start, DateTime? end) {
    if (start == null || end == null) return 0;
    return end.difference(start).inDays + 1; // Add 1 to include the last day
  }

  void reset() {
    _dateRangePickerController.selectedRange = null;
    setState(() {
      countdays==null;
      initialDate=null;
      lastDate=null;
    });
  }



//Screen Starts Here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.redAccent.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: const Text("Leave Management"),
      ),
      body: Container(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: LeavePopUp,
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
                            SizedBox(width: screenWidth/25,),
                            CircleAvatar(
                              radius: screenWidth/10,
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/usericon.png")),
                            ),
                            SizedBox(width: screenWidth/20,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Kashif Mahar",style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: primary,
                                          fontSize: screenWidth/20,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),),
                                  Text("Jr Flutter Developer",style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: lightBlackColor,
                                          fontSize: screenWidth/25,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),),
                                  WrapText(title: "Applied:", value: "${DateFormat('EEE dd MMM yyyy').format(DateTime.now())}"),
                                  Wrap(
                                    runAlignment: WrapAlignment.spaceEvenly,
                                    children: [
                                      WrapText(title: "Leave Balance:", value: "2"),
                                      SizedBox(width: screenWidth/100),
                                      Container(
                                        width: screenWidth/4,
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: CupertinoColors.systemGrey2,
                                              blurRadius: 6,
                                              offset: Offset(0, 2)
                                            )
                                          ]
                                        ),
                                        child: const Center(child: Text("Status")),
                                      )
                                    ],
                                  )


                                ],
                              ),
                            ),
                            PopupMenuButton(
                                initialValue: 0,
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                        onTap: () {
                                        },
                                        value: 1,
                                        child: const Text(
                                            "Approve")),
                                    PopupMenuItem(
                                        onTap: () {},
                                        value: 2,
                                        child: const Text(
                                            "Declined"))
                                  ];
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.grey,
                                ))
                          ],
                        )

                    ),
                  );
                }),
      ),
    );
  }


  //Calender to Pick Date Range Widget
  Widget sfDatePicker(){
    return SizedBox(
      height: screenHeight/2.5, // Adjust the height as needed
      width: screenWidth*0.75, // Adjust the width as needed
      child: SfDateRangePicker(
        backgroundColor: primary,
        startRangeSelectionColor: Colors.white,
        endRangeSelectionColor: Colors.white,
        rangeSelectionColor: Colors.black26,
        todayHighlightColor: Colors.white,
        selectionTextStyle: GoogleFonts.roboto(
            fontSize: screenWidth/20,
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),
        rangeTextStyle: GoogleFonts.roboto(
            fontSize: screenWidth/24,
            color: Colors.white
        ),
        monthCellStyle: DateRangePickerMonthCellStyle(
          textStyle: GoogleFonts.roboto(
            fontSize: screenWidth/22,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          todayTextStyle: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth/20

          ),
          weekendTextStyle: GoogleFonts.roboto(
              color: Colors.amber,
              fontWeight: FontWeight.w500,
              fontSize: screenWidth/24
          ),
          disabledDatesTextStyle: GoogleFonts.roboto(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: screenWidth/24// Disabled dates text color
          ),

        ),
        headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: primary,
            textStyle: GoogleFonts.roboto(
                fontSize: screenWidth/15,
                color: Colors.white
            )
        ),


        monthViewSettings: DateRangePickerMonthViewSettings(
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: GoogleFonts.roboto(
                  fontSize: screenWidth/25,
                  color: Colors.white,
                )
            )
        ),
        minDate: DateTime.now(),
        view: DateRangePickerView.month,
        selectionMode: DateRangePickerSelectionMode.range,
        onSelectionChanged: _onSelectionChanged,
        controller: _dateRangePickerController,
      ),
    );
  }


}
