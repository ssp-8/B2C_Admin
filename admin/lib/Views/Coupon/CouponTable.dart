import 'package:admin/Constants/Item.dart';
import 'package:admin/Controllers/coupon_controller.dart';
import 'package:admin/Views/Coupon/Coupon.dart';
import 'package:flutter/material.dart';

Widget CouponTable(CouponController couponController, double width,
    double height, BuildContext actualcontext) {
  return SizedBox(
      width: width * 0.8,
      height: height * 0.7,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        SizedBox(
          width: couponController.getFields().length * 125,
          height: height * 0.7,
          child: ListView.builder(
            itemCount: couponController.list.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return columnNames(couponController, width);
              }
              return Coupon(
                  couponController, index, width, Colors.white, actualcontext);
            },
          ),
        )
      ]));
}

Widget columnNames(CouponController couponController, double width) {
  List<String> attributes = couponController.getFields();
  return Container(
    height: 40,
    width: width * 0.9,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: attributes.length,
        itemBuilder: ((context, index) {
          return cell(attributes[index], index, Colors.blue[50]!);
        })),
  );
}
