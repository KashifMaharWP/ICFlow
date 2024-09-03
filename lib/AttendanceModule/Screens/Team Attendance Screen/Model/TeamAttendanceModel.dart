/// success : true
/// message : "Successfully get my team members today attendance status"
/// attendanceRecord : [{"_id":"66bdd9ea09547315852d9c00","checkIn":{"latitude":26.2317887,"longitude":68.3887243,"time":"03:35:20 PM"},"user":{"_id":"66ba0ee581d574007b07fb59","fullName":"Abdul Haque","contact":"03203067539","email":"abhaqueburiro90@gmail.com","password":"123123","address":"Nawabshah","role":"3","designation":"1","createdBy":"66bb20e04761d73b74f6f8fd","jobType":"4","status":false,"companyId":"66ba0d4aeb042864cd040b6c","__v":0},"date":"Thu Aug 15 2024","__v":0,"checkOut":{"latitude":26.2317894,"longitude":68.3887376,"time":"03:35:28 PM"},"duration":{"hours":0,"minutes":0,"seconds":8},"status":"present"}]

class TeamAttendanceModel {
  TeamAttendanceModel({
      bool? success, 
      String? message, 
      List<AttendanceRecord>? attendanceRecord,}){
    _success = success;
    _message = message;
    _attendanceRecord = attendanceRecord;
}

  TeamAttendanceModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['attendanceRecord'] != null) {
      _attendanceRecord = [];
      json['attendanceRecord'].forEach((v) {
        _attendanceRecord?.add(AttendanceRecord.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<AttendanceRecord>? _attendanceRecord;
TeamAttendanceModel copyWith({  bool? success,
  String? message,
  List<AttendanceRecord>? attendanceRecord,
}) => TeamAttendanceModel(  success: success ?? _success,
  message: message ?? _message,
  attendanceRecord: attendanceRecord ?? _attendanceRecord,
);
  bool? get success => _success;
  String? get message => _message;
  List<AttendanceRecord>? get attendanceRecord => _attendanceRecord;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_attendanceRecord != null) {
      map['attendanceRecord'] = _attendanceRecord?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "66bdd9ea09547315852d9c00"
/// checkIn : {"latitude":26.2317887,"longitude":68.3887243,"time":"03:35:20 PM"}
/// user : {"_id":"66ba0ee581d574007b07fb59","fullName":"Abdul Haque","contact":"03203067539","email":"abhaqueburiro90@gmail.com","password":"123123","address":"Nawabshah","role":"3","designation":"1","createdBy":"66bb20e04761d73b74f6f8fd","jobType":"4","status":false,"companyId":"66ba0d4aeb042864cd040b6c","__v":0}
/// date : "Thu Aug 15 2024"
/// __v : 0
/// checkOut : {"latitude":26.2317894,"longitude":68.3887376,"time":"03:35:28 PM"}
/// duration : {"hours":0,"minutes":0,"seconds":8}
/// status : "present"

class AttendanceRecord {
  AttendanceRecord({
      String? id, 
      CheckIn? checkIn, 
      User? user, 
      String? date, 
      num? v, 
      CheckOut? checkOut, 
      Duration? duration, 
      String? status,}){
    _id = id;
    _checkIn = checkIn;
    _user = user;
    _date = date;
    _v = v;
    _checkOut = checkOut;
    _duration = duration;
    _status = status;
}

  AttendanceRecord.fromJson(dynamic json) {
    _id = json['_id'];
    _checkIn = json['checkIn'] != null ? CheckIn.fromJson(json['checkIn']) : null;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _date = json['date'];
    _v = json['__v'];
    _checkOut = json['checkOut'] != null ? CheckOut.fromJson(json['checkOut']) : null;
    _duration = json['duration'] != null ? Duration.fromJson(json['duration']) : null;
    _status = json['status'];
  }
  String? _id;
  CheckIn? _checkIn;
  User? _user;
  String? _date;
  num? _v;
  CheckOut? _checkOut;
  Duration? _duration;
  String? _status;
AttendanceRecord copyWith({  String? id,
  CheckIn? checkIn,
  User? user,
  String? date,
  num? v,
  CheckOut? checkOut,
  Duration? duration,
  String? status,
}) => AttendanceRecord(  id: id ?? _id,
  checkIn: checkIn ?? _checkIn,
  user: user ?? _user,
  date: date ?? _date,
  v: v ?? _v,
  checkOut: checkOut ?? _checkOut,
  duration: duration ?? _duration,
  status: status ?? _status,
);
  String? get id => _id;
  CheckIn? get checkIn => _checkIn;
  User? get user => _user;
  String? get date => _date;
  num? get v => _v;
  CheckOut? get checkOut => _checkOut;
  Duration? get duration => _duration;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_checkIn != null) {
      map['checkIn'] = _checkIn?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['date'] = _date;
    map['__v'] = _v;
    if (_checkOut != null) {
      map['checkOut'] = _checkOut?.toJson();
    }
    if (_duration != null) {
      map['duration'] = _duration?.toJson();
    }
    map['status'] = _status;
    return map;
  }

}

/// hours : 0
/// minutes : 0
/// seconds : 8

class Duration {
  Duration({
      num? hours, 
      num? minutes, 
      num? seconds,}){
    _hours = hours;
    _minutes = minutes;
    _seconds = seconds;
}

  Duration.fromJson(dynamic json) {
    _hours = json['hours'];
    _minutes = json['minutes'];
    _seconds = json['seconds'];
  }
  num? _hours;
  num? _minutes;
  num? _seconds;
Duration copyWith({  num? hours,
  num? minutes,
  num? seconds,
}) => Duration(  hours: hours ?? _hours,
  minutes: minutes ?? _minutes,
  seconds: seconds ?? _seconds,
);
  num? get hours => _hours;
  num? get minutes => _minutes;
  num? get seconds => _seconds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hours'] = _hours;
    map['minutes'] = _minutes;
    map['seconds'] = _seconds;
    return map;
  }

}

/// latitude : 26.2317894
/// longitude : 68.3887376
/// time : "03:35:28 PM"

class CheckOut {
  CheckOut({
      num? latitude, 
      num? longitude, 
      String? time,}){
    _latitude = latitude;
    _longitude = longitude;
    _time = time;
}

  CheckOut.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _time = json['time'];
  }
  num? _latitude;
  num? _longitude;
  String? _time;
CheckOut copyWith({  num? latitude,
  num? longitude,
  String? time,
}) => CheckOut(  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  time: time ?? _time,
);
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['time'] = _time;
    return map;
  }

}

/// _id : "66ba0ee581d574007b07fb59"
/// fullName : "Abdul Haque"
/// contact : "03203067539"
/// email : "abhaqueburiro90@gmail.com"
/// password : "123123"
/// address : "Nawabshah"
/// role : "3"
/// designation : "1"
/// createdBy : "66bb20e04761d73b74f6f8fd"
/// jobType : "4"
/// status : false
/// companyId : "66ba0d4aeb042864cd040b6c"
/// __v : 0

class User {
  User({
      String? id, 
      String? fullName, 
      String? contact, 
      String? email, 
      String? password, 
      String? address, 
      String? role, 
      String? designation, 
      String? createdBy, 
      String? jobType, 
      bool? status, 
      String? companyId, 
      num? v,}){
    _id = id;
    _fullName = fullName;
    _contact = contact;
    _email = email;
    _password = password;
    _address = address;
    _role = role;
    _designation = designation;
    _createdBy = createdBy;
    _jobType = jobType;
    _status = status;
    _companyId = companyId;
    _v = v;
}

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _fullName = json['fullName'];
    _contact = json['contact'];
    _email = json['email'];
    _password = json['password'];
    _address = json['address'];
    _role = json['role'];
    _designation = json['designation'];
    _createdBy = json['createdBy'];
    _jobType = json['jobType'];
    _status = json['status'];
    _companyId = json['companyId'];
    _v = json['__v'];
  }
  String? _id;
  String? _fullName;
  String? _contact;
  String? _email;
  String? _password;
  String? _address;
  String? _role;
  String? _designation;
  String? _createdBy;
  String? _jobType;
  bool? _status;
  String? _companyId;
  num? _v;
User copyWith({  String? id,
  String? fullName,
  String? contact,
  String? email,
  String? password,
  String? address,
  String? role,
  String? designation,
  String? createdBy,
  String? jobType,
  bool? status,
  String? companyId,
  num? v,
}) => User(  id: id ?? _id,
  fullName: fullName ?? _fullName,
  contact: contact ?? _contact,
  email: email ?? _email,
  password: password ?? _password,
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
  String? get password => _password;
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
    map['password'] = _password;
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

/// latitude : 26.2317887
/// longitude : 68.3887243
/// time : "03:35:20 PM"

class CheckIn {
  CheckIn({
      num? latitude, 
      num? longitude, 
      String? time,}){
    _latitude = latitude;
    _longitude = longitude;
    _time = time;
}

  CheckIn.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _time = json['time'];
  }
  num? _latitude;
  num? _longitude;
  String? _time;
CheckIn copyWith({  num? latitude,
  num? longitude,
  String? time,
}) => CheckIn(  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  time: time ?? _time,
);
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['time'] = _time;
    return map;
  }

}