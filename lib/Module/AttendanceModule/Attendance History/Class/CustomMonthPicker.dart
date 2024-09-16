import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';

class CustomMonthPicker {
  final DateTime initialSelectedMonth;
  final DateTime firstEnabledMonth;
  final DateTime lastEnabledMonth;
  final int firstYear;
  final int lastYear;
  final String selectButtonText;
  final String cancelButtonText;
  final Color highlightColor;
  final Color textColor;
  final Color contentBackgroundColor;
  final Color dialogBackgroundColor;
  final TextStyle selectButtonTextStyle;
  final TextStyle cancelButtonTextStyle;

  CustomMonthPicker({
    required this.initialSelectedMonth,
    required this.firstEnabledMonth,
    required this.lastEnabledMonth,
    required this.firstYear,
    required this.lastYear,
    required this.selectButtonText,
    required this.cancelButtonText,
    required this.highlightColor,
    required this.textColor,
    required this.contentBackgroundColor,
    required this.dialogBackgroundColor,
    required this.selectButtonTextStyle,
    required this.cancelButtonTextStyle,
  });

  Future<DateTime?> show(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: initialSelectedMonth,
      firstDate: firstEnabledMonth,
      lastDate: lastEnabledMonth,
      confirmWidget: Text(selectButtonText,style: selectButtonTextStyle,),
      cancelWidget:Text(cancelButtonText,style: cancelButtonTextStyle,),
      monthPickerDialogSettings: MonthPickerDialogSettings(
        dialogSettings: PickerDialogSettings(
          dialogBackgroundColor: dialogBackgroundColor
        ),
        headerSettings: PickerHeaderSettings(
          headerBackgroundColor: highlightColor,
          headerIconsSize: screenHeight/20
        ),
        buttonsSettings: PickerButtonsSettings(
          monthTextStyle: TextStyle(
            fontSize: screenWidth/28,
            fontWeight: FontWeight.bold,
            color: primary
          ),
          yearTextStyle: TextStyle(
              fontSize: screenWidth/28,
              fontWeight: FontWeight.bold,
              color: primary
          ),
          selectedMonthBackgroundColor: primary,
          selectedYearTextColor: whiteColor,
          selectedMonthTextColor:whiteColor,
          unselectedMonthsTextColor: primary,
          unselectedYearsTextColor: primary,
          currentMonthTextColor: blackColor,
          currentYearTextColor: blackColor
        )
      )

    );

    return picked;
  }
}
