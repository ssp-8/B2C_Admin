// ignore_for_file: use_build_context_synchronously

import 'package:admin/Constants/Item.dart';
import 'package:admin/Controllers/buyer_controller.dart';
import 'package:flutter/material.dart';

Widget Buyer(BuyerController buyerController, int buyer, double width,
    Color color, BuildContext actualcontext) {
  List<String> list = buyerController.list[buyer].getAttributes();
  print(list.length);
  return SizedBox(
    height: 60,
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
          return actionCell(list, buyerController, actualcontext);
        })),
  );
}

Widget actionCell(
    List<dynamic> list, BuyerController buyerController, BuildContext context) {
  return Container(
    width: 120,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey))),
    child: Container(
      height: 30,
      width: 80,
      decoration: BoxDecoration(
          color: list[list.length - 1] == 'Block' ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(5)),
      child: TextButton(
        onPressed: () async {
          int responseCode =
              await buyerController.blockBuyer(list[0], list[list.length - 1]);
          if (responseCode == 0) {
            AlertDialog dialog = AlertDialog(
              title: const Text("Action Completed"),
              content: Text("${list[list.length - 1]}ing is done"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok"))
              ],
            );
            showDialog(
                context: context,
                builder: (context) {
                  return dialog;
                });

            buyerController.getItems();
            buyerController.list.insert(0, buyerController.getFields());
          } else if (responseCode == 1) {
            AlertDialog dialog = AlertDialog(
              icon: const Icon(Icons.error),
              title: const Text("Error"),
              content: const Text("Internal Server Error"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok"))
              ],
            );
            showDialog(
                context: context,
                builder: (context) {
                  return dialog;
                });
          }
        },
        child: Text(
          list[list.length - 1],
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
