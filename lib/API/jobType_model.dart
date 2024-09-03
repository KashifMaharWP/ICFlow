import 'dart:convert';

import 'package:http/http.dart';
import 'package:taskflow_application/Api/api_info.dart';

class JobType {
  String? iid;
  String? id;
  String? name;

  JobType({this.iid, this.id, this.name});

  //here is the static variable to store the job types
  static List<JobType> jobTypeslist = [];

  factory JobType.fromMap(Map<String, dynamic> map) {
    return JobType(
        iid: map['_id'] != null ? map['_id'] as String : null,
        id: map['id'] != null ? map['id'] as String : null,
        name: map['name'] != null ? map['name'] as String : null);
  }

//function to get the job type from server
  static getJobType() async {
    try{
    String urls = "${Api.apiUrl}jobType/getALlJobTypes";

    //getting the data from the server
    final response = await get(Uri.parse(urls));

    if (response.statusCode == 200) {
      print("Job Type Body:${response.body}");
      final jobTypeJson = jsonDecode(response.body);
      jobTypeslist = (jobTypeJson['jobTypes'] as List)
          .map((element) => JobType.fromMap(element))
          .toList();
    }
    }
    catch(error){
      print(error.toString());
    }
  }
}
