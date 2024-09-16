/// success : true
/// message : "successfully get all teamHeads names"
/// teamHeads : [{"_id":"66a393f3d421667b19e0cc6f","fullName":"usman","email":"usvighio11@gmail.com","status":false},{"_id":"66a732bd75c2cc9c58cd53a9","fullName":"MAJID","email":"majid@gmail.com","status":false},{"_id":"66a9e20e15f7713176e64191","fullName":"Mashood ","email":"mashood2020@gmail.com","status":false},{"_id":"66a9e2a1da26ff35b00465f9","fullName":"Mashood ","email":"mashood200@gmail.com","status":false},{"_id":"66a9e2eada26ff35b00465fd","fullName":"Mashood ","email":"mashood2011@gmail.com","status":false},{"_id":"66a9e363da26ff35b0046601","fullName":"Mashood ","email":"mashood2091@gmail.com","status":false},{"_id":"66aa4155bbd698a785bf7817","fullName":"arshad","email":"arshad@gmail.com","status":false}]

class TeamLeadListModel {
  TeamLeadListModel({
      bool? success, 
      String? message, 
      List<TeamHeads>? teamHeads,}){
    _success = success;
    _message = message;
    _teamHeads = teamHeads;
}

  TeamLeadListModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['teamHeads'] != null) {
      _teamHeads = [];
      json['teamHeads'].forEach((v) {
        _teamHeads?.add(TeamHeads.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<TeamHeads>? _teamHeads;
TeamLeadListModel copyWith({  bool? success,
  String? message,
  List<TeamHeads>? teamHeads,
}) => TeamLeadListModel(  success: success ?? _success,
  message: message ?? _message,
  teamHeads: teamHeads ?? _teamHeads,
);
  bool? get success => _success;
  String? get message => _message;
  List<TeamHeads>? get teamHeads => _teamHeads;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_teamHeads != null) {
      map['teamHeads'] = _teamHeads?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "66a393f3d421667b19e0cc6f"
/// fullName : "usman"
/// email : "usvighio11@gmail.com"
/// status : false

class TeamHeads {
  TeamHeads({
      String? id, 
      String? fullName, 
      String? email, 
      bool? status,}){
    _id = id;
    _fullName = fullName;
    _email = email;
    _status = status;
}

  TeamHeads.fromJson(dynamic json) {
    _id = json['_id'];
    _fullName = json['fullName'];
    _email = json['email'];
    _status = json['status'];
  }
  String? _id;
  String? _fullName;
  String? _email;
  bool? _status;
TeamHeads copyWith({  String? id,
  String? fullName,
  String? email,
  bool? status,
}) => TeamHeads(  id: id ?? _id,
  fullName: fullName ?? _fullName,
  email: email ?? _email,
  status: status ?? _status,
);
  String? get id => _id;
  String? get fullName => _fullName;
  String? get email => _email;
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['fullName'] = _fullName;
    map['email'] = _email;
    map['status'] = _status;
    return map;
  }

}