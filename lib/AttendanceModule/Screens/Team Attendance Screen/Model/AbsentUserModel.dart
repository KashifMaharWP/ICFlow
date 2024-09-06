/// success : true
/// message : "successfully get all Absent Users "
/// absentUsers : [{"_id":"66ba0d96eb042864cd040b6f","fullName":"Sahib Dino Shar","designation":"Senior Web Developer","jobType":"Full Time"},{"_id":"66d80f4b963dae137634bfcf","fullName":"Mir Murstaz ","designation":"Junior Web Developer","jobType":"Full Time Intern"},{"_id":"66d81021963dae137634bfe7","fullName":"Fida Hussain","designation":"Senior SEO Expert","jobType":"Full Time"},{"_id":"66d81460963dae137634c09d","fullName":"Ahad Hyder ","designation":"Senior Graphic Designer","jobType":"Full Time"},{"_id":"66d816dc963dae137634c0dd","fullName":"Muntaha Adnan","designation":"Junior Graphic Designer","jobType":"Full Time"},{"_id":"66d8336d2f1df7ce25f7ffd4","fullName":"Naeem Abbas","designation":"Junior SEO Expert","jobType":"Full Time"},{"_id":"66d83bb005de98df99a858d7","fullName":"Usman Vighio","designation":"Junior Flutter Developer","jobType":"Full Time"},{"_id":"66d83f417a61413d3c511760","fullName":"Abdul Haseeb ","designation":"Junior Graphic Designer","jobType":"Part Time"},{"_id":"66d93af8aab6d94ef884bfec","fullName":"Nadeem Shar","designation":"Junior Backend Developer","jobType":"Full Time"},{"_id":"66d95776aab6d94ef884c3dd","fullName":"Areeba Memon","designation":"Junior SEO Expert","jobType":"Full Time Intern"},{"_id":"66d9585caab6d94ef884c40a","fullName":"Wanahat Ahmed","designation":"Junior SEO Expert","jobType":"Full Time Intern"},{"_id":"66d959c9aab6d94ef884c443","fullName":"Syed Atif Ali","designation":"Junior SEO Expert","jobType":"Full Time Intern"},{"_id":"66d9609aaab6d94ef884c4b7","fullName":"Areeza Bhanbhro","designation":"Junior SEO Expert","jobType":"Full Time Intern"},{"_id":"66d96209aab6d94ef884c4d1","fullName":"Khizra Iqbal","designation":"Junior SEO Expert","jobType":"Full Time Intern"},{"_id":"66d96e96aab6d94ef884c63b","fullName":"Rashid","designation":"Junior Web Developer","jobType":"Full Time"},{"_id":"66d988d3457fcd2faa60967a","fullName":"Raniya Raza","designation":"Junior Backend Developer","jobType":"Part Time Intern"},{"_id":"66d99cdf5953ee3963a0a191","fullName":"Danyal Asad","designation":"Junior Backend Developer","jobType":"Part Time Intern"}]
/// count : 17

class AbsentUserModel {
  AbsentUserModel({
      bool? success, 
      String? message, 
      List<AbsentUsers>? absentUsers, 
      num? count,}){
    _success = success;
    _message = message;
    _absentUsers = absentUsers;
    _count = count;
}

  AbsentUserModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['absentUsers'] != null) {
      _absentUsers = [];
      json['absentUsers'].forEach((v) {
        _absentUsers?.add(AbsentUsers.fromJson(v));
      });
    }
    _count = json['count'];
  }
  bool? _success;
  String? _message;
  List<AbsentUsers>? _absentUsers;
  num? _count;
AbsentUserModel copyWith({  bool? success,
  String? message,
  List<AbsentUsers>? absentUsers,
  num? count,
}) => AbsentUserModel(  success: success ?? _success,
  message: message ?? _message,
  absentUsers: absentUsers ?? _absentUsers,
  count: count ?? _count,
);
  bool? get success => _success;
  String? get message => _message;
  List<AbsentUsers>? get absentUsers => _absentUsers;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_absentUsers != null) {
      map['absentUsers'] = _absentUsers?.map((v) => v.toJson()).toList();
    }
    map['count'] = _count;
    return map;
  }

}

/// _id : "66ba0d96eb042864cd040b6f"
/// fullName : "Sahib Dino Shar"
/// designation : "Senior Web Developer"
/// jobType : "Full Time"

class AbsentUsers {
  AbsentUsers({
      String? id, 
      String? fullName, 
      String? designation, 
      String? jobType,}){
    _id = id;
    _fullName = fullName;
    _designation = designation;
    _jobType = jobType;
}

  AbsentUsers.fromJson(dynamic json) {
    _id = json['_id'];
    _fullName = json['fullName'];
    _designation = json['designation'];
    _jobType = json['jobType'];
  }
  String? _id;
  String? _fullName;
  String? _designation;
  String? _jobType;
AbsentUsers copyWith({  String? id,
  String? fullName,
  String? designation,
  String? jobType,
}) => AbsentUsers(  id: id ?? _id,
  fullName: fullName ?? _fullName,
  designation: designation ?? _designation,
  jobType: jobType ?? _jobType,
);
  String? get id => _id;
  String? get fullName => _fullName;
  String? get designation => _designation;
  String? get jobType => _jobType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['fullName'] = _fullName;
    map['designation'] = _designation;
    map['jobType'] = _jobType;
    return map;
  }

}