
// ignore_for_file: non_constant_identifier_names

//PendingRequest from api
import 'dart:convert';

List<CompledtedRequest> compledtedRequestListModelFromJson(String str) => List<CompledtedRequest>.from(json.decode(str).map((x) => CompledtedRequest.fromJson(x)));
String compledtedRequestModelToJson(List<CompledtedRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class CompledtedRequest {
  CompledtedRequest({
    required this.id,
    required this.donation_type,
    required this.contact_name,
    required this.date,
  });
  int id;
  String donation_type;
  String contact_name;
  String date;
  factory CompledtedRequest.fromJson(Map<String, dynamic> json) => CompledtedRequest(
    id: json["id"],
    donation_type: json["donation_type"],
    contact_name: json["contact_name"],
    date: json["date"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "donation_type": donation_type,
    "contact_name": contact_name,
    "date": date,
  };
}