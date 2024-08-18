// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, use_key_in_widget_constructors, file_names

import 'package:admin/Constants/Drawer.dart';
import 'package:admin/Constants/EmptyList.dart';
import 'package:admin/Constants/SignOut.dart';
import 'package:admin/Controllers/dashboard_controller.dart';
import 'package:admin/Views/DashBoard/DashBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final DashBoardController dashBoardController = Get.find();

  @override
  void initState() {
    super.initState();
    getNumbers();
  }

  void getNumbers() async {
    dashBoardController.getProducts();
    dashBoardController.getUsers();
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
            getNumbers();
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
              padding: EdgeInsets.only(left: width * 0.18, top: 50),
              child: Text(
                "DashBoard",
                style: TextStyle(
                    color: Colors.indigo[900],
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.18, top: 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    DashBox(
                      height,
                      "Orders",
                      Icons.shopping_cart,
                      Colors.orange,
                      dashBoardController.OrderList,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    DashBox(height, "Products", Icons.diamond,
                        Colors.indigo[700]!, dashBoardController.ProductList),
                    const SizedBox(
                      width: 50,
                    ),
                    DashBox(height, "Users", Icons.person, Colors.green[600]!,
                        dashBoardController.UserList)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: math.min(height * 0.2, 100),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.18, top: 50),
              child: Text(
                "Recent Orders",
                style: TextStyle(
                    color: Colors.indigo[900],
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(child: emptyList("No Recent Orders", height, width))
          ],
        ),
      ),
    );
  }
}
