import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../API/login_user_detail.dart';
import '../../../AttendanceModule/Attendance Screen/Functions/customAlertBox.dart';
import '../../../Utills/Global Class/GlobalAPI.dart';
import '../../../Utills/Global Functions/SnackBar.dart';
import '../Class/TeamLeads.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart'; // For basename


import '../Model/TeamLeadListModel.dart';

class LeaveFormProvider extends ChangeNotifier{
   List<TeamLeads> teamLeadList = [];

   bool _isSuccessful=false;
   bool _listLoading=false;
   bool get listLoading => _listLoading;

   bool get isSuccessful => _isSuccessful;

   setisSuccessful(bool value){
     _isSuccessful=value;
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
      Response response = await http.get(Uri.parse(URL),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Provider.of<UserDetail>(context,listen: false).token} "
          }
      );

      if(response.statusCode==200){
        var data = jsonDecode(response.body);
        var result=data["myTeamLead"] as List;
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

   Future<void> applyForLeave(File? file,BuildContext context,String initialDate,endDate,totalDays,leaveType,description,) async {

     if (teamLeadList.isEmpty) {
       await GetTeamLeadLsit(context);
     }

     // Assuming you want to get the first team lead in the list (or find the appropriate one)
     TeamLeads? selectedTeamLead;
     if (teamLeadList.isNotEmpty) {
       selectedTeamLead = teamLeadList.first; // Change logic if needed
     }

     if (selectedTeamLead == null) {
       showErrorSnackbar("No Team Lead found", context);
       return;
     }

     final uri = Uri.parse('${ApiDetail.BaseAPI}${ApiDetail.applyLeave}');
     setisSuccessful(false);
     print("Is Successful ==${isSuccessful}");
     var request = http.MultipartRequest('POST', uri);

     // Attach the image file with the key 'profileImage'
     if (file != null) {
       request.files.add(await http.MultipartFile.fromPath(
         'image',   // Must match the backend field name
         file.path,
         filename: basename(file.path),
       ));
     }
     request.headers["Authorization"]="Bearer ${Provider.of<UserDetail>(context, listen: false).token}";

     // Attach additional form data
     request.fields['applydate']=DateFormat("dd MMMM yyyy").format(DateTime.now()).toString();
     request.fields['teamHead'] = selectedTeamLead.id;
     request.fields['teamLeadEmail'] = selectedTeamLead.email;
     request.fields['teamLeadName'] = selectedTeamLead.fullName;
     request.fields['intialDate'] = initialDate;
     request.fields['endDate'] = endDate;
     request.fields['totalDays'] = totalDays;
     request.fields['leaveType'] = leaveType;
     request.fields['description'] = description;

     try {
       // Send the request
       var response = await request.send();

       if (response.statusCode == 200) {
         showSuccessSnackbar("You successfully Applied for leave", context);
         showStatusLoader(context, "assets/lottie/successfullyDone.json");
         await setisSuccessful(true);
       } else {
         showSuccessSnackbar("There is an error Occured ${response.statusCode}", context);
         showStatusLoader(context, "assets/lottie/unsuccessful.json");
         await setisSuccessful(false);
       }
     } catch (e) {
       showErrorSnackbar("Error ${e}", context);
       showStatusLoader(context, "assets/lottie/unsuccessful.json");
       await setisSuccessful(false);
     }
     finally{
       await Future.delayed(Duration(seconds: 3));
       Navigator.pop(context);
       print("Is Successful ==${isSuccessful}");
     }
   }


}

