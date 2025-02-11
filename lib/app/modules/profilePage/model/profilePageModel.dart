
import 'dart:convert';

List<GetProfile> getProfileModelFromJson(String str) => List<GetProfile>.from(json.decode(str).map((x) => GetProfile.fromJson(x)));

String getProfileModelToJson(List<GetProfile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//getBanner from api
class GetProfile {
  GetProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.mobile,
    required this.gender,
  });

  int id;
  String name;
  String email;
  String address;
  String mobile;
  String gender;

  factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    mobile: json["mobile"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}