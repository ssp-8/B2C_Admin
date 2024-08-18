import 'package:admin/Controllers/buyer_controller.dart';
import 'package:admin/Controllers/carousel_controller.dart';
import 'package:admin/Controllers/category_controller.dart';
import 'package:admin/Controllers/coupon_controller.dart';
import 'package:admin/Controllers/order_controller.dart';
import 'package:admin/Controllers/payment_controller.dart';
import 'package:admin/Controllers/productReview_controller.dart';
import 'package:admin/Controllers/product_controller.dart';
import 'package:admin/Controllers/signout_controller.dart';
import 'package:admin/Controllers/dashboard_controller.dart';
import 'package:admin/Controllers/http_controller.dart';
import 'package:admin/Views/DashBoard/Dashboard.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignInController extends GetxController {
  Next() {
    Get.put(SignOutController());
    Get.put(DashBoardController());
    Get.put(ProductController());
    Get.put(OrderController());
    Get.put(CouponController());
    Get.put(ProductReviewController());
    Get.put(PaymentController());
    Get.put(CategoryController());
    Get.put(CarouselController());
    Get.put(BuyerController());
    Get.to(() => DashBoard());
  }

  Future<bool> verified(String username, String password) async {
    String baseUrl = HttpController.baseUrl;
    String getUrl = "$baseUrl/signin";
    Map<String, String> header = {"X-cred": "B2C@2807 B2C@2807"};

    var response = await http.get(Uri.parse(getUrl), headers: header);
    print(response);
    if (response.statusCode == 200) return true;

    return false;
  }
}
