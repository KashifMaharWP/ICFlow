import 'dart:convert';

class UserModel {
  String? id;
  String? username;
  String? profilePicture;
  DateTime? birthDate;
  String? designation;
  List<String>? skill;
  String? branchName;
  String? phoneNo;
  String? email;
  String? role;
  int? v;
  Address? address;

  UserModel({
    this.id,
    this.username,
    this.profilePicture,
    this.birthDate,
    this.designation,
    this.skill,
    this.branchName,
    this.phoneNo,
    this.email,
    this.role,
    this.v,
    this.address,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String?,
      username: map['username'] as String?,
      profilePicture: map['profilePicture'] as String?,
      birthDate: map['birthDate'] != null ? DateTime.tryParse(map['birthDate']) : null,
      designation: map['designation'] as String?,
      skill: map['skill'] != null ? List<String>.from(map['skill']) : [],
      branchName: map['branchName'] as String?,
      phoneNo: map['phoneNo'] as String?,
      email: map['email'] as String?,
      role: map['role'] as String?,
      v: map['__v'] as int?,
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'username': username,
      'profilePicture': profilePicture,
      'birthDate': birthDate?.toIso8601String(),
      'designation': designation,
      'skill': skill,
      'branchName': branchName,
      'phoneNo': phoneNo,
      'email': email,
      'role': role,
      '__v': v,
      'address': address?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, profilePicture: $profilePicture, birthDate: $birthDate, designation: $designation, skill: $skill, branchName: $branchName, phoneNo: $phoneNo, email: $email, role: $role, v: $v, address: $address)';
  }
}

class Address {
  String? AdressLine;
  String? City;
  String? State_Region;
  String? Zip_Code;
  String? Country;

  Address({
    this.AdressLine,
    this.City,
    this.State_Region,
    this.Zip_Code,
    this.Country
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      AdressLine: map['AddressLine'] as String?,
      City: map['City'] as String?,
      State_Region: map['State_Region'] as String?,
      Zip_Code: map['Zip_Code'] as String?,
      Country: map['Country'] as String?
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'AddressLine': AdressLine,
      'City': City,
      'State_Region': State_Region,
      'Zip_Code':Zip_Code,
      'Country':Country
    };
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(AddressLine: $AdressLine, City: $City, State_Region: $State_Region, Zip_Code: $Zip_Code, Country: $Country)';
  }
}
