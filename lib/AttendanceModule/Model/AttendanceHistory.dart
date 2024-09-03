class Attendance {
  final String id;
  final String date;
  final String status;
  final String checkInTime;
  final String checkOutTime;
  final double latitude;
  final double longitude;

  Attendance({
    required this.id,
    required this.date,
    required this.status,
    required this.checkInTime,
    required this.checkOutTime,
    required this.latitude,
    required this.longitude,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['_id'] ?? '',
      date: json['date'] ?? '--',
      status: json['status'] ?? 'absent',
      checkInTime: json['checkIn']?['time'] ?? '--',
      checkOutTime: json['checkOut']?['time'] ?? '',
      latitude: json['checkIn']?['latitude'] ?? 0.0,
      longitude: json['checkIn']?['longitude'] ?? 0.0,
    );
  }
}
