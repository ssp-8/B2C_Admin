import 'package:admin/Constants/Constant.dart';
import 'package:admin/Controllers/signin_controller.dart';
import 'package:admin/Views/Profile/LoginBoxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

List<Widget> SigninPage(
    double height,
    double width,
    bool row,
    TextEditingController usercontroller,
    TextEditingController passwordcontroller,
    Widget okButton,
    BuildContext context) {
  SignInController signInController = Get.find();

  return [
    Column(
      children: [
        Container(
          height: row == true ? height : height * 0.5,
          width: row == true ? width * 0.6 : width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.ImagePaths["Signin"]!),
                  fit: BoxFit.cover)),
        ),
      ],
    ),
    Container(
      height: row == true ? height : height * 0.5,
      width: row == true ? width * 0.4 : width,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: height * 0.2,
        left: width * 0.05,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        scrollDirection: row == true ? Axis.horizontal : Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello,\nwelcome!",
              style: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: row == true ? 50 : 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            loginBoxes(usercontroller, width, "Username", false, Icons.person),
            loginBoxes(passwordcontroller, width, "Password", true, Icons.lock),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 30),
              child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextButton(
                      onPressed: () async {
                        bool loggedIn = await signInController.verified(
                            usercontroller.text.replaceAll(" ", ""),
                            passwordcontroller.text.replaceAll(" ", ""));
                        if (loggedIn) {
                          signInController.Next();
                        } else {
                          AlertDialog dialog = AlertDialog(
                              title: Text("Sign in"),
                              content: Text("Incorrect Username or Password"),
                              actions: [okButton]);

                          showDialog(
                              context: context,
                              builder: (context) {
                                return dialog;
                              });
                        }
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ))),
            )
          ],
        ),
      ),
    )
  ];
}
