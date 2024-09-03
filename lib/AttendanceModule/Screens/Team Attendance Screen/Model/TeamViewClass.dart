class TeamAttendanceView {
  final String id;
  final String date;
  final String userName;
  final String status;
  final String checkInTime;
  final String checkOutTime;

  TeamAttendanceView({
    required this.id,
    required this.date,
    required this.userName,
    required this.status,
    required this.checkInTime,
    required this.checkOutTime,
  });

  factory TeamAttendanceView.fromJson(Map<String, dynamic> json) {
    return TeamAttendanceView(
      id: json['_id'] ?? '',
      date: json['date'] ?? '--',
      status: json['status'] ?? 'absent',
      userName: json['fullName'] ?? '',
      checkInTime: json['checkIn']?['time'] ?? '--',
      checkOutTime: json['checkOut']?['time'] ?? '',
      );
  }
}
