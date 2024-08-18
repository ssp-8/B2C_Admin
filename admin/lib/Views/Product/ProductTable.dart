import 'package:admin/Constants/Item.dart';
import 'package:admin/Controllers/product_controller.dart';
import 'package:admin/Views/Product/Product.dart';
import 'package:flutter/material.dart';

Widget ProductTable(ProductController productController, double width,
    double height, BuildContext actualcontext) {
  return SizedBox(
      width: width * 0.8,
      height: height * 0.7,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        SizedBox(
          width: productController.getFields().length * 130,
          height: height * 0.7,
          child: ListView.builder(
            itemCount: productController.list.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return columnNames(productController, width);
              }
              return Product(
                  productController, index, width, Colors.white, actualcontext);
            },
          ),
        )
      ]));
}

Widget columnNames(ProductController productController, double width) {
  List<String> attributes = productController.getFields();
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
