
//getBanner from api
import 'dart:convert';

List<GetContact> getContactModelFromJson(String str) => List<GetContact>.from(json.decode(str).map((x) => GetContact.fromJson(x)));
String getContactModelToJson(List<GetContact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class GetContact {
  GetContact({
    required this.name,
    required this.contact,
    required this.image,
  });
  String name;
  String contact;
  String image;
  factory GetContact.fromJson(Map<String, dynamic> json) => GetContact(
    name: json["name"],
    image: json["image"],
    contact: json["contact"],
  );
  Map<String, dynamic> toJson() => {
    "name": name,
    "contact": contact,
    "image": image,
  };
}