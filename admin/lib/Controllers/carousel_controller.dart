import 'package:admin/Constants/Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselController extends GetxController {
  String name = "Carousel Control";
  IconData icon = Icons.view_carousel;
  RxList list = [].obs;
  void onPressed() => {
        Get.offAll(
            ItemPage(
              controller: Get.find<CarouselController>(),
              title: name,
            ),
            transition: Transition.leftToRight)
      };

  List<String> getFields() {
    return ["id", "name", "image", "url"];
  }

  Map<String, String> getDatabaseAttributes = {
    "ID": "id",
    "Name": "name",
    "Images": "image",
    "URL": "url"
  };
  RxList tobeAppliedFilters = ["ID", "Name", "Images", "URL"].obs;

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
