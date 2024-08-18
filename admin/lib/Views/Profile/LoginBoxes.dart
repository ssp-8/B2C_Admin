import 'package:flutter/material.dart';
import 'dart:math' as math;

Widget loginBoxes(TextEditingController controller, double width, String label,
    bool obscure, IconData icon) {
  return Container(
      padding: const EdgeInsets.only(top: 50),
      width: math.max(width * 0.3, 200),
      child: TextField(
        obscureText: obscure,
        controller: controller,
        cursorHeight: 25,
        decoration: InputDecoration(
          label: Text(label),
          border: const OutlineInputBorder(),
          icon: Icon(
            icon,
            color: Colors.black,
            size: 30,
          ),
          hoverColor: Colors.purple,
        ),
      ));
}
