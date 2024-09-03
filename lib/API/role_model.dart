// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/Api/api_info.dart';
import 'login_user_detail.dart';

class Role {
  String? iid;
  String? id;
  String? name;

  Role({
    this.iid,
    this.id,
    this.name,
  });

  static List<Role> rolesMap = [];

  static getRole(BuildContext context) async {
    try{
    String urls = "${Api.apiUrl}role/getAllRoles";
    final response = await get(Uri.parse(urls),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}'
      },
    );

    print("ROLE API: ${response.body}");
    if (response.statusCode == 200) {

      final roleJson = jsonDecode(response.body);
      //final rolesdata = roleJson['roles'];
      rolesMap = (roleJson['roles'] as List)
          .map((element) => Role.fromMap(element))
          .toList();

    }
    }catch(error){
      print(error.toString());
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'iid': iid,
      'id': id,
      'name': name,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      iid: map['_id'] != null ? map['_id'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      iid: json['_id'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
    );
  }

  @override
  String toString() => 'Role(iid: $iid, id: $id, name: $name)';

  @override
  bool operator ==(covariant Role other) {
    if (identical(this, other)) return true;

    return other.iid == iid && other.id == id && other.name == name;
  }

  @override
  int get hashCode => iid.hashCode ^ id.hashCode ^ name.hashCode;
}
