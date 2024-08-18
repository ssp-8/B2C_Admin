import 'package:admin/Constants/Constant.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

Widget emptyList(String word, double height, double width) {
  return Container(
    child: Column(
      children: [
        Container(
          height: height * 0.4,
          width: width * 0.4,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(Images.ImagePaths["EmptyList"]!),
          )),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          word,
          style: const TextStyle(color: Colors.black, fontSize: 30),
        )
      ],
    ),
  );
}
