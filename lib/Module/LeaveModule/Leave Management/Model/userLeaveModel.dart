/// success : true
/// message : "successfully get my all leaves"
/// myLeaves : [{"_id":"66fa3a07c86c19633555a081","description":"Testing Leave","teamHead":{"_id":"66d83bebcc30c4a7c4c6911b","fullName":"Sayed Amjad Ali ","email":"shahsayedamjadali@gmail.com"},"user":{"_id":"66d83de6cc30c4a7c4c69142","fullName":"Majid Ali","email":"majidalijkhio@gmail.com"},"intialDate":"30 09 2024","endDate":"30 09 2024","totalDays":1}]

class UserLeaveModel {
  UserLeaveModel({
      bool? success, 
      String? message, 
      List<MyLeaves>? myLeaves,}){
    _success = success;
    _message = message;
    _myLeaves = myLeaves;
}

  UserLeaveModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['myLeaves'] != null) {
      _myLeaves = [];
      json['myLeaves'].forEach((v) {
        _myLeaves?.add(MyLeaves.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<MyLeaves>? _myLeaves;
UserLeaveModel copyWith({  bool? success,
  String? message,
  List<MyLeaves>? myLeaves,
}) => UserLeaveModel(  success: success ?? _success,
  message: message ?? _message,
  myLeaves: myLeaves ?? _myLeaves,
);
  bool? get success => _success;
  String? get message => _message;
  List<MyLeaves>? get myLeaves => _myLeaves;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_myLeaves != null) {
      map['myLeaves'] = _myLeaves?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "66fa3a07c86c19633555a081"
/// description : "Testing Leave"
/// teamHead : {"_id":"66d83bebcc30c4a7c4c6911b","fullName":"Sayed Amjad Ali ","email":"shahsayedamjadali@gmail.com"}
/// user : {"_id":"66d83de6cc30c4a7c4c69142","fullName":"Majid Ali","email":"majidalijkhio@gmail.com"}
/// intialDate : "30 09 2024"
/// endDate : "30 09 2024"
/// totalDays : 1

class MyLeaves {
  MyLeaves({
      String? id, 
      String? description, 
      TeamHead? teamHead, 
      User? user, 
      String? intialDate, 
      String? endDate, 
      num? totalDays,}){
    _id = id;
    _description = description;
    _teamHead = teamHead;
    _user = user;
    _intialDate = intialDate;
    _endDate = endDate;
    _totalDays = totalDays;
}

  MyLeaves.fromJson(dynamic json) {
    _id = json['_id'];
    _description = json['description'];
    _teamHead = json['teamHead'] != null ? TeamHead.fromJson(json['teamHead']) : null;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _intialDate = json['intialDate'];
    _endDate = json['endDate'];
    _totalDays = json['totalDays'];
  }
  String? _id;
  String? _description;
  TeamHead? _teamHead;
  User? _user;
  String? _intialDate;
  String? _endDate;
  num? _totalDays;
MyLeaves copyWith({  String? id,
  String? description,
  TeamHead? teamHead,
  User? user,
  String? intialDate,
  String? endDate,
  num? totalDays,
}) => MyLeaves(  id: id ?? _id,
  description: description ?? _description,
  teamHead: teamHead ?? _teamHead,
  user: user ?? _user,
  intialDate: intialDate ?? _intialDate,
  endDate: endDate ?? _endDate,
  totalDays: totalDays ?? _totalDays,
);
  String? get id => _id;
  String? get description => _description;
  TeamHead? get teamHead => _teamHead;
  User? get user => _user;
  String? get intialDate => _intialDate;
  String? get endDate => _endDate;
  num? get totalDays => _totalDays;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['description'] = _description;
    if (_teamHead != null) {
      map['teamHead'] = _teamHead?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['intialDate'] = _intialDate;
    map['endDate'] = _endDate;
    map['totalDays'] = _totalDays;
    return map;
  }

}

/// _id : "66d83de6cc30c4a7c4c69142"
/// fullName : "Majid Ali"
/// email : "majidalijkhio@gmail.com"

class User {
  User({
      String? id, 
      String? fullName, 
      String? email,}){
    _id = id;
    _fullName = fullName;
    _email = email;
}

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _fullName = json['fullName'];
    _email = json['email'];
  }
  String? _id;
  String? _fullName;
  String? _email;
User copyWith({  String? id,
  String? fullName,
  String? email,
}) => User(  id: id ?? _id,
  fullName: fullName ?? _fullName,
  email: email ?? _email,
);
  String? get id => _id;
  String? get fullName => _fullName;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['fullName'] = _fullName;
    map['email'] = _email;
    return map;
  }

}

/// _id : "66d83bebcc30c4a7c4c6911b"
/// fullName : "Sayed Amjad Ali "
/// email : "shahsayedamjadali@gmail.com"

class TeamHead {
  TeamHead({
      String? id, 
      String? fullName, 
      String? email,}){
    _id = id;
    _fullName = fullName;
    _email = email;
}

  TeamHead.fromJson(dynamic json) {
    _id = json['_id'];
    _fullName = json['fullName'];
    _email = json['email'];
  }
  String? _id;
  String? _fullName;
  String? _email;
TeamHead copyWith({  String? id,
  String? fullName,
  String? email,
}) => TeamHead(  id: id ?? _id,
  fullName: fullName ?? _fullName,
  email: email ?? _email,
);
  String? get id => _id;
  String? get fullName => _fullName;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['fullName'] = _fullName;
    map['email'] = _email;
    return map;
  }

}