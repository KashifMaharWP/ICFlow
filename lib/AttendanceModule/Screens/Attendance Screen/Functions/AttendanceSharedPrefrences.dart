
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Attendance%20Screen/Provider/attendanceProvider.dart';

import '../Class/CheckInClass.dart';

class AttendanceSharedPrefrences {
  late final CheckInDate;
  late final CheckInTime;
  late final isCheckIn;
  static Future <void> Set_checkInSharePreference() async{
    String Datestamp = DateFormat("dd MM yyyy").format(DateTime.now());
    String Time=DateFormat("hh:mm:a").format(DateTime.now());
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString("CheckInTime", Time);
    pref.setString("CheckInDate", Datestamp);
    Get_checkInSharePreference();
    print("SharedPreference Data Inserted");
  }

  static Future <void> Set_checkOutSharePreference() async{
    String Time=DateFormat("hh:mm:a").format(DateTime.now());
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString("CheckOutTime", Time);
    Get_checkOutSharePreference();
    print("Checkout Data SharedPreference Data Inserted");
  }

  static Future <void> Get_checkInSharePreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    CheckInClass.checkInDate = pref.getString("CheckInDate").toString();
    CheckInClass.checkInTime=pref.getString("CheckInTime").toString();
    //CheckInClass.checkOutTime=pref.getString("CheckOutTime").toString();
    print("Shared Preference Data: ${pref.getString("CheckInDate").toString()}");
    }

  static Future <void> Get_checkOutSharePreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    CheckInClass.checkOutTime=pref.getString("CheckOutTime").toString();
    print("Data Getted from Shared Preferences");
  }


  static Future<void> setCheckInStatus(bool isCheckedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isCheckedIn", isCheckedIn);
  }

  static Future<bool> getCheckInStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("isCheckedIn") ?? false; // Default to false if not set
  }

}