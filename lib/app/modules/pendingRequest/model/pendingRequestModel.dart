
// ignore_for_file: non_constant_identifier_names

//PendingRequest from api
import 'dart:convert';

List<PendingRequest> pendingRequestListModelFromJson(String str) => List<PendingRequest>.from(json.decode(str).map((x) => PendingRequest.fromJson(x)));
String pendingRequestModelToJson(List<PendingRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class PendingRequest {
  PendingRequest({
    required this.id,
    required this.donation_type,
    required this.contact_name,
    required this.date,
  });
  int id;
  String donation_type;
  String contact_name;
  String date;
  factory PendingRequest.fromJson(Map<String, dynamic> json) => PendingRequest(
    id: json["id"],
    donation_type: json["donation_type"],
    contact_name: json["contact_name"],
    date: json["date"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "donation_type": donation_type,
    "contact_name": contact_name,
    "datew": date,
  };
}