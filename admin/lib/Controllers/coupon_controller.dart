import 'dart:convert';

import 'package:admin/Constants/Page.dart';
import 'package:admin/Controllers/http_controller.dart';
import 'package:admin/Models/Coupon.dart';
import 'package:admin/Views/Coupon/CouponPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CouponController extends GetxController {
  String name = "Coupons";
  RxList list = [].obs;
  IconData icon = Icons.card_membership;
  void onPressed() =>
      {Get.offAll(CouponPage(), transition: Transition.leftToRight)};
  Map<String, String> getDatabaseAttributes = {
    "ID": "id",
    "Code": "code",
    "Name": "name",
    "Amount": "amount",
    "Buyer ID": "buyerid",
    "Validity": "validity",
    "Date": "date"
  };
  List<String> getFields() {
    return ["ID", "Code", "Name", "Amount", "Buyer ID", "Validity", "Date"];
  }

  RxList tobeAppliedFilters =
      ["ID", "Code", "Name", "Amount", "Buyer ID", "Validity", "Date"].obs;

  RxList appliedFilters = [].obs;

  RxMap appliedFiltersValue = {}.obs;

  void backToDefault() {
    tobeAppliedFilters =
        ["ID", "Code", "Name", "Amount", "Buyer ID", "Validity", "Date"].obs;
    appliedFiltersValue = {}.obs;
    appliedFilters = [].obs;
  }

  void getItems() async {
    list.clear();
    String getUrl = "${HttpController.baseUrl}/coupon";
    if (appliedFilters.isNotEmpty) getUrl += '?';
    for (int i = 0; i < appliedFilters.length; i++) {
      getUrl +=
          "${getDatabaseAttributes[appliedFilters[i]]}=${appliedFiltersValue[appliedFilters[i]]}";
      if (i != appliedFilters.length - 1) getUrl += '&';
    }
    var response = await http.get(Uri.parse(getUrl));
    if (response.statusCode == 200) {
      List<dynamic> _list = json.decode(response.body) as List;

      for (int i = 0; i < _list.length; i++) {
        list.add(Coupon.fromMap(_list[i]));
      }

      return;
    }
  }

  void addItem(body) async {
    String postUrl = "${HttpController.baseUrl}/coupon";
    String jsonBody = jsonEncode(body);

    var response = await http.post(Uri.parse(postUrl),
        body: jsonBody, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      Get.find<CouponController>().getItems();
      Get.find<CouponController>()
          .list
          .insert(0, Get.find<CouponController>().getFields());
    }
  }
}
