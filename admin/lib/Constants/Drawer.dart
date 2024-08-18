import 'package:admin/Controllers/buyer_controller.dart';
import 'package:admin/Controllers/carousel_controller.dart';
import 'package:admin/Controllers/category_controller.dart';
import 'package:admin/Controllers/coupon_controller.dart';
import 'package:admin/Controllers/dashboard_controller.dart';

import 'package:admin/Controllers/order_controller.dart';
import 'package:admin/Controllers/payment_controller.dart';
import 'package:admin/Controllers/productReview_controller.dart';
import 'package:admin/Controllers/product_controller.dart';
import 'package:admin/Views/DashBoard/DrawerButtons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

Widget Draw(double height, double width) {
  final DashBoardController dashBoardController = Get.find();
  final ProductController productController = Get.find();
  final OrderController orderController = Get.find();
  final CouponController couponController = Get.find();
  final PaymentController paymentController = Get.find();
  final CategoryController categoryController = Get.find();
  final BuyerController buyerController = Get.find();
  final CarouselController carouselController = Get.find();
  final ProductReviewController productReviewController = Get.find();

  return Drawer(
    width: math.max(width * 0.2, 300),
    backgroundColor: Colors.white,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.3,
            width: math.max(width * 0.2, 300),
            color: Colors.blue[400],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: height * 0.06),
                  alignment: Alignment.center,
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text(
                        "A",
                        style: TextStyle(color: Colors.black, fontSize: 50),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Admin Panel",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          DrawerOption(dashBoardController),
          DrawerOption(buyerController),
          DrawerOption(categoryController),
          DrawerOption(productController),
          DrawerOption(orderController),
          DrawerOption(paymentController),
          DrawerOption(productReviewController),
          DrawerOption(couponController),
          DrawerOption(carouselController),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  );
}
