import 'package:admin/Constants/SignOut.dart';
import 'package:admin/Controllers/coupon_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddCoupon extends StatefulWidget {
  @override
  State<AddCoupon> createState() => _AddCouponState();
}

class _AddCouponState extends State<AddCoupon> {
  CouponController couponController = Get.find<CouponController>();
  TextEditingController couponNameController = TextEditingController();
  TextEditingController couponCodeController = TextEditingController();
  TextEditingController couponBuyerIDController = TextEditingController();
  TextEditingController couponValidityController = TextEditingController();
  TextEditingController couponAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.blue[400],
        actions: [SignOut()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, top: 50),
            child: Text(
              "Add Coupons",
              style: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, top: 5),
            child: const Text(
              "Here, you can add a Coupon.\nEither Buyer ID or Validity must be there.\nSubmit Coupon makes the Coupon available to use.\nIf the amount is in percentage, then add the '%' symbol intially",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.grey,
            indent: width * 0.1,
            endIndent: width * 0.1,
          ),
          const SizedBox(
            height: 10,
          ),
          Field(width, "Coupon Name", couponNameController, true),
          const SizedBox(
            height: 10,
          ),
          Field(width, "Coupon Code", couponCodeController, true),
          const SizedBox(
            height: 10,
          ),
          Field(width, "Coupon Amount", couponAmountController, true),
          const SizedBox(
            height: 10,
          ),
          Field(width, "Buyer ID", couponBuyerIDController, false),
          const SizedBox(
            height: 10,
          ),
          Field(width, "Coupon Validity", couponValidityController, false),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: (width * 0.9 - 150)),
            child: Container(
              width: 170,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                  onPressed: () async {
                    Map<String, String> body = {};
                    if (couponAmountController.text == "" ||
                        couponCodeController.text == "" ||
                        couponNameController.text == "" ||
                        (couponBuyerIDController.text == "" &&
                            couponValidityController.text == "")) {
                      AlertDialog dialog = AlertDialog(
                        title: const Text("Error"),
                        content: const Text(
                            "One of the required field is kept empty\nPlease check!"),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                          )
                        ],
                      );
                      showDialog(
                          context: context, builder: (context) => dialog);
                    } else {
                      body["name"] = couponNameController.text;
                      body["validity"] = couponValidityController.text;
                      body["amount"] = couponAmountController.text;
                      body["code"] = couponCodeController.text;
                      body["buyerid"] = couponBuyerIDController.text;
                      couponController.addItem(body);
                      AlertDialog dialog = AlertDialog(
                        title: const Text("Successful"),
                        content: const Text("Item Added Successfully !"),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            },
                          )
                        ],
                      );
                      showDialog(
                          context: context, builder: (context) => dialog);
                    }
                  },
                  child: const Text(
                    "Submit Coupon",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

Widget Field(double width, String textname, TextEditingController controller,
    bool isRequired) {
  return Container(
    width: width * 0.8,
    padding: EdgeInsets.only(left: width * 0.1),
    height: 50,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 200,
          child: TextField(
            onEditingComplete: () {
              controller.text.replaceAll(" ", "");
            },
            enabled: false,
            decoration: InputDecoration(
                label: RichText(
                    text: TextSpan(
                        text: textname,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        children: isRequired == true
                            ? const [
                                TextSpan(text: " "),
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(color: Colors.red))
                              ]
                            : [])),
                border: InputBorder.none,
                hintText: textname,
                hintStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
                suffixText: "*",
                suffixStyle: TextStyle(color: Colors.red)),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            width: 300,
            height: 50,
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
            ))
      ],
    ),
  );
}
