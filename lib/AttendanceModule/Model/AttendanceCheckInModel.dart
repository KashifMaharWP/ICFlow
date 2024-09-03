import 'dart:convert';

// Model class for Attendance
class Attendance {
  final CheckIn checkIn;
  final String user;
  final String date;
  final String id;
  final int v;

  Attendance({
    required this.checkIn,
    required this.user,
    required this.date,
    required this.id,
    required this.v,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      checkIn: CheckIn.fromJson(json['checkIn']),
      user: json['user'],
      date: json['date'],
      id: json['_id'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkIn': checkIn.toJson(),
      'user': user,
      'date': date,
      '_id': id,
      '__v': v,
    };
  }
}

// Model class for CheckIn
class CheckIn {
  final String location;
  final String time;

  CheckIn({
    required this.location,
    required this.time,
  });

  factory CheckIn.fromJson(Map<String, dynamic> json) {
    return CheckIn(
      location: json['Location'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Location': location,
      'time': time,
    };
  }
}

// Function to parse the response and create an Attendance object
Attendance parseAttendanceResponse(String responseBody) {
  final parsed = json.decode(responseBody);
  return Attendance.fromJson(parsed['attendance']);
}
