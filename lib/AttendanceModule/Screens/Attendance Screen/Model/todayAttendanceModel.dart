/// attendance : {"_id":"66dc77165fbc6333a1b77d14","checkIn":{"latitude":26.2394802,"longitude":68.393695,"time":"08:54:30 PM"},"user":"66d83b3105de98df99a858cf","date":"Sat Sep 07 2024","__v":0,"checkOut":{"latitude":26.2395321,"longitude":68.3935272,"time":"09:09:12 PM"},"duration":{"hours":0,"minutes":14,"seconds":42},"status":"present"}
/// sucess : true
/// message : "Sucessfully get today Attendance....."

class TodayAttendanceModel {
  TodayAttendanceModel({
    Attendance? attendance,
    bool? sucess,
    String? message,
  }) {
    _attendance = attendance;
    _sucess = sucess;
    _message = message;
  }

  TodayAttendanceModel.fromJson(dynamic json) {
    _attendance =
    json['attendance'] != null ? Attendance.fromJson(json['attendance']) : null;
    _sucess = json['sucess'];
    _message = json['message'];
  }
  Attendance? _attendance;
  bool? _sucess;
  String? _message;
  TodayAttendanceModel copyWith({
    Attendance? attendance,
    bool? sucess,
    String? message,
  }) =>
      TodayAttendanceModel(
        attendance: attendance ?? _attendance,
        sucess: sucess ?? _sucess,
        message: message ?? _message,
      );
  Attendance? get attendance => _attendance;
  bool? get sucess => _sucess;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_attendance != null) {
      map['attendance'] = _attendance?.toJson();
    }
    map['sucess'] = _sucess;
    map['message'] = _message;
    return map;
  }
}

/// _id : "66dc77165fbc6333a1b77d14"
/// checkIn : {"latitude":26.2394802,"longitude":68.393695,"time":"08:54:30 PM"}
/// user : "66d83b3105de98df99a858cf"
/// date : "Sat Sep 07 2024"
/// __v : 0
/// checkOut : {"latitude":26.2395321,"longitude":68.3935272,"time":"09:09:12 PM"}
/// duration : {"hours":0,"minutes":14,"seconds":42}
/// status : "present"

class Attendance {
  Attendance({
    String? id,
    CheckIn? checkIn,
    String? user,
    String? date,
    num? v,
    CheckOut? checkOut,
    DurationRecord? durationRecord,
    String? status,
  }) {
    _id = id;
    _checkIn = checkIn;
    _user = user;
    _date = date;
    _v = v;
    _checkOut = checkOut;
    _durationRecord = durationRecord;
    _status = status;
  }

  Attendance.fromJson(dynamic json) {
    _id = json['_id'];
    _checkIn =
    json['checkIn'] != null ? CheckIn.fromJson(json['checkIn']) : null;
    _user = json['user'];
    _date = json['date'];
    _v = json['__v'];
    _checkOut =
    json['checkOut'] != null ? CheckOut.fromJson(json['checkOut']) : null;
    _durationRecord = json['duration'] != null
        ? DurationRecord.fromJson(json['duration'])
        : null;
    _status = json['status'];
  }
  String? _id;
  CheckIn? _checkIn;
  String? _user;
  String? _date;
  num? _v;
  CheckOut? _checkOut;
  DurationRecord? _durationRecord;
  String? _status;
  Attendance copyWith({
    String? id,
    CheckIn? checkIn,
    String? user,
    String? date,
    num? v,
    CheckOut? checkOut,
    DurationRecord? durationRecord,
    String? status,
  }) =>
      Attendance(
        id: id ?? _id,
        checkIn: checkIn ?? _checkIn,
        user: user ?? _user,
        date: date ?? _date,
        v: v ?? _v,
        checkOut: checkOut ?? _checkOut,
        durationRecord: durationRecord ?? _durationRecord,
        status: status ?? _status,
      );
  String? get id => _id;
  CheckIn? get checkIn => _checkIn;
  String? get user => _user;
  String? get date => _date;
  num? get v => _v;
  CheckOut? get checkOut => _checkOut;
  DurationRecord? get durationRecord => _durationRecord;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_checkIn != null) {
      map['checkIn'] = _checkIn?.toJson();
    }
    map['user'] = _user;
    map['date'] = _date;
    map['__v'] = _v;
    if (_checkOut != null) {
      map['checkOut'] = _checkOut?.toJson();
    }
    if (_durationRecord != null) {
      map['duration'] = _durationRecord?.toJson();
    }
    map['status'] = _status;
    return map;
  }
}

/// hours : 0
/// minutes : 14
/// seconds : 42

class DurationRecord {
  DurationRecord({
    num? hours,
    num? minutes,
    num? seconds,
  }) {
    _hours = hours;
    _minutes = minutes;
    _seconds = seconds;
  }

  DurationRecord.fromJson(dynamic json) {
    _hours = json['hours'];
    _minutes = json['minutes'];
    _seconds = json['seconds'];
  }
  num? _hours;
  num? _minutes;
  num? _seconds;
  DurationRecord copyWith({
    num? hours,
    num? minutes,
    num? seconds,
  }) =>
      DurationRecord(
        hours: hours ?? _hours,
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

/// latitude : 26.2395321
/// longitude : 68.3935272
/// time : "09:09:12 PM"

class CheckOut {
  CheckOut({
    num? latitude,
    num? longitude,
    String? time,
  }) {
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
  CheckOut copyWith({
    num? latitude,
    num? longitude,
    String? time,
  }) =>
      CheckOut(
        latitude: latitude ?? _latitude,
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

/// latitude : 26.2394802
/// longitude : 68.393695
/// time : "08:54:30 PM"

class CheckIn {
  CheckIn({
    num? latitude,
    num? longitude,
    String? time,
  }) {
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
  CheckIn copyWith({
    num? latitude,
    num? longitude,
    String? time,
  }) =>
      CheckIn(
        latitude: latitude ?? _latitude,
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
