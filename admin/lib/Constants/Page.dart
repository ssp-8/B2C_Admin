// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:admin/Constants/Drawer.dart';
import 'package:admin/Constants/EmptyList.dart';
import 'package:admin/Constants/ItemTable.dart';
import 'package:admin/Constants/SignOut.dart';
import 'package:admin/Views/DashBoard/DashBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class ItemPage extends StatefulWidget {
  const ItemPage({super.key, required this.controller, required this.title});
  final controller;
  final String title;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  void initState() {
    super.initState();
    widget.controller.getItems();
    widget.controller.list.insert(0, widget.controller.getFields());
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
            widget.controller.getItems();
            widget.controller.list.insert(0, widget.controller.getFields());
            widget.controller.backToDefault();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.1, top: 50),
              child: Text(
                widget.title,
                style: TextStyle(
                    color: Colors.indigo[900],
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: width * 0.1, top: 50),
                    child: DashBox(height, widget.title, Icons.person,
                        Colors.indigo[900]!, widget.controller.list)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: width * 0.1, top: 10),
              child: Obx(
                () => SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      SizedBox(
                          height: 30,
                          width: math.min(
                              width * 0.7,
                              widget.controller.appliedFilters.length *
                                  200.toDouble()),
                          child: ListView.builder(
                              padding: const EdgeInsets.only(left: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  widget.controller.appliedFilters.length,
                              itemBuilder: (context, index) {
                                print(
                                    "$index length: ${widget.controller.appliedFilters.length}");
                                return Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextButton.icon(
                                        onPressed: () {
                                          String filter = widget
                                              .controller.appliedFilters[index];
                                          widget.controller.appliedFilters
                                              .remove(filter);
                                          widget.controller.getItems();
                                          widget.controller.list.insert(
                                              0, widget.controller.getFields());
                                          if (!widget
                                              .controller.tobeAppliedFilters
                                              .contains(filter)) {
                                            widget.controller.tobeAppliedFilters
                                                .add(filter);
                                          }
                                          widget.controller.tobeAppliedFilters
                                              .sort();
                                        },
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Colors.blue[400],
                                        ),
                                        label: Text(
                                          "${widget.controller.appliedFilters[index]} : ${widget.controller.appliedFiltersValue[widget.controller.appliedFilters[index]]}",
                                          style: TextStyle(
                                              color: Colors.blue[400]!,
                                              fontWeight: FontWeight.w500),
                                        )));
                              })),
                      Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton(
                            padding: const EdgeInsets.all(0),
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
                            items: getDropDownItems(widget.controller, context),
                            onChanged: (value) {}),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Obx(
                () => widget.controller.list.length > 1
                    ? ItemTable(widget.controller, width, height, context)
                    : Center(
                        child:
                            emptyList("No ${widget.title} yet", height, width)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuItem> getDropDownItems(controller, BuildContext context) {
  List<DropdownMenuItem> list = [];
  for (int i = 0; i < controller.tobeAppliedFilters.length; i++) {
    final TextEditingController textEditingcontroller = TextEditingController();
    String attribute = controller.tobeAppliedFilters[i];
    list.add(DropdownMenuItem(
        value: attribute,
        onTap: () {},
        child: DropdownMenu(
            controller: textEditingcontroller,
            menuHeight: 40,
            onSelected: (value) async {
              controller.appliedFiltersValue[attribute] =
                  textEditingcontroller.text.replaceAll(" ", "");
              controller.appliedFilters.add(attribute);
              controller.tobeAppliedFilters.remove(attribute);
              controller.getItems();
              controller.list.insert(0, controller.getFields());
              Navigator.pop(context);
            },
            inputDecorationTheme:
                InputDecorationTheme(enabledBorder: InputBorder.none),
            hintText: attribute,
            trailingIcon: Icon(Icons.arrow_right),
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
