import 'dart:convert';

import 'package:admin/Constants/Page.dart';
import 'package:admin/Controllers/http_controller.dart';
import 'package:admin/Models/Category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController {
  String name = "Categories";
  IconData icon = Icons.category;
  RxList list = [].obs;
  void onPressed() => {
        Get.offAll(
            ItemPage(
              controller: Get.find<CategoryController>(),
              title: name,
            ),
            transition: Transition.leftToRight)
      };
  Map<String, String> getDatabaseAttributes = {
    "ID": "id",
    "Name": "name",
    "Images": "image",
    "Sub Categories": "subcategories"
  };
  List<String> getFields() {
    return ["id", "name", "image", "subcategories"];
  }

  RxList tobeAppliedFilters = ["ID", "Name", "Images", "Sub Categories"].obs;

  RxList appliedFilters = [].obs;

  RxMap appliedFiltersValue = {}.obs;

  void backToDefault() {
    tobeAppliedFilters = ["ID", "Name", "Images", "URL"].obs;
    appliedFiltersValue = {}.obs;
    appliedFilters = [].obs;
  }

  void getItems() async {
    tobeAppliedFilters.sort();
    list.clear();
    String getUrl = '${HttpController.baseUrl}/category';
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
        list.add(Category.fromMap(_list[i]));
      }

      return;
    }
  }
}
