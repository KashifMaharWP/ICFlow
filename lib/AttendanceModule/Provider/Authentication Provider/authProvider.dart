import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../Utills/Global Class/GlobalAPI.dart';
import '../../Utills/Global Class/userDataList.dart';
import '../../Utills/Global Functions/SnackBar.dart';


class AuthProvider extends ChangeNotifier{
  bool _loading=false;

  bool get loading=>_loading;

  setLoading(bool value){
    _loading=value;
    notifyListeners();
  }


 void login(String email,password,BuildContext context,) async{
    setLoading(true);
   String url='${ApiDetail.BaseAPI}${ApiDetail.loginAPI}';
   print(url);

    try{
      http.Response response = await post(Uri.parse(url),
     body: {
        "email":email,
       "password":password
     }
     );
      print("object");
     if(response.statusCode==200){
       final json = jsonDecode(response.body) as Map<String,dynamic>;
     if(json.isNotEmpty)
      {
       //final user = json['user_'] as Map<String, dynamic>;
        //var userModel = UserModel.fromMap(user);
        UserDataList.token = json['token'].toString();
        print("Token ; ${UserDataList.token}");
       //UserDataList.userid = json['id'];
        /*UserDataList.username = json['fullName'].toString();
        //UserDataList.userprofilePicture = userModel.profilePicture.toString();;
        //UserDataList.userbirthDate = userModel.birthDate;
        //UserDataList.userdesignation = userModel.designation.toString();;
        //UserDataList.userskill = userModel.skill;
        //UserDataList.userbranchName = userModel.branchName.toString();
        UserDataList.userphoneNo = json['contact'].toString();
        UserDataList.useremail = json['email'].toString();
        UserDataList.userAddress=json['address'];*/
        //print("${UserDataList.userAddress}");
        //setUser(user);
        //print("This is Token ${UserDataList.token}");

       print("Login Successful");
       //print("${json}");
       setLoading(false);
       //print("Thiss is Response : ${response.body}  to This :::");

        //print("Thiss is Response Header : ${response.headers}");



      }
     }
     else if(response.statusCode==401){
       print("Wrong User Crdential");
       showErrorSnackbar("Wrong User Crdential", context);
     }
     else{
       print("Server is Not Responsing");
       setLoading(false);
       showErrorSnackbar("Server is Not Responsing", context);

     }

    }
    catch(e){
      print(e);
      showErrorSnackbar("There is Error is occured during Connection: ${e}", context);
      setLoading(false);

    }
  }


  /*void signup(String username, email,password,BuildContext context) async{
    setLoading(true);
    String url='${ApiDetail.BaseAPI}${ApiDetail.SignUpAPI}';
    try{
      Response response = await post(Uri.parse(url),
          body: {
            "username":username,
            "email":email,
            "password":password
          },

      );
      if(response.statusCode==200){

        print("User Created Successfully");
        setLoading(false);
        //Navigator.push(context,MaterialPageRoute(builder: (context)=>homePage(user: user,)));
      }
      else{
        print("provided email is already registered ${response.statusCode}");
        setLoading(false);
      }

    }
    catch(e){
      print(e);
      setLoading(false);
    }
  }
*/
}