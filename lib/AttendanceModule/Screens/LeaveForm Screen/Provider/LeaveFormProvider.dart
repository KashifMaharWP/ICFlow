import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../../../Model/AttendanceHistoryModel.dart';
import '../../../Utills/Global Class/GlobalAPI.dart';
import '../../../Utills/Global Functions/SnackBar.dart';
import '../Class/TeamLeads.dart';
import 'package:http/http.dart' as http;

import '../Model/TeamLeadListModel.dart';

class TeamLeadListProvider extends ChangeNotifier{
   List<TeamLeads> teamLeadList = [];
   bool _listLoading=false;
   bool get listLoading => _listLoading;

   setlistLoading(bool value){
     _listLoading=value;
     notifyListeners();
   }

  Future<List<TeamLeads>>GetTeamLeadLsit(BuildContext context) async {
    setlistLoading(false);
    String URL="${ApiDetail.BaseAPI}${ApiDetail.TeamLeadList}";
    try{
      Response response = await http.get(Uri.parse(URL));
      if(response.statusCode==200){
        var data = jsonDecode(response.body);
        var result=data["teamHeads"] as List;
        teamLeadList=result.map((element)=>TeamLeads.fromMap(element)).toList();
        /*
       teamLeadList=(data["teamHeads"] as List)
           .map((element)=>TeamLeads.fromMap(element)).toList();*/
      /*  teamLeadList.forEach((teamLead){
          print("Team Lead Names : ${}")
        });*/
        setlistLoading(true);
      }
      return teamLeadList;
    }
    catch(e){
      setlistLoading(false);
      print(e);
      showErrorSnackbar("There is an Error Occured during connection : ${e}", context);
    }
    return teamLeadList;
  }
}

