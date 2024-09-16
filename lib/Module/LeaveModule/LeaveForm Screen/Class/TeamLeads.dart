

class TeamLeads {
  final String id;
  final String fullName;
  final String email;

  TeamLeads({
    required this.id,
    required this.fullName,
    required this.email,
});
  factory TeamLeads.fromJson(Map<String, dynamic> json){
    return TeamLeads(
        id: json['_id'] ?? '',
        fullName: json['fullName'] ?? '',
        email: json['email'] ?? ''
  );
  }

  factory TeamLeads.fromMap(Map<String, dynamic> map) {
    return TeamLeads(
      id: map['_id'] != null ? map['_id'] as String : "",
      fullName: map['fullName'] != null ? map['fullName'] as String : "",
      email: map['email'] != null ? map['email'] as String : "",
    );
  }

}