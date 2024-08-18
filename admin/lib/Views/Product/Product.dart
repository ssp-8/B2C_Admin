// ignore_for_file: use_build_context_synchronously

import 'package:admin/Constants/Item.dart';
import 'package:admin/Controllers/product_controller.dart';
import 'package:flutter/material.dart';

Widget Product(ProductController productController, int product, double width,
    Color color, BuildContext actualcontext) {
  List<String> list = productController.list[product].getAttributes();
  print(list.length);
  return SizedBox(
    height: 60,
    width: width,
    child: ListView.builder(
        itemCount: list.length,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          if (index != list.length - 1) {
            return cell(list[index], index, Colors.white);
          }
          if (product == 0) return cell(list[index], index, Colors.blue[400]!);
          return null;
        })),
  );
}
