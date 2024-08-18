import 'package:admin/Controllers/http_controller.dart';
import 'package:admin/Models/Buyer.dart';
import 'package:admin/Models/Product.dart';
import 'package:admin/Views/DashBoard/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashBoardController extends GetxController {
  String name = "Dashboard";
  IconData icon = Icons.dashboard;
  void onPressed() =>
      {Get.off(DashBoard(), transition: Transition.leftToRight)};
  RxList ProductList = [].obs;
  RxList UserList = [].obs;
  RxList OrderList = [].obs;

  getProducts() async {
    ProductList.clear();
    String baseUrl = HttpController.baseUrl;

    String getUrl = "$baseUrl/product";
    var response = await http.get(Uri.parse(getUrl));

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body) as List;
      for (int i = 0; i < list.length; i++) {
        ProductList.add(Product.fromMap(list[i]));
      }
    }
  }

  getUsers() async {
    UserList.clear();
    String baseUrl = HttpController.baseUrl;

    String getUrl = "$baseUrl/buyer";
    var response = await http.get(Uri.parse(getUrl));

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body) as List;
      for (int i = 0; i < list.length; i++) {
        UserList.add(Buyer.fromMap(list[i]));
      }
    }
  }
}
