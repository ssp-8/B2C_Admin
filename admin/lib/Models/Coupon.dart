import 'dart:convert';
import 'dart:math';

Coupon CouponfromMap(String str) => Coupon.fromMap(json.decode(str));
String CouponToMap(Coupon data) => json.encode(data.toMap());

class Coupon {
  Coupon({
    required this.id,
    required this.name,
    required this.code,
    required this.amount,
    required this.buyerid,
    required this.validity,
    required this.date,
  });
  final String id;
  final String name;
  final String code;
  final String amount;
  final String buyerid;
  final String validity;
  final String date;

  List<String> getAttributes() {
    String action = "Block";
    return [id, name, code, amount, buyerid, validity, date, action];
  }

  factory Coupon.fromMap(Map<String, dynamic> json) {
    return Coupon(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      amount: json["amount"],
      buyerid: json["buyerid"],
      validity: json["validity"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
        "amount": amount,
        "buyer_id": buyerid,
        "validity": validity,
      };
}
