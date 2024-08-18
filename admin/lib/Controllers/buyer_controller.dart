import 'package:admin/Constants/Page.dart';
import 'package:admin/Controllers/http_controller.dart';
import 'package:admin/Models/Buyer.dart';
import 'package:admin/Views/Buyer/BuyerPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuyerController extends GetxController {
  String name = "Users";
  IconData icon = Icons.person;
  RxList list = [].obs;
  void onPressed() =>
      {Get.offAll(BuyerPage(), transition: Transition.leftToRight)};

  RxList tobeAppliedFilters = [
    "ID",
    "Name",
    "Mail",
    "Phone",
    "City",
    "State",
    "Country",
    "Pincode",
    "Blocked"
  ].obs;

  RxList appliedFilters = [].obs;

  RxMap appliedFiltersValue = {}.obs;

  void backToDefault() {
    tobeAppliedFilters = [
      "ID",
      "Name",
      "Mail",
      "Phone",
      "City",
      "State",
      "Country",
      "Pincode",
      "Blocked"
    ].obs;
    appliedFiltersValue = {}.obs;
    appliedFilters = [].obs;
  }

  Map<String, String> getDatabaseAttributes = {
    "ID": "id",
    "Name": "name",
    "Mail": "mail",
    "Phone": "phone",
    "Address Line 1": "addressline_1",
    "Address Line 2": "addressline_2",
    "Address Line 3": "addressline_3",
    "City": "city",
    "State": "state",
    "Country": "country",
    "Pincode": "pincode",
    "Blocked": "block"
  };
  List<String> getFields() {
    return [
      "ID",
      "Name",
      "Mail",
      "Phone",
      "Address Line 1",
      "Address Line 2",
      "Address Line 3",
      "City",
      "State",
      "Country",
      "Pincode",
      "Blocked",
      "Actions"
    ];
  }

  void getItems() async {
    tobeAppliedFilters.sort();
    list.clear();
    String getUrl = '${HttpController.baseUrl}/buyer';
    if (appliedFilters.isNotEmpty) getUrl += '?';
    for (int i = 0; i < appliedFilters.length; i++) {
      getUrl +=
          "${getDatabaseAttributes[appliedFilters[i]]}=${appliedFiltersValue[appliedFilters[i]]}";
      if (i != appliedFilters.length - 1) getUrl += '&';
    }
    print(getUrl);
    var response = await http.get(Uri.parse(getUrl));
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> _list = json.decode(response.body) as List;

      for (int i = 0; i < _list.length; i++) {
        list.add(Buyer.fromMap(_list[i]));
      }

      return;
    }
  }

  Future<int> blockBuyer(String id, String action) async {
    String blockUrl = '${HttpController.baseUrl}/buyer/$id';

    var body = {"block": "true"};
    if (action == "Unblock") body = {"block": "false"};
    String req_body = jsonEncode(body);

    var response = await http.put(Uri.parse(blockUrl),
        body: req_body, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return 0;
    }

    return 2;
  }
}
