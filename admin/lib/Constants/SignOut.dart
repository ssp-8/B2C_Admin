import 'package:admin/Controllers/signout_controller.dart';
import 'package:admin/Views/Profile/Signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget SignOut() {
  return TextButton(
      onPressed: () async {
        final SignOutController signOutController = Get.find();
        bool signedout = await signOutController.signOut();
        if (signedout) {
          Get.offAll(Login());
        }
      },
      child: const Text(
        "Sign out",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ));
}
