import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import '../../../Utills/Global Class/GlobalAPI.dart';
import 'package:http/http.dart' as http;

import '../../../Utills/Global Class/userDataList.dart';
import '../../../Utills/Global Functions/SnackBar.dart';
import '../Class/CheckInClass.dart';
import '../Functions/AttendanceSharedPrefrences.dart';

class AttendanceProvider extends ChangeNotifier {
  bool _ischeckedIn = false;
  bool _isLoading = false;
  bool isDisabled=false;
  bool get isLoading => _isLoading;
  bool get ischeckedIn => _ischeckedIn;
  int totalWorkingMin=0;
  int monthWorkingHrs=0;
  int workingMin=0;
  int workDays=0;
  int workTime=0;
  int remWorkingHrs=0;
  int remWorkingMin=0;
  Future<void> setischeckedIn(bool value) async {
    _ischeckedIn = value;
    notifyListeners();
    await AttendanceSharedPrefrences.setCheckInStatus(value);
  }
  void setIsdisabled(bool value){
    isDisabled=value;
    notifyListeners();
  }

  Future<void> loadCheckInStatus() async {
    _ischeckedIn = await AttendanceSharedPrefrences.getCheckInStatus();
    notifyListeners();
  }

  setisLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> AddCheckIn(
      double latitude, longitude, BuildContext context) async {
   setIsdisabled(false);
    String url = "${ApiDetail.BaseAPI}${ApiDetail.CheckIn}";
    final body = {
      "date": DateFormat('EEE MMM dd yyyy').format(DateTime.now()),
      "checkIn": {
        "latitude": latitude,
        "longitude": longitude,
        "time": DateFormat('hh:mm:ss a').format(DateTime.now()),
      },
    };
    print(body);

    try {
      setisLoading(true);
      print(
          "This is Token : ${Provider.of<UserDetail>(context, listen: false).token}");
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${Provider.of<UserDetail>(context, listen: false).token} "
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        if (json.isNotEmpty) {
          //CheckInClass.checkInTime=DateTime.now().toString();
          showSuccessSnackbar("Check In Successfully", context);
          print("CheckIn Successfully");
          print("Response body: ${response.body}");
          AttendanceSharedPrefrences.Set_checkInSharePreference();
          setischeckedIn(true);
          setisLoading(false);
        } else {
          print("Server is Not Responding");
          showErrorSnackbar("Server is Not Responding", context);
          setischeckedIn(false);
          setisLoading(false);
        }
      } else {
        print("Error: ${response.statusCode}");
        print("Response body: ${response.body}");
        showErrorSnackbar("Server is Not Responding", context);
        setischeckedIn(false);
        setisLoading(false);
      }
    } catch (e) {
      print("Exception: $e");
      setischeckedIn(false);
      setisLoading(false);
    }
  }

  Future<void> AddCheckOut(
      double latitude, longitude, BuildContext context) async {
    setIsdisabled(false);
    String url = "${ApiDetail.BaseAPI}${ApiDetail.CheckOut}";
    final body = {
      "date": DateFormat('EEE MMM dd yyyy').format(DateTime.now()),
      "checkOut": {
        "latitude": latitude,
        "longitude": longitude,
        "time": DateFormat('hh:mm:ss a').format(DateTime.now()),
      },
    };
    try {
      setisLoading(true);
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
          },
          body: jsonEncode(body));
      print("Here is Status Code: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        showSuccessSnackbar("Check Out Successfully", context);
        print("CheckOut Successfully");
        print("Response body: ${response.body}");
        await setischeckedIn(false);
        AttendanceSharedPrefrences.Set_checkOutSharePreference();
        setisLoading(false);
        setIsdisabled(true);

      } else {
        print("Error: ${response.statusCode}");
        print("Response body: ${response.body}");
        showErrorSnackbar("There is an Error : ${response.body}", context);
        await setischeckedIn(true);
        setisLoading(false);
        setIsdisabled(false);
      }
    } catch (e) {
      print("Exception: $e");
      showErrorSnackbar("There is an Error Occured : ${e}", context);
      await setischeckedIn(true);
      setisLoading(false);
      setIsdisabled(false);
    }
  }

  //This Function is used to get Current Month Total Worked Hours
  Future<void>countTotalWorkedMin(BuildContext context,String Month)async{
    String url = "${ApiDetail.BaseAPI}${ApiDetail.ViewWorkingHrs}${Month}";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Provider.of<UserDetail>(context,listen: false).token}"
      },
    );
    final json=jsonDecode(response.body);
    if(response.statusCode==200){
      print("CountWorking Hours");
      totalWorkingMin=json['workingMinutes']??0;
      print("Response : ${response.body}");
      countRemWorkingTime(context);
      notifyListeners();
    }
    else{
      showErrorSnackbar("There is Error Occured ${response.statusCode}", context);
    }
    notifyListeners();
  }

  //This function is used to get the worked days of current Month
  static int CountWorkDays(){
    int workingDays=0;
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth=DateTime(now.year,now.month,1);
    DateTime lastDayOfMonth=DateTime(now.year,now.month+1,0);
    print(now.day);
    print(now.weekday);
    for(int i=0; i<lastDayOfMonth.day; i++){
      DateTime day = firstDayOfMonth.add(Duration(days: i));
      if(day.weekday>=DateTime.monday&&day.weekday<=DateTime.friday){
        workingDays++;
      }
    }
    return workingDays;
    //print("Total Weeks"+totalWeekDays.toString());
  }

  //This function if used to get Total hrs required worked an employee in current month according to it's Job Type;
  int countMonthWorkingHrs(BuildContext context){
    final currenUser = Provider.of<UserDetail>(context, listen: false);
    workDays=CountWorkDays();
    workTime = currenUser.jobTypeId == "1"
        ? 8
        : currenUser.jobTypeId == "3"
        ? 8
        : 4;
    monthWorkingHrs=workDays*workTime;
    return monthWorkingHrs;

  }

  //This Function is used to get Remaining Working Hrs and Min Employee required in current month to work
  void countRemWorkingTime(BuildContext context){
    int totalRemWorkedMin=(countMonthWorkingHrs(context)*60)-totalWorkingMin;
    remWorkingHrs=totalRemWorkedMin ~/ 60; // getting Worked Hrs
    remWorkingMin=totalRemWorkedMin % 60;
  }







  Future<void> CheckMidNight(BuildContext context) async {
    String currentDate = DateFormat("dd MM yyyy").format(DateTime.now());
    AttendanceSharedPrefrences.Get_checkInSharePreference();
    if (CheckInClass.checkInDate != currentDate) {
      CheckInClass.checkInTime = '--|--';
      CheckInClass.checkOutTime = '--|--';
      setIsdisabled(false);
    }
  }
}
