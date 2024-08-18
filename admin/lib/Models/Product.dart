import 'dart:convert';

Product productfromMap(String str) => Product.fromMap(json.decode(str));
String productToMap(Product data) => json.encode(data.toMap());

class Product {
  Product(
      {required this.id,
      required this.name,
      required this.company,
      required this.qty,
      required this.price,
      required this.discount,
      required this.description,
      required this.date,
      required this.category,
      required this.active,
      required this.block,
      required this.subcategory,
      required this.rating,
      required this.specific_attributes,
      required this.images,
      required this.videos,
      required this.obj});
  final String id;
  final String name;
  final String company;
  final String qty;
  final String price;
  final String discount;
  final String description;
  final String date;
  final String category;
  final String active;
  final String block;
  final String subcategory;
  final String rating;
  final String specific_attributes;
  final String images;
  final String videos;
  final String obj;

  List<String> getAttributes() {
    return [
      id,
      name,
      company,
      qty,
      price,
      discount,
      description,
      date,
      category,
      active,
      block,
      subcategory,
      rating,
      specific_attributes,
      images,
      videos,
      obj,
      ""
    ];
  }

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        name: json["name"],
        company: json["company"],
        qty: json["qty"],
        price: json["price"],
        discount: json["discount"],
        description: json["description"],
        date: json["date"],
        category: json["category"],
        active: json["active"].toString(),
        block: json["block"].toString(),
        subcategory: json["subcategory"],
        rating: json["rating"].toString(),
        specific_attributes: json["specific_attributes"],
        images: json["images"],
        videos: json["videos"],
        obj: json["obj"]);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "company": company,
        "qty": qty,
        "price": price,
        "discount": discount,
        "description": description,
        "date": date,
        "category": category,
        "active": bool.parse(active, caseSensitive: false),
        "block": bool.parse(block, caseSensitive: false),
        "subcategory": subcategory,
        "rating": rating,
        "specific_attributes": specific_attributes,
        "images": images,
        "videos": videos,
        "obj": obj
      };
}
