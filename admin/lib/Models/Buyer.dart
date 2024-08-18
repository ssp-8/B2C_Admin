import 'dart:convert';
import 'dart:math';

Buyer BuyerfromMap(String str) => Buyer.fromMap(json.decode(str));
String BuyerToMap(Buyer data) => json.encode(data.toMap());

class Buyer {
  Buyer(
      {required this.id,
      required this.name,
      required this.mail,
      required this.phone,
      required this.addressline_1,
      required this.addressline_2,
      required this.addressline_3,
      required this.city,
      required this.state,
      required this.country,
      required this.pincode,
      required this.block});
  final String id;
  final String name;
  final String mail;
  final String phone;
  final String addressline_1;
  final String addressline_2;
  final String addressline_3;
  final String city;
  final String state;
  final String country;
  final String pincode;
  final String block;

  List<String> getAttributes() {
    String action = "Block";
    if (block == "true") action = "Unblock";
    return [
      id,
      name,
      mail,
      phone,
      addressline_1,
      addressline_2,
      addressline_3,
      city,
      state,
      country,
      pincode,
      block,
      action
    ];
  }

  factory Buyer.fromMap(Map<String, dynamic> json) {
    return Buyer(
      id: json["id"],
      name: json["name"],
      mail: json["mail"],
      phone: json["phone"],
      addressline_1: json["addressline-1"],
      addressline_2: json["addressline-2"],
      addressline_3: json["addressline-3"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      block: json["block"].toString(),
      pincode: json["pincode"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "mail": mail,
        "phone": phone,
        "addressline-1": addressline_1,
        "addressline-2": addressline_2,
        "addressline-3": addressline_3,
        "city": city,
        "state": state,
        "country": country,
        "block": bool.parse(block, caseSensitive: false),
        "pincode": pincode,
      };
}
