
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Leave%20Management/Widget/WrapTextWidget_AB.dart';
import 'package:taskflow_application/AttendanceModule/Utills/Global%20Class/ScreenSize.dart';

import '../../../Utills/Global Class/ColorHelper.dart';
import '../../Attendance History/Class/CustomMonthPicker.dart';
import '../../Attendance History/Provider/HistoryProvider.dart';

class teamLeadLeaveManagement extends StatefulWidget {
  const teamLeadLeaveManagement({super.key});

  @override
  State<teamLeadLeaveManagement> createState() => _teamLeadLeaveManagementState();
}

class _teamLeadLeaveManagementState extends State<teamLeadLeaveManagement> {

  @override
  String activeFilter = "All";



//Screen Starts Here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        iconTheme: IconThemeData(
          color: whiteColor,
          weight: 20
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          headerContainer(),
          SizedBox(height: screenHeight/60,),
          leaveFilters(),
          SizedBox(height: screenHeight/60,),
          dateFilter(),
          leaveList()
        ],
      )
    );
  }

  //headerContainer
  Widget headerContainer(){
    return Container(
      height: screenHeight/8,
      width: screenWidth,
      color: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Leave Management",style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: whiteColor,
                      fontSize: screenWidth/20,
                      fontWeight: FontWeight.bold
                  )
              ),),

              InkWell(
                  onTap: () async {
                  },
                  child: Image(image: AssetImage("assets/icons/calendar.png"),
                    width: screenWidth/12,
                  )
                  ),
            ],
          ),
        ),
      ),
    );
  }

  // Leave Filters
  Widget leaveFilters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        leaveFilterWidget("All",  whiteColor, lightBlackColor, activeFilter == "All"),
        leaveFilterWidget("Casual",  whiteColor, lightBlackColor, activeFilter == "Casual"),
        leaveFilterWidget("Sick",  whiteColor, lightBlackColor, activeFilter == "Sick"),
      ],
    );
  }

  Widget leaveFilterWidget(String filterName, Color backgroundColor, Color fontColor, bool isActive) {
    return InkWell(
      onTap: () {
        setState(() {
          activeFilter = filterName; // Update the active filter on click
        });
      },
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          isActive
              ? CircleAvatar(
            radius: screenWidth / 40,
            backgroundColor: primary,
          )
              : CircleAvatar(
            radius: screenWidth / 40,
            backgroundColor: CupertinoColors.systemGrey2,
          ),
          SizedBox(width: screenWidth / 40),
          Container(
            height: screenHeight / 20,
            child: Center(
              child: Text(
                filterName,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: fontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth / 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Date Filter Container
  Widget dateFilter(){
    return Container(
      width: screenWidth*0.95,
      height: screenHeight/15,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(screenWidth/20),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey2,
            offset: Offset(2, 2),
            blurRadius: 5
          )
        ]
      ),
      child: leaveFilterIcon(),
    );
  }

  //Date Filter Icons
  Widget leaveFilterIcon(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          child: Wrap(children: [
            Consumer<HistoryProvider>(
              builder: (context, AtdHistProvider, child) {
                return Wrap(
                  children: [
                    Text(
                      DateFormat("dd").format(AtdHistProvider.currentMonth),
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth / 18,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth/40,),
                    Text(
                      DateFormat("MMMM").format(AtdHistProvider.currentMonth),
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: lightBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth / 18,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ]),
        ),

      ],
    );
  }


//Leave List Container
Widget leaveList(){
    return Expanded(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){},
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
                            Text("Sick Leave",style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: lightBlackColor,
                                    fontSize: screenWidth/25,
                                    fontWeight: FontWeight.w500
                                )
                            ),),
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
                        ),
                      ),
                    ],
                  )

              ),
            );
          }),
    );
}
  //Calender to Pick Date Range Widget
  /*Widget sfDatePicker(){
    return SizedBox(
      height: screenHeight/2.5, // Adjust the height as needed
      width: screenWidth, // Adjust the width as needed
      child: SfDateRangePicker(
        backgroundColor: whiteColor,
        startRangeSelectionColor: primary,
        endRangeSelectionColor: primary,
        rangeSelectionColor: Colors.black26,
        todayHighlightColor: primary,
        selectionTextStyle: GoogleFonts.roboto(
            fontSize: screenWidth/20,
            color: whiteColor,
            fontWeight: FontWeight.bold
        ),
        rangeTextStyle: GoogleFonts.roboto(
            fontSize: screenWidth/24,
            color: primary
        ),
        monthCellStyle: DateRangePickerMonthCellStyle(
          textStyle: GoogleFonts.roboto(
            fontSize: screenWidth/22,
            fontWeight: FontWeight.w400,
            color: primary,
          ),
          todayTextStyle: GoogleFonts.roboto(
              color: primary,
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
                color: primary
            )
        ),


        monthViewSettings: DateRangePickerMonthViewSettings(
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: GoogleFonts.roboto(
                  fontSize: screenWidth/25,
                  color: primary,
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
  }*/


}
