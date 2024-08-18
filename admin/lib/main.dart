import 'package:admin/Controllers/signin_controller.dart';
import 'package:admin/Controllers/http_controller.dart';
import 'package:admin/Views/DashBoard/Dashboard.dart';
import 'package:admin/Views/Profile/Signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

double Gwidth = 0;
double Gheight = 0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Gwidth = MediaQuery.of(context).size.width;
    Gheight = MediaQuery.of(context).size.height;

    Get.put(HttpController(), tag: "httpController");
    Get.put(SignInController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Login(),
      title: "Admin App",
    );
  }
}
