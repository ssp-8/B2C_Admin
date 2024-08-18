// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget DrawerOption(Controller) {
  return Padding(
    padding: EdgeInsets.only(left: 30, top: 50),
    child: TextButton.icon(
        onPressed: Controller.onPressed,
        icon: Icon(
          Controller.icon,
          color: Colors.blue[400],
        ),
        label: Text(
          Controller.name,
          style: TextStyle(color: Colors.black, fontSize: 20),
        )),
  );
}
