import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../API/login_user_detail.dart';
import '../../../Model/AttendanceCheckInModel.dart';
import '../../../Model/AttendanceHistoryModel.dart';
import '../../../Utills/Global Class/GlobalAPI.dart';
import '../../../Utills/Global Functions/SnackBar.dart';

class HistoryProvider extends ChangeNotifier{
  List<Attendance> _attendanceList = [];
  List<Attendance> get attendanceList => _attendanceList;

  bool isCurrentMonth = true;
  int currentYear = DateTime.now().year.toInt();
  DateTime currentMonth = DateTime.now();
  String currentMonthfilter=DateFormat(' MMMM').format(DateTime.now());

  DateTime _notifycurrentMonth = DateTime.now();
  DateTime get notifycurrentMonth => _notifycurrentMonth;

  void setCurrentMonth(DateTime newMonth) {
    _notifycurrentMonth = newMonth;
    notifyListeners(); // This will trigger the Consumer to rebuild
  }

Future<AttendanceHistoryModel> GetAttendanceData(String month,BuildContext context) async {
  String URL="${ApiDetail.BaseAPI}${ApiDetail.AtdHistory}${month}";
  try{
    Response response=await http.get(Uri.parse(URL),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Provider.of<UserDetail>(context,listen: false).token} "
        }
    );

    print(month);
    var data = jsonDecode(response.body.toString());
  if(response.statusCode==200){
    return AttendanceHistoryModel.fromJson(data);
  }
  else if(response.statusCode==400){
    showErrorSnackbar("There is no Record Available", context);
    return AttendanceHistoryModel.fromJson(data);
  }
  else{
    return AttendanceHistoryModel.fromJson(data);
  }
  }catch(e){
    print(e);
    showErrorSnackbar("There is error Occured during connection : ${e}", context);
  }
  return AttendanceHistoryModel();
}


  void NextMonthFunction(BuildContext context) async{
  //print("next Month function Called");
  DateTime now = DateTime.now();
      if (currentMonth.year == now.year && currentMonth.month == now.month) {
        // If the current month is the same as the actual current month, do nothing
        return;
      }

      // Proceed to change the month
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
      currentMonthfilter=DateFormat("MMMM").format(currentMonth);
      //await GetAttendanceData(currentMonthfilter, context);

      if (currentMonth.year == now.year && currentMonth.month == now.month) {
        isCurrentMonth = true;
      } else {
        isCurrentMonth = false;
      }
  notifyListeners();
  }

  void PreviousMonth(BuildContext context) async{
      //print("Previous Month Called");
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
      currentMonthfilter=DateFormat("MMMM").format(currentMonth);
      isCurrentMonth = false;
      //print(currentMonth);
      notifyListeners();
  }


}