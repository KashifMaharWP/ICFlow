import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:taskflow_application/Api/api_info.dart';

class RegistrationProvider extends ChangeNotifier {
  //Company Registration Fields
  String comName = "";
  String ownerName = "";
  String comEmail = "";
  String comContact = "";
  String comAddress = "";
  String licenceKey = "";

  //Admin Registration Fields
  String fullname = "";
  String email = "";
  String contact = "";
  String address = "";
  String username = "";
  String password = "";
  String comId = "";

//function to register the company and admin
  Future<bool> registerCompany() async {
    //creating the map for body
    // map for the admin
    bool isRegestered = false;

    final companyMap = {
      "name": comName,
      "companyOwner": ownerName,
      "address": comAddress,
      "email": comEmail,
      "contact": comContact,
      "lKey": licenceKey
    };

    print("My Send Data: $companyMap");
    //storing the complete url
    const url = "${Api.apiUrl}company/registration";

    //going to hit the API
    Future.delayed(const Duration(seconds: 5));
    final response = await post(Uri.parse(url), body: companyMap);

    //printing the response body
    print("Regcompany API response: ${response.body}");

    final companyJson = jsonDecode(response.body);
    print("Status Code: ${response.statusCode}");
    if (response.statusCode == 200) {
      isRegestered = true;
      comId = companyJson["data"]["_id"].toString();
      print("Print from getting: $comId");
    }
    // comId != null? return true: return false;
    return isRegestered;
  }

  void registerAdmin() async {
    final adminMap = {
      "fullName": fullname,
      "contact": contact,
      "email": email,
      "address": address,
      "password": password,
      "licenceKey": licenceKey,
      "companyId": comId,
    };

    const url = "${Api.apiUrl}user/createAdmin";
    print("My send data$adminMap");
    Future.delayed(const Duration(seconds: 5));
    final response = await post(Uri.parse(url), body: adminMap);

    //printing the response body
    print("createAdmin API response: ${response.body}");
  }
}
