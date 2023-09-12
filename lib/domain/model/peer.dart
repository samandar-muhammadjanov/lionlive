// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserInfoRTC {
  DateTime DOB;
  String name;
  String regionName;
  String description;
  String gender;
  String authID;
  String location;
  String? socketID; // Make it nullable for optional property

  UserInfoRTC({
    required this.DOB,
    required this.name,
    required this.regionName,
    required this.description,
    required this.gender,
    required this.authID,
    required this.location,
    this.socketID, // Optional socketID
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'DOB': DOB.millisecondsSinceEpoch,
      'name': name,
      'regionName': regionName,
      'description': description,
      'gender': gender,
      'authID': authID,
      'location': location,
      'socketID': socketID,
    };
  }

  factory UserInfoRTC.fromMap(Map<String, dynamic> map) {
    return UserInfoRTC(
      DOB: DateTime.fromMillisecondsSinceEpoch(map['DOB'] as int),
      name: map['name'] as String,
      regionName: map['regionName'] as String,
      description: map['description'] as String,
      gender: map['gender'] as String,
      authID: map['authID'] as String,
      location: map['location'] as String,
      socketID: map['socketID'] != null ? map['socketID'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfoRTC.fromJson(String source) => UserInfoRTC.fromMap(json.decode(source) as Map<String, dynamic>);
}
