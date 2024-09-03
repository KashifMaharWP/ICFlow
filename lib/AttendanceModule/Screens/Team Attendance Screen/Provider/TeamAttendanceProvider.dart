import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../API/login_user_detail.dart';
import '../../../../AttendanceModule/Utills/Global Class/GlobalAPI.dart';
import '../../../../AttendanceModule/Utills/Global Functions/SnackBar.dart';
import '../Model/TeamAttendanceModel.dart';
import '../Model/TeamViewClass.dart';
import '../Model/ViewTodyAttendanceModel.dart';


class TeamAttendanceProvider extends ChangeNotifier{
  List<TeamAttendanceView> _attendanceList = [];
  List<TeamAttendanceView> get attendanceList => _attendanceList;
  int onlineCount=0;
  int totalCount=0;
  int offlineCount=0;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setIsLoading(value){
    _isLoading=value;
    notifyListeners();
  }

  Future<ViewTodyAttendanceModel> GetTeamAttendance(BuildContext context) async {
    String URL="${ApiDetail.BaseAPI}${ApiDetail.ViewTeamAttendance}";
    setIsLoading(true);
    try{
      Response response=await http.get(Uri.parse(URL),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Provider.of<UserDetail>(context,listen: false).token} "
          }
      );

      var data = jsonDecode(response.body);
      print("Response Team Attendance: ${data}");
      if(response.statusCode==200){
        totalCount=data['totalUser'];
        print("Total User Count: ${data['totalUser']}");
        onlineCount=ViewTodyAttendanceModel.fromJson(data).onlineUserAttendanceRecord!.length;
        offlineCount=totalCount-onlineCount;
        return ViewTodyAttendanceModel.fromJson(data);

      }
      else if(response.statusCode==400){
        showErrorSnackbar("There is no Record Available", context);
        return ViewTodyAttendanceModel.fromJson(data);
      }
      else{
        return ViewTodyAttendanceModel.fromJson(data);
      }
    }catch(e){
      print(e);
      showErrorSnackbar("There is error Occured during connection : ${e}", context);
    }
    finally{
      setIsLoading(false);
    }
    setIsLoading(false);
    return ViewTodyAttendanceModel();
  }

  }