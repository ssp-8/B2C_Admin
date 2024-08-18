import 'package:admin/Constants/Item.dart';
import 'package:flutter/material.dart';

Widget ItemTable(
    controller, double width, double height, BuildContext actualcontext) {
  return SizedBox(
      width: width * 0.8,
      height: height * 0.7,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        SizedBox(
          width: (controller.list[0].length * 150).toDouble() + 150,
          height: height * 0.7,
          child: ListView.builder(
            itemCount: controller.list.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return columnNames(controller, width);
              }
              return cell(controller, index, Colors.white);
            },
          ),
        )
      ]));
}

Widget columnNames(controller, double width) {
  List<String> attributes = controller.getFields();
  return Container(
    height: 50,
    width: (controller.list[0].length * 150).toDouble() + 150,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: attributes.length,
        itemBuilder: ((context, index) {
          return cell(attributes[index], index, Colors.white);
        })),
  );
}
