class AbsentUserModel {
  AbsentUserModel({
    bool? success,
    String? message,
    List<AbsentUsers>? absentUsers,
    num? count,
  }) {
    _success = success;
    _message = message;
    _absentUsers = absentUsers;
    _count = count;
  }

  AbsentUserModel.fromJson(dynamic json) {
    _success = json['success'] ?? false; // Default to false if null
    _message = json['message'] ?? ''; // Default to empty string if null
    if (json['absentUsers'] != null) {
      _absentUsers = [];
      json['absentUsers'].forEach((v) {
        _absentUsers?.add(AbsentUsers.fromJson(v));
      });
    }
    _count = json['count'] ?? 0; // Default to 0 if null
  }

  bool? _success;
  String? _message;
  List<AbsentUsers>? _absentUsers;
  num? _count;

  AbsentUserModel copyWith({
    bool? success,
    String? message,
    List<AbsentUsers>? absentUsers,
    num? count,
  }) =>
      AbsentUserModel(
        success: success ?? _success,
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

class AbsentUsers {
  AbsentUsers({
    String? id,
    String? fullName,
    String? contact,
    String? email,
    String? address,
    String? role,
    String? designation,
    String? createdBy,
    String? jobType,
    bool? status,
    String? companyId,
    num? v,
  }) {
    _id = id;
    _fullName = fullName;
    _contact = contact;
    _email = email;
    _address = address;
    _role = role;
    _designation = designation;
    _createdBy = createdBy;
    _jobType = jobType;
    _status = status;
    _companyId = companyId;
    _v = v;
  }

  AbsentUsers.fromJson(dynamic json) {
    _id = json['_id'] ?? ''; // Default to empty string if null
    _fullName = json['fullName'] ?? ''; // Default to empty string
    _contact = json['contact'] ?? ''; // Default to empty string
    _email = json['email'] ?? ''; // Default to empty string
    _address = json['address'] ?? ''; // Default to empty string
    _role = json['role'] ?? ''; // Default to empty string
    _designation = json['designation'] ?? ''; // Default to empty string
    _createdBy = json['createdBy'] ?? ''; // Default to empty string
    _jobType = json['jobType'] ?? ''; // Default to empty string
    _status = json['status'] ?? false; // Default to false if null
    _companyId = json['companyId'] ?? ''; // Default to empty string
    _v = json['__v'] ?? 0; // Default to 0 if null
  }

  String? _id;
  String? _fullName;
  String? _contact;
  String? _email;
  String? _address;
  String? _role;
  String? _designation;
  String? _createdBy;
  String? _jobType;
  bool? _status;
  String? _companyId;
  num? _v;

  AbsentUsers copyWith({
    String? id,
    String? fullName,
    String? contact,
    String? email,
    String? address,
    String? role,
    String? designation,
    String? createdBy,
    String? jobType,
    bool? status,
    String? companyId,
    num? v,
  }) =>
      AbsentUsers(
        id: id ?? _id,
        fullName: fullName ?? _fullName,
        contact: contact ?? _contact,
        email: email ?? _email,
        address: address ?? _address,
        role: role ?? _role,
        designation: designation ?? _designation,
        createdBy: createdBy ?? _createdBy,
        jobType: jobType ?? _jobType,
        status: status ?? _status,
        companyId: companyId ?? _companyId,
        v: v ?? _v,
      );

  String? get id => _id;
  String? get fullName => _fullName;
  String? get contact => _contact;
  String? get email => _email;
  String? get address => _address;
  String? get role => _role;
  String? get designation => _designation;
  String? get createdBy => _createdBy;
  String? get jobType => _jobType;
  bool? get status => _status;
  String? get companyId => _companyId;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['fullName'] = _fullName;
    map['contact'] = _contact;
    map['email'] = _email;
    map['address'] = _address;
    map['role'] = _role;
    map['designation'] = _designation;
    map['createdBy'] = _createdBy;
    map['jobType'] = _jobType;
    map['status'] = _status;
    map['companyId'] = _companyId;
    map['__v'] = _v;
    return map;
  }
}
