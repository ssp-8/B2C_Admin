// ignore_for_file: file_names

import 'dart:convert';

import 'package:admin/Constants/Drawer.dart';
import 'package:admin/Constants/EmptyList.dart';
import 'package:admin/Constants/SignOut.dart';
import 'package:admin/Controllers/buyer_controller.dart';
import 'package:admin/Views/Buyer/BuyerTable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:to_csv/to_csv.dart' as exportCSV;

class BuyerPage extends StatefulWidget {
  const BuyerPage({super.key});

  @override
  State<BuyerPage> createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  final BuyerController buyerController = Get.find();

  void initState() {
    super.initState();
    buyerController.getItems();
    buyerController.list.insert(0, buyerController.getFields());
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
            buyerController.getItems();
            buyerController.list.insert(0, buyerController.getFields());
            buyerController.backToDefault();
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
              "Buyers",
              style: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, top: 5),
            child: const Text(
              "Here, you will find list of Buyers. You can Block or Unblock any buyer.",
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
                width: (width * 0.9 - 150),
              ),
              Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(5)),
                  child: TextButton.icon(
                    onPressed: () {
                      List<String> headers = buyerController.getFields();
                      headers.removeLast();
                      List<List<String>> data = [];
                      for (int i = 1; i < buyerController.list.length; i++) {
                        Map<String, dynamic> buyer =
                            buyerController.list[i].toMap();
                        String buy = jsonEncode(buyer);
                        print(buy);
                        List<String> user = [];

                        data.add(user);
                      }
                      exportCSV.myCSV(headers, data);
                    },
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
                            buyerController.appliedFilters.length * 200),
                        child: ListView.builder(
                            padding: const EdgeInsets.only(left: 10),
                            scrollDirection: Axis.horizontal,
                            itemCount: buyerController.appliedFilters.length,
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
                                          String filter = buyerController
                                              .appliedFilters[index];
                                          buyerController.appliedFilters
                                              .remove(filter);
                                          buyerController.getItems();
                                          buyerController.list.insert(
                                              0, buyerController.getFields());
                                          if (!buyerController
                                              .tobeAppliedFilters
                                              .contains(filter)) {
                                            buyerController.tobeAppliedFilters
                                                .add(filter);
                                          }
                                          buyerController.tobeAppliedFilters
                                              .sort();
                                        },
                                        icon: Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.blue[400],
                                          size: 20,
                                        ),
                                        label: Text(
                                          "${buyerController.appliedFilters[index]} : ${buyerController.appliedFiltersValue[buyerController.appliedFilters[index]]}",
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
                            items: getDropDownItems(buyerController, context),
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
              () => buyerController.list.length > 1
                  ? BuyerTable(buyerController, width, height, context)
                  : Center(child: emptyList("No Buyers yet", height, width)),
            ),
          ),
        ],
      ),
    );
  }
}

List<DropdownMenuItem> getDropDownItems(
    BuyerController buyerController, BuildContext context) {
  List<DropdownMenuItem> list = [];
  for (int i = 0; i < buyerController.tobeAppliedFilters.length; i++) {
    final TextEditingController textEditingController = TextEditingController();
    String attribute = buyerController.tobeAppliedFilters[i];
    list.add(DropdownMenuItem(
        value: attribute,
        onTap: () {},
        child: DropdownMenu(
            controller: textEditingController,
            menuHeight: 40,
            onSelected: (value) async {
              buyerController.appliedFiltersValue[attribute] =
                  textEditingController.text.replaceAll(" ", "");
              buyerController.appliedFilters.add(attribute);
              buyerController.tobeAppliedFilters.remove(attribute);
              buyerController.getItems();
              buyerController.list.insert(0, buyerController.getFields());
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
