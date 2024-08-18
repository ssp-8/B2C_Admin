import 'dart:convert';

import 'package:admin/Constants/Page.dart';
import 'package:admin/Controllers/http_controller.dart';
import 'package:admin/Models/Product.dart';
import 'package:admin/Views/Product/ProductPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  String name = "Products";
  IconData icon = Icons.diamond;
  RxList list = [].obs;
  void onPressed() =>
      {Get.offAll(ProductPage(), transition: Transition.leftToRight)};

  List<String> getFields() {
    return [
      "ID",
      "Name",
      "Company",
      "Quantity",
      "Price",
      "Discount",
      "Description",
      "Date",
      "Category",
      "Active",
      "Block",
      "Subcategory",
      "Rating",
      "Specific_attribute",
      "Images",
      "Videos",
      "Obj"
    ];
  }

  Map<String, String> getDatabaseAttributes = {
    "ID": "id",
    "Name": "name",
    "Company": "company",
    "Qty": "qty",
    "Price": "price",
    "Discount": "discount",
    "Description": "description",
    "Date": "date",
    "Category": "category",
    "Active": "active",
    "Blocked": "block",
    "Sub Category": "subcategory",
    "Rating": "rating",
    "Specific Attributes": "specific_attributes",
    "Images": "images",
    "Videos": "videos",
    "OBJs": "obj"
  };
  RxList tobeAppliedFilters = [
    "ID",
    "Name",
    "Company",
    "Qty",
    "Price",
    "Discount",
    "Description",
    "Date",
    "Category",
    "Active",
    "Blocked",
    "Sub Category",
    "Rating",
    "Specific Attributes",
    "Images",
    "Videos",
    "OBJs"
  ].obs;

  RxList appliedFilters = [].obs;

  RxMap appliedFiltersValue = {}.obs;

  void backToDefault() {
    tobeAppliedFilters = [
      "ID",
      "Name",
      "Company",
      "Qty",
      "Price",
      "Discount",
      "Description",
      "Date",
      "Category",
      "Active",
      "Blocked",
      "Sub Category",
      "Rating",
      "Specific Attributes",
      "Images",
      "Videos",
      "OBJs"
    ].obs;
    appliedFiltersValue = {}.obs;
    appliedFilters = [].obs;
  }

  void getItems() async {
    tobeAppliedFilters.sort();
    list.clear();
    String getUrl = '${HttpController.baseUrl}/product';
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
        list.add(Product.fromMap(_list[i]));
      }

      return;
    }
  }

  void addItem(body) async {
    String postUrl = "${HttpController.baseUrl}/product";
    String jsonBody = jsonEncode(body);

    var response = await http.post(Uri.parse(postUrl),
        body: jsonBody, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      Get.find<ProductController>().getItems();
      Get.find<ProductController>()
          .list
          .insert(0, Get.find<ProductController>().getFields());
    }
  }
}
