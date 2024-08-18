// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:admin/Constants/Item.dart';
import 'package:admin/Controllers/coupon_controller.dart';
import 'package:flutter/material.dart';

Widget Coupon(CouponController couponController, int buyer, double width,
    Color color, BuildContext actualcontext) {
  List<String> list = couponController.list[buyer].getAttributes();

  return SizedBox(
    height: 50,
    width: width * 0.8,
    child: ListView.builder(
        itemCount: list.length,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          if (index != list.length - 1) {
            return cell(list[index], index, Colors.white);
          }
          if (buyer == 0) return cell(list[index], index, Colors.blue[400]!);
          return null;
          // return actionCell(list, couponController, actualcontext);
        })),
  );
}
