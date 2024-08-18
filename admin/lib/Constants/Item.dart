import 'package:flutter/material.dart';

Widget cell(String content, int uuid, Color color) {
  return Container(
    width: uuid == 0 || uuid == 8 || uuid == 11 || uuid == 13 ? 170 : 120,
    padding: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
        border: const Border(bottom: BorderSide(color: Colors.grey)),
        color: color),
    alignment: uuid == 0 && color == Colors.blue[50]
        ? Alignment.center
        : Alignment.topLeft,
    child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 13),
        child: SelectableText(
          content != "NaN"
              ? content == "true"
                  ? "Yes"
                  : content == "false"
                      ? "No"
                      : content
              : "",
          maxLines: 2,
          style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight:
                  color == Colors.white ? FontWeight.normal : FontWeight.w700),
        ),
      ),
    ),
  );
}
