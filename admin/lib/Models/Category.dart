import 'dart:convert';

Category BuyerfromMap(String str) => Category.fromMap(json.decode(str));
String BuyerToMap(Category data) => json.encode(data.toMap());

class Category {
  Category(
      {required this.id,
      required this.name,
      required this.image,
      required this.subcategories});
  final String id;
  final String name;
  final String image;
  final String subcategories;

  List<String> getAttributes() {
    return [id, name, image, subcategories, ""];
  }

  factory Category.fromMap(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      subcategories: json["subcategories"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "images": image,
        "subcategories": subcategories,
      };
}
