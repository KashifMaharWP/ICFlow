
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';

class dateRangePicker extends StatefulWidget {
  const dateRangePicker({super.key});

  @override
  State<dateRangePicker> createState() => _dateRangePickerState();
}

class _dateRangePickerState extends State<dateRangePicker> {
  DateTime? initialDate;
  DateTime? lastDate;
  int countdays=0;
  DateRangePickerController _dateRangePickerController = DateRangePickerController();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      setState(() {
        initialDate = args.value.startDate;
        lastDate = args.value.endDate;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: screenHeight/3, // Adjust the height as needed
        width: screenWidth, // Adjust the width as needed
        child: SfDateRangePicker(
          backgroundColor: whiteColor,
          startRangeSelectionColor: primary,
          endRangeSelectionColor: primary,
          rangeSelectionColor: darkgreyColor,
          todayHighlightColor: primary,
          selectionTextStyle: GoogleFonts.roboto(
              fontSize: screenWidth/20,
              color: whiteColor,
              fontWeight: FontWeight.bold
          ),
          rangeTextStyle: GoogleFonts.roboto(
              fontSize: screenWidth/24,
              color: blackColor
          ),
          monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: GoogleFonts.roboto(
              fontSize: screenWidth/22,
              fontWeight: FontWeight.w400,
              color: blackColor,
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
                  color: blackColor
              )
          ),


          monthViewSettings: DateRangePickerMonthViewSettings(
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: GoogleFonts.roboto(
                    fontSize: screenWidth/25,
                    color: blackColor,
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
