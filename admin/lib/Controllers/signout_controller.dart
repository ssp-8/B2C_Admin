import 'package:admin/Constants/Constant.dart';
import 'package:admin/Controllers/dashboard_controller.dart';
import 'package:admin/Controllers/http_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignOutController extends GetxController {
  Future<bool> signOut() async {
    String baseUrl = HttpController.baseUrl;
    String postUrl = "$baseUrl/signout";

    var response = await http.post(Uri.parse(postUrl));
    if (response.statusCode == 200) {
      final DashBoardController dashboardcontroller = Get.find();
      dashboardcontroller.ProductList.clear();
      dashboardcontroller.OrderList.clear();
      dashboardcontroller.UserList.clear();
      return true;
    }
    return false;
  }
}
