import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetail extends ChangeNotifier {
  String? id;
  String? fullname;
  String? contact;
  String? email;
  String? address;
  String? roleId;
  String? designationId;
  String? jobTypeId;
  String? companyId;
  String? token;
  //picture variable will be used later
  String? picture;


//method to set the user pereferences when the user body is get
  void setUserDetail(final userData) {
    id = userData['user_']['_id'].toString();
    fullname = userData['user_']['fullName'].toString();
    contact = userData['user_']['contact'].toString();
    email = userData['user_']['email'].toString();
    address = userData['user_']['address'].toString();
    roleId = userData['user_']['role'].toString();
    designationId = userData['user_']['designation'].toString();
    jobTypeId = userData['user_']['jobType'].toString();
    companyId = userData['user_']['companyId'].toString();
    token = userData['token'].toString();
    //uncomment the below to get the picture
    picture = userData['user_']['picture'].toString();
    print("Picture Details: ${picture}");
    //setting the User Preferences into the local store to analyze the user login and then access him through the local storage
    setUserPreferences();
  }

//set user data throught the Preferences;
void setUserDetailByPreferences() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();

     id = prefs.getString("userId");
    fullname = prefs.getString("fullName");
    contact = prefs.getString("contact");
    email = prefs.getString("email");
    address = prefs.getString("address");
    roleId = prefs.getString("roleId");
    designationId = prefs.getString("designationId");
    jobTypeId = prefs.getString("jobTypeId");
    companyId = prefs.getString("companyId");
    token = prefs.getString("token");
    //uncomment the  below to store the picture preferences;
    picture = prefs.getString("picture");
  print("PICTURE DETAILS ${picture}");

}

  Future setUserPreferences() async {
    print("Going to store the preferences in the Local Storage: $id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", "11");
    await prefs.setString("fullName", fullname.toString());
    await prefs.setString("contact", contact.toString());
    await prefs.setString("email", email.toString());
    await prefs.setString("address", address.toString());
    await prefs.setString("roleId", roleId.toString());
    await prefs.setString("designationId", designationId.toString());
    await prefs.setString("jobTypeId", jobTypeId.toString());
    await prefs.setString("companyId", companyId.toString());
    await prefs.setString("token", token.toString());
    await prefs.setString("picture", picture.toString());

    //uncomment the below to store the picture preferences
    //await prefs.setString("Picture", "");
  }


//function to clear all the user preferences 
   Future clearUserPreferences() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove("userId");
    await prefs.remove("fullName");
    await prefs.remove("contact");
    await prefs.remove("email");
    await prefs.remove("address");
    await prefs.remove("roleId");
    await prefs.remove("designationId");
    await prefs.remove("jobTypeId");
    await prefs.remove("companyId");
    await prefs.remove("token");
    await prefs.remove("picture");

     // Uncomment the below to clear the picture preferences (if it's named differently)
     // await prefs.remove("Picture");
  }
}
