class absentTeamClass {
  final String id;
  final String userName;
  final String contactNo;
  final String email;
  final String designation;


  absentTeamClass({
    required this.id,
    required this.userName,
    required this.contactNo,
    required this.email,
    required this.designation,

  });

  factory absentTeamClass.fromJson(Map<String, dynamic> json) {
    return absentTeamClass(
      id: json['_id'] ?? '',
      userName: json['fullName'] ?? '',
      contactNo: json['contact'] ?? '',
      email: json['email'] ?? '',
      designation: json['designation'] ?? '',

    );
  }
}
