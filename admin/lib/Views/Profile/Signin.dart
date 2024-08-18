// ignore_for_file: must_be_immutable, file_names

import 'package:admin/Constants/Constant.dart';
import 'package:admin/Controllers/dashboard_controller.dart';
import 'package:admin/Controllers/signin_controller.dart';

import 'package:admin/Controllers/signout_controller.dart';
import 'package:admin/Views/DashBoard/Dashboard.dart';
import 'package:admin/Views/Profile/LoginBoxes.dart';
import 'package:admin/Views/Profile/SigninPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usercontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  SignInController signInController = Get.find();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {
          usercontroller.text = "";
          passwordcontroller.text = "";
          Navigator.pop(context);
        });
      },
    );
    bool row = false;
    if (height > 650 && width > 815) row = true;
    return Scaffold(
        backgroundColor: Colors.amber[50],
        body: row == true
            ? Row(
                children: SigninPage(height, width, row, usercontroller,
                    passwordcontroller, okButton, context))
            : SingleChildScrollView(
                child: Column(
                  children: SigninPage(height, width, row, usercontroller,
                      passwordcontroller, okButton, context),
                ),
              ));
  }
}
