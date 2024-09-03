import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/Api/api_info.dart';
import 'package:taskflow_application/AttendanceModule/Utills/Global%20Functions/SnackBar.dart';

class UserLogin {
  static Future<bool> userLogin(
      String email, String password, BuildContext context) async {
    bool authUser = false;
    try {
      //converting the licenceKey into the map format
      final loginMap = {"email": email, "password": password};

      final response =
          await post(Uri.parse("${Api.apiUrl}user/login"), body: loginMap).
          timeout(Duration(seconds: 10),onTimeout: (){
            return Response('{"error": "Timeout"}', 408);
          });

      final userJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        debugPrint("API Body :${response.body}");
        authUser = true;
        //converting the the body into json format
        //here we are calling the UserDetail model to store the details of the user
        Provider.of<UserDetail>(context, listen: false).setUserDetail(userJson);
        print("User Deatils Check: ${userJson}");

        //printing for testing purpose.
        print(
            "User Job Type ID: ${UserDetail().jobTypeId}");
      }

      else {
        print(response.statusCode.toString());
        showErrorSnackbar("${userJson['message'].toString()}", context);
      }
    } catch (error) {
      showErrorSnackbar("Server not Responding! Internet connection is unstable", context);
    }

    return authUser;
  }
}
