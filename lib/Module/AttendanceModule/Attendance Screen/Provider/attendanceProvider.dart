import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/Module/AttendanceModule/Attendance%20Screen/Functions/loaderWidget.dart';
import '../../../Utills/Global Class/GlobalAPI.dart';
import 'package:http/http.dart' as http;
import '../../../Utills/Global Functions/SnackBar.dart';
import '../Functions/customAlertBox.dart';

class AttendanceProvider extends ChangeNotifier {
  bool _ischeckedIn = false;
  bool _isLoading = false;
  bool isDisabled = false;
  bool _isCheckLoading = false;

  bool get isLoading => _isLoading;
  bool get isCheckLoading=>_isCheckLoading;
  bool get ischeckedIn => _ischeckedIn;

  int totalWorkingMin = 0;
  int monthWorkingHrs = 0;
  int workingMin = 0;
  int workDays = 0;
  int workTime = 0;
  int remWorkingHrs = 0;
  int remWorkingMin = 0;
  String? checkInTime;
  String checkOutTime="--|--";

  Future<void> setischeckedIn(bool value) async {
    _ischeckedIn = value;
    notifyListeners();
  }

  void setIsdisabled(bool value) {
    isDisabled = value;
    notifyListeners();
  }

  void setisCheckLoading(bool value) {
    _isCheckLoading=value;
    notifyListeners();
  }


  setisLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  Future<void> fetchAttendanceData(BuildContext context) async {
    setisLoading(true);
    try {
      print("Fetch Attendance");
      await countTotalWorkedMin(context, DateFormat("MMMM").format(DateTime.now()));
      await countMonthWorkingHrs(context);
      //await CountWorkDays();
      await getTodayAttendance(context);
      //await getTodayAttendance;
    } catch (e) {
      print("Error: $e");
      showErrorSnackbar("Please Check Internet", context);
      Navigator.pop(context);
    } finally {
      setisLoading(false);
    }
  }


  Future<void> AddCheckIn(double latitude, longitude,
      BuildContext context) async {
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
      print(
          "This is Token : ${Provider
              .of<UserDetail>(context, listen: false)
              .token}");
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization":
            "Bearer ${Provider
                .of<UserDetail>(context, listen: false)
                .token} "
          },
          body: jsonEncode(body)).timeout(Duration(seconds: 15), onTimeout: () {
        return Response("", 408);
      });
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        if (json.isNotEmpty) {
          //CheckInClass.checkInTime=DateTime.now().toString();
          showSuccessSnackbar("Check In Successfully", context);
          setisLoading(false);
          fetchAttendanceData(context);
          showStatusLoader(context, "assets/lottie/successfullyDone.json");
        } else {
          //print("{}");
          showErrorSnackbar("${json['message']}", context);
          setisLoading(false);
          //Navigator.pop(context);
          showStatusLoader(context, "assets/lottie/unsuccessful.json");
        }
      }
      else if (response.statusCode == 408) {
        showErrorSnackbar("Please check your internet connection", context);
      }
      else {
        showErrorSnackbar("${json['message'].toString()}", context);
        setisLoading(false);
        // Navigator.pop(context);
        showStatusLoader(context, "assets/lottie/unsuccessful.json");
      }
    } catch (e) {
      print("Exception: $e");
      setisLoading(false);
      //Navigator.pop(context);
      showStatusLoader(context, "assets/lottie/unsuccessful.json");
    }
    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
  }

  Future<void> AddCheckOut(double latitude, longitude,
      BuildContext context) async {
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
            "Bearer ${Provider
                .of<UserDetail>(context, listen: false)
                .token}"
          },
          body: jsonEncode(body)).timeout(Duration(seconds: 15), onTimeout: () {
        return Response("", 408);
      });
      final json = jsonDecode(response.body);
      print("Here is Status Code: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        showSuccessSnackbar("Check Out Successfully", context);
        fetchAttendanceData(context);
        setisLoading(false);
        showStatusLoader(context, "assets/lottie/successfullyDone.json");
      }
      else if (response.statusCode == 408) {
        showErrorSnackbar("Please check your internet connection", context);
      }
      else {
        showErrorSnackbar("${json['message'].toString()}", context);
        setisLoading(false);
        showStatusLoader(context, "assets/lottie/unsuccessful.json");
      }
    } catch (e) {
      showErrorSnackbar("There is an Error Occured : ${e}", context);
      setisLoading(false);
      showStatusLoader(context, "assets/lottie/unsuccessful.json");
    }
    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
  }


  //This Function is used to get Current Month Total Worked Hours
  Future<void> countTotalWorkedMin(BuildContext context, String Month) async {
    String url = "${ApiDetail.BaseAPI}${ApiDetail.ViewWorkingHrs}${Month}";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Provider
            .of<UserDetail>(context, listen: false)
            .token}"
      },
    );
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //print("CountWorking Hours");
      totalWorkingMin = json['workingMinutes'] ?? 0;
     // print("Response : ${response.body}");
      countRemWorkingTime(context);
      notifyListeners();
    }
    else {
      showErrorSnackbar(
          "There is Error Occured: Please Check Internet Connection", context);
          Navigator.pop(context);
          print("Response: ${response.body}");
    }
    notifyListeners();
  }

  //This function is used to get the worked days of current Month
  static int CountWorkDays() {
    int workingDays = 0;
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    //print("Days: ${now.day}");
    //print(now.weekday);
    for (int i = 0; i < lastDayOfMonth.day; i++) {
      DateTime day = firstDayOfMonth.add(Duration(days: i));
      if (day.weekday >= DateTime.monday && day.weekday <= DateTime.friday) {
        workingDays++;
      }
    }
    return workingDays;
    //print("Total Weeks"+totalWeekDays.toString());
  }

  //This function if used to get Total hrs required worked an employee in current month according to it's Job Type;
  int countMonthWorkingHrs(BuildContext context) {
    final currenUser = Provider.of<UserDetail>(context, listen: false);
    workDays = CountWorkDays();
    workTime = currenUser.jobTypeId == "1"
        ? 8
        : currenUser.jobTypeId == "3"
        ? 8
        : 4;
    monthWorkingHrs = workDays * workTime;
    return monthWorkingHrs;
  }

  //This Function is used to get Remaining Working Hrs and Min Employee required in current month to work
  void countRemWorkingTime(BuildContext context) {
    int totalRemWorkedMin = (countMonthWorkingHrs(context) * 60) -
        totalWorkingMin;
    remWorkingHrs = totalRemWorkedMin ~/ 60; // getting Worked Hrs
    remWorkingMin = totalRemWorkedMin % 60;
  }

  Future<void> getTodayAttendance(BuildContext context) async {
    setisCheckLoading(true);
    String currentDate=DateFormat("EEE MMM dd yyyy").format(DateTime.now());
    String url = "${ApiDetail.BaseAPI}${ApiDetail.todayAttendnace}/${currentDate}";
    try {

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Provider.of<UserDetail>(context, listen: false).token}"
        },
      );
      //print(currentDate);
      if (response.statusCode == 200) {
        // Decode the response body to a Map
        var data = jsonDecode(response.body);

        // Check if 'attendance' is a list and has at least one item
        if (data['attendance'] is List && data['attendance'].isNotEmpty) {
          var attendanceList = data['attendance'] as List;

          // Extract the first item from the list (if applicable)
          var firstAttendance = attendanceList[0];

          // Safely access the checkIn and checkOut times
          if (firstAttendance['checkIn'] != null) {
            checkInTime = firstAttendance['checkIn']['time'].toString();
            setIsdisabled(false);
            setischeckedIn(true);
            //print("CheckIN: $checkInTime");
          }
          else {
            checkInTime="--|--";
            setIsdisabled(false);
            setischeckedIn(false);
          }

          if (firstAttendance['checkOut'] != null) {
            checkOutTime = firstAttendance['checkOut']['time'].toString();
            setIsdisabled(true);
          } else {
            checkOutTime="--|--";
            setIsdisabled(false);
          }
        }
        else {
          setIsdisabled(false);
          //setischeckedIn(true);
          checkInTime="--|--";
          checkOutTime="--|--";
        }

      } else {
        //print(response.body);
        setischeckedIn(false);
        setIsdisabled(false);
        checkInTime="--|--";
        checkOutTime="--|--";
      }
    } catch (e) {
      showErrorSnackbar("Server is not responding. Please check your Internet connection", context);
      //print("Exception: $e");
    }
    finally{
      setisCheckLoading(false);
      notifyListeners();
    }
  }



}