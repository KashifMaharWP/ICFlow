class presentTeamClass {
  final String id;
  final String userName;
  final String checkInTime;
  final String checkOutTime;


  presentTeamClass({
    required this.id,
    required this.userName,
    required this.checkInTime,
    required this.checkOutTime,

  });

  factory presentTeamClass.fromJson(Map<String, dynamic> json) {
    return presentTeamClass(
      id: json['_id'] ?? '',
      userName: json['fullName'] ?? '',
      checkInTime: json['checkIn'] ?? '',
      checkOutTime: json['checkOut'] ?? '',

    );
  }
}