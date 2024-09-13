import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../../../API/login_user_detail.dart';
import '../../../Model/AttendanceHistoryModel.dart';
import '../../../Utills/Global Class/GlobalAPI.dart';
import '../../../Utills/Global Functions/SnackBar.dart';
import '../Class/TeamLeads.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart'; // For basename


import '../Model/TeamLeadListModel.dart';

class LeaveFormProvider extends ChangeNotifier{
   List<TeamLeads> teamLeadList = [];
   bool _isLoading=false;
   bool _listLoading=false;
   bool get listLoading => _listLoading;

   bool get isLoading => _isLoading;


   setisLoading(bool value){
     _isLoading=value;
     notifyListeners();
   }

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

   Future<void> applyForLeave(File file,BuildContext context,String teamHeadId,initialDate,endDate,totalDays,description,) async {
     final uri = Uri.parse('${ApiDetail.BaseAPI}${ApiDetail.applyLeave}');
     setisLoading(true);
     var request = http.MultipartRequest('POST', uri);

     // Attach the image file with the key 'profileImage'
     request.files.add(await http.MultipartFile.fromPath(
       'image',   // Must match the backend field name
       file.path,
       filename: basename(file.path),
     ));
     request.headers["Authorization"]="Bearer ${Provider.of<UserDetail>(context, listen: false).token}";

     // Attach additional form data
     request.fields['teamHead'] = teamHeadId;
     request.fields['intialDate'] = initialDate;
     request.fields['endDate'] = endDate;
     request.fields['totalDays'] = totalDays;
     request.fields['description'] = description;

     try {
       // Send the request
       var response = await request.send();

       if (response.statusCode == 200) {
         setisLoading(false);
         showSuccessSnackbar("You successfulyy Applied for leave", context);
       } else {
         setisLoading(false);
         showSuccessSnackbar("There is an error Occured ${response.statusCode}", context);
         print('Failed to upload file. Status code: ${response.statusCode}');
       }
     } catch (e) {
       setisLoading(false);
       showErrorSnackbar("Error ${e}", context);
     }
   }


}

