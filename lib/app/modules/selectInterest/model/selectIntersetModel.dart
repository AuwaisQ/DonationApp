import 'dart:convert';

//selectInterest Categories from api
List<GetCategories> getCategoriesFromJson(String str) => List<GetCategories>.from(json.decode(str).map((x) => GetCategories.fromJson(x)));
String getCategoriesModelToJson(List<GetCategories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class GetCategories {
  GetCategories({
    required this.category,
    required this.image,
  });
  String category;
  String image;
  factory GetCategories.fromJson(Map<String, dynamic> json) => GetCategories(
    category: json["category"],
    image: json["image"],
  );
  Map<String, dynamic> toJson() => {
    "category": category,
    "image": image,
  };
}
