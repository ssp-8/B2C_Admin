import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

Widget DashBox(
    double height, String title, IconData icon, Color color, RxList list) {
  return Container(
    padding: const EdgeInsets.only(top: 15),
    height: math.min(height * 0.25, 300),
    width: 300,
    decoration: BoxDecoration(color: color, boxShadow: const [
      BoxShadow(color: Colors.black, blurRadius: 5, offset: Offset(0, 1))
    ]),
    child: Column(
      children: [
        TextButton.icon(
            onPressed: () {
              // Open Orders Page
            },
            icon: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            label: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 30),
            )),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Obx(
            () => Countup(
              begin: 0,
              end: list.length.toDouble(),
              style: const TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
        )
      ],
    ),
  );
}
