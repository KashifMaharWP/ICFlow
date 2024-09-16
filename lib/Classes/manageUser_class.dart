import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/api_info.dart';
import 'package:taskflow_application/API/login_user_detail.dart';

class UsersCatalog {
  static final userlist = [
    ManageUser(
        fullname: "Usman Vighio",
        email: "usvighio@gmail.com",
        contact: "03186657325",
        address: "abcd",
        companyId: "123123",
        jobTypeId: "Full-Time-Intern",
        roleId: "1",
        designationId: "1",
        password: "Usman2002"),
    ManageUser(
        fullname: "Kashif",
        email: "kashif@gmail.com",
        contact: "0324234",
        address: "abcd",
        companyId: "123123",
        jobTypeId: "Full-Time-Intern",
        roleId: "2",
        designationId: "1",
        password: "kashif123"),
    ManageUser(
        fullname: "Ahsan Chandio",
        email: "ahsan@gmail.com",
        contact: "03132342322",
        address: "abcd",
        companyId: "123123",
        jobTypeId: "Part-Time-Intern",
        roleId: "3",
        designationId: "1",
        password: "ahsan54321")
  ];
}

class ManageUser extends ChangeNotifier {
  String? userId;
  String? fullname;
  String? email;
  String? contact;
  String? address;
  String? companyId;
  String? createdBy;
  String? jobTypeId;
  String? roleId;
  String? designationId;
  String? password;
  String? token;

  ManageUser(
      {this.userId,
      this.fullname,
      this.email,
      this.contact,
      this.address,
      this.companyId,
      this.createdBy,
      this.jobTypeId,
      this.roleId,
      this.designationId,
      this.password});

  List<ManageUser> allUsersList = [];
// from map function
  factory ManageUser.fromMap(Map<String, dynamic> map) {
    return ManageUser(
      userId: map['_id'].toString(),
      fullname: map['fullName'].toString(),
      email: map['email'].toString(),
      contact: map['contact'].toString(),
      address: map['address'].toString(),
      password: map['password'].toString(),
      companyId: map['companyId'].toString(),
      createdBy: map['createdBy'].toString(),
      jobTypeId: map['jobType'].toString(),
      roleId: map['role'].toString(),
      designationId: map['designation'].toString(),
    );
  }

//function to Add the user from the admin or team lead side
  Future<bool>addUser() async {
    bool isloading = false;
    try {
      final userBodyMap = {
        'fullName': fullname,
        'contact': contact,
        'email': email,
        'address': address,
        'password': password,
        'companyId': companyId,
        'jobType': jobTypeId,
        'designation': designationId,
        'role': roleId,
      };

      print("My Send Data$userBodyMap");

      final response = await post(Uri.parse("${Api.apiUrl}user/create"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(userBodyMap));
      debugPrint(response.body);
      if (response.statusCode == 200) {
        isloading = true;
      } else {
        isloading = false;
        debugPrint(response.statusCode.toString());
      }
    } catch (error) {
      isloading = false;
      print(error.toString());
    }

    return isloading;
  }

//function to get all the users form the database
 Future<bool> getAllUsers(BuildContext context) async {
  bool isloading = false;
    try {
      print("Token: ${Provider.of<UserDetail>(context, listen: false).token}");
      final response = await get(
        Uri.parse("${Api.apiUrl}user/getMyAllUsers"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
        },
      );

      if (response.statusCode == 200) {
        debugPrint("Getting Users Data:${response.body}");
        final userJson = jsonDecode(response.body);
        allUsersList = (userJson['myUsers'] as List)
            .map((element) => ManageUser.fromMap(element))
            .toList();
        
        isloading = true;
        print("No Of Users found: ${allUsersList.length}");
      } else {
        debugPrint(response.statusCode.toString());
        
        isloading = false; 
      }
    } catch (error) {
      print(error.toString());
      return false;
    }
    return isloading;
  }
}
