// ignore_for_file: file_names

import 'dart:convert';

import 'package:admin/Constants/Drawer.dart';
import 'package:admin/Constants/EmptyList.dart';
import 'package:admin/Constants/SignOut.dart';
import 'package:admin/Controllers/product_controller.dart';
import 'package:admin/Views/Product/AddProduct.dart';
import 'package:admin/Views/Product/ProductTable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:to_csv/to_csv.dart' as exportCSV;

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController productController = Get.find();

  void initState() {
    super.initState();
    productController.getItems();
    productController.list.insert(0, productController.getFields());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[400],
        onPressed: () {
          setState(() {
            productController.getItems();
            productController.list.insert(0, productController.getFields());
            productController.backToDefault();
          });
        },
        shape: CircleBorder(),
        child: Icon(Icons.refresh),
      ),
      drawer: Draw(height, width),
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        actions: [SignOut()],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, top: 50),
            child: Text(
              "Products",
              style: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, top: 5),
            child: const Text(
              "Here, you will find list of Products.",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: (width * 0.9 - 320),
              ),
              Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(5)),
                  child: TextButton.icon(
                    onPressed: () {
                      Get.to(() => AddProduct());
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Add Product",
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
              SizedBox(
                width: 20,
              ),
              Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(5)),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.file_download_outlined,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Export as CSV",
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
            indent: width * 0.1,
            endIndent: width * 0.1,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, top: 10),
            child: Obx(
              () => SizedBox(
                width: width * 0.9,
                height: 35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                        height: 35,
                        width: math.min(width * 0.7,
                            productController.appliedFilters.length * 200),
                        child: ListView.builder(
                            padding: const EdgeInsets.only(left: 10),
                            scrollDirection: Axis.horizontal,
                            itemCount: productController.appliedFilters.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextButton.icon(
                                        onPressed: () {
                                          String filter = productController
                                              .appliedFilters[index];
                                          productController.appliedFilters
                                              .remove(filter);
                                          productController.getItems();
                                          productController.list.insert(
                                              0, productController.getFields());
                                          if (!productController
                                              .tobeAppliedFilters
                                              .contains(filter)) {
                                            productController.tobeAppliedFilters
                                                .add(filter);
                                          }
                                          productController.tobeAppliedFilters
                                              .sort();
                                        },
                                        icon: Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.blue[400],
                                          size: 20,
                                        ),
                                        label: Text(
                                          "${productController.appliedFilters[index]} : ${productController.appliedFiltersValue[productController.appliedFilters[index]]}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ));
                            })),
                    const SizedBox(
                      width: 5,
                    ),
                    Obx(
                      () => Container(
                        height: 10,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButton(
                            dropdownColor: Colors.blue[50],
                            alignment: AlignmentDirectional.center,
                            underline: const SizedBox(
                              width: 0,
                              height: 0,
                            ),
                            itemHeight: 55,
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            hint: const Text(
                              "Filters",
                              style: TextStyle(color: Colors.black),
                            ),
                            items: getDropDownItems(productController, context),
                            onChanged: (value) {}),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Obx(
              () => productController.list.length > 1
                  ? ProductTable(productController, width, height, context)
                  : Center(child: emptyList("No Products yet", height, width)),
            ),
          ),
        ],
      ),
    );
  }
}

List<DropdownMenuItem> getDropDownItems(
    ProductController productController, BuildContext context) {
  List<DropdownMenuItem> list = [];
  for (int i = 0; i < productController.tobeAppliedFilters.length; i++) {
    final TextEditingController textEditingController = TextEditingController();
    String attribute = productController.tobeAppliedFilters[i];
    list.add(DropdownMenuItem(
        value: attribute,
        onTap: () {},
        child: DropdownMenu(
            controller: textEditingController,
            menuHeight: 40,
            onSelected: (value) async {
              productController.appliedFiltersValue[attribute] =
                  textEditingController.text.replaceAll(" ", "");
              productController.appliedFilters.add(attribute);
              productController.tobeAppliedFilters.remove(attribute);
              productController.getItems();
              productController.list.insert(0, productController.getFields());
              Navigator.pop(context);
            },
            inputDecorationTheme: InputDecorationTheme(
                enabledBorder: InputBorder.none, fillColor: Colors.blue[50]),
            hintText: attribute,
            trailingIcon: const Icon(Icons.arrow_right),
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: "", label: "")
            ])));
    // Container(
    //   padding: EdgeInsets.only(right: 0),
    //   alignment: Alignment.center,
    //   child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //     Text(
    //       attribute,
    //       style: const TextStyle(color: Colors.black),
    //     ),
    //     const Icon(
    //       Icons.arrow_right,
    //       color: Colors.black,
    //     ),
    //   ]),
    // )));
  }
  return list;
}
