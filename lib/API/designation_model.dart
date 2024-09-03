import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:taskflow_application/API/api_info.dart';

class Designation extends ChangeNotifier {
  String? iid;
  String? id;
  String? name;

  Designation({this.iid, this.id, this.name});

  //static list variable
  static List<Designation> designationList = [];

//factory constructor for the to map
  factory Designation.fromMap(Map<String, dynamic> map) {
    return Designation(
      iid: map['_id'] != null ? map['_id'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  static getDesignation() async {
    try {
      String urls = "${Api.apiUrl}designation/getAllDesignation";

      //getting the data from the server
      final response = await get(Uri.parse(urls));

       final designationJson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        designationList = (designationJson['designations'] as List)
            .map((element) => Designation.fromMap(element))
            .toList();
        print(designationList[0].name);
      }else{
        //print(designationJson['error'].toString());
      }

    } catch (error) {
      print(error.toString());
    }
  }

  List<Designation> getUserDesignation(String? desId) {
    return designationList.where((member) => member.id == desId).toList();
  }

  String getDesignationName(String? id ) {
    // print(
    //     "Desingation Name: ${designationList.where((member) => member.id == id).toList().map((value) {
    //   value.name;
    // })}");
    final desg = designationList.where((member) => member.id == id).toList();
    final name = getDesignationNameWhereRoleIsOne(desg, id ?? "");
    return name ?? "";
  }

  String? getDesignationNameWhereRoleIsOne(
      List<Designation> designations, String id) {
    for (var designation in designations) {
      if (designation.id == id) {
        return designation.name;
      }
    }
    return null;
  }
}
