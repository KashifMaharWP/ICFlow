
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:taskflow_application/Module/LeaveModule/Leave%20Management/Model/userLeaveModel.dart';

import '../../../../API/login_user_detail.dart';
import '../../../Utills/Global Class/GlobalAPI.dart';
import '../../../Utills/Global Functions/SnackBar.dart';

class LeaveProvider extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setisLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<UserLeaveModel> getUserLeave(BuildContext context,String date,leaveType ) async {
    String URL = "${ApiDetail.BaseAPI}${ApiDetail.getLeave}?${date}&${leaveType}";
    try {
      Response response = await http.get(Uri.parse(URL), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Provider.of<UserDetail>(context, listen: false).token} "
      });

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        notifyListeners();
        return UserLeaveModel.fromJson(data);
      } else if (response.statusCode == 400) {
        print(response.body);
        showErrorSnackbar("No record available", context);
        return UserLeaveModel.fromJson(data);
      }
      else if(response.statusCode==408){
        print(response.body);
        showErrorSnackbar("Please check your internet connection", context);
      }
      return UserLeaveModel.fromJson(data);
    } catch (e) {
      print(e);
      showErrorSnackbar("TRY AGAIN!. Server is not responding. please check your internet connection.", context);
    }
    return UserLeaveModel();
  }
}