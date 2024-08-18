import 'package:admin/Constants/Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductReviewController extends GetxController {
  String name = "Product Reviews";
  IconData icon = Icons.rate_review;
  RxList list = [].obs;
  void onPressed() => {
        Get.offAll(
            ItemPage(
              controller: Get.find<ProductReviewController>(),
              title: name,
            ),
            transition: Transition.leftToRight)
      };

  List<String> getFields() {
    return [
      "id",
      "buyer_id",
      "product_id",
      "category_id",
      "date",
      "comment",
      "photo",
      "rating"
    ];
  }

  Map<String, String> getDatabaseAttributes = {
    "ID": "id",
    "Buyer ID": "buyer_id",
    "Product ID": "product_id",
    "Category ID": "category_id",
    "Date": "date",
    "Comment": "comment",
    "Photo": "photo",
    "Rating": "rating"
  };
  RxList tobeAppliedFilters = [
    "ID",
    "Buyer ID",
    "Product ID",
    "Category ID",
    "Date",
    "Comment",
    "Photo",
    "Rating"
  ].obs;

  RxList appliedFilters = [].obs;

  RxMap appliedFiltersValue = {}.obs;

  void backToDefault() {
    tobeAppliedFilters = ["ID", "Name", "Images", "URL"].obs;
    appliedFiltersValue = {}.obs;
    appliedFilters = [].obs;
  }

  void getItems() async {
    list.clear();
  }
}
