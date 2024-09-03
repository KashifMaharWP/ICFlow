
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/Api/api_info.dart';
import 'package:taskflow_application/Api/registration.dart';

class LicenceProvider extends ChangeNotifier {
  //FA50F-3B7E6-754C2-B3F12-F279E
  String keyId = "";
  late bool isValid;
  //Function to check the licence key
  checkKey(String licencekey, BuildContext context) async {
    try {

      //converting the licenceKey into the map format
      final keyMap = {
        "key": licencekey,
      };

      final response = await post(Uri.parse("${Api.apiUrl}licenceKey/authKey"),
          body: keyMap);

      debugPrint("Before API Body :${response.body}");
      if (response.statusCode == 200) {

        debugPrint(response.body.toString());
        debugPrint("API Body :${response.body}");

        final licenceJson = jsonDecode(response.body);

        Provider.of<RegistrationProvider>(context, listen: false).licenceKey =
            licenceJson['Licencekey']['_id'].toString();
        isValid = true;
        if (Provider.of<RegistrationProvider>(context, listen: false)
                .licenceKey !=
            "") {
          isValid = true;
        } else {
          //isValid = false;
        }


      }
    } catch (error) {
      isValid = false;
      print(error.toString());
    }
    notifyListeners();

    print("Is valid value is "+isValid.toString());
    return isValid;
  }

  void Registration(bool value){

  }
}
