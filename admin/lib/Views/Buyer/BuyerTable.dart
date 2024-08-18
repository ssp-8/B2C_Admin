import 'package:admin/Constants/Item.dart';
import 'package:admin/Controllers/buyer_controller.dart';
import 'package:admin/Views/Buyer/Buyer.dart';
import 'package:flutter/material.dart';

Widget BuyerTable(BuyerController buyerController, double width, double height,
    BuildContext actualcontext) {
  return SizedBox(
      width: width * 0.8,
      height: height * 0.7,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        SizedBox(
          width: buyerController.getFields().length * 125,
          height: height * 0.7,
          child: ListView.builder(
            itemCount: buyerController.list.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return columnNames(buyerController, width);
              }
              return Buyer(
                  buyerController, index, width, Colors.white, actualcontext);
            },
          ),
        )
      ]));
}

Widget columnNames(BuyerController buyerController, double width) {
  List<String> attributes = buyerController.getFields();
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
