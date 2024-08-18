import 'package:admin/Constants/SignOut.dart';
import 'package:admin/Controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  ProductController productController = Get.find<ProductController>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productCompanyController = TextEditingController();
  TextEditingController productQtyController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDiscountController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();
  TextEditingController productSubCategoryController = TextEditingController();
  TextEditingController productSpecificAttributeController =
      TextEditingController();
//
//
//
//       "Specific_attribute",
//       "Images",
//       "Videos",
//       "Obj"
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
              "Add Products",
              style: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, top: 5),
            child: const Text(
              "Here, you can add a Product.\nEither Product ID or Validity must be there.\nSubmit Product makes the Product available to use.\nIf the amount is in percentage, then add the '%' symbol intially",
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
          Field(width, "Product Name", productNameController, true,
              "Product Company", productCompanyController, true),
          const SizedBox(
            height: 10,
          ),
          Field(width, "Product Price", productPriceController, true,
              "Product Quantity", productQtyController, true),
          const SizedBox(
            height: 10,
          ),
          Field(width, "Product Description", productDescriptionController,
              true, "Product Category", productCategoryController, true),
          const SizedBox(
            height: 10,
          ),
          Field(width, "Product SubCategory", productSubCategoryController,
              false, "Product Discount", productDiscountController, false),
          const SizedBox(
            height: 10,
          ),
          Field(
              width,
              "Product Specific Attributes",
              productSpecificAttributeController,
              false,
              "",
              productSpecificAttributeController,
              false),
          const SizedBox(
            height: 10,
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
                    if (productCategoryController.text == "" ||
                        productCompanyController.text == "" ||
                        productQtyController.text == "" ||
                        productDescriptionController.text == "" ||
                        productNameController.text == "" ||
                        productPriceController.text == "") {
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
                      body["name"] = productNameController.text;
                      body["price"] = productPriceController.text;
                      body["qty"] = productQtyController.text;
                      body["category"] = productCategoryController.text;
                      body["description"] = productDescriptionController.text;
                      body["company"] = productCompanyController.text;
                      if (productDiscountController.text != "") {
                        body["discount"] = productDiscountController.text;
                      }
                      if (productSpecificAttributeController.text != "") {
                        body["specific_attributes"] =
                            productSpecificAttributeController.text;
                      }
                      if (productSubCategoryController.text != "") {
                        body["subcategory"] = productSubCategoryController.text;
                      }

                      productController.addItem(body);
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
                    "Submit Product",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

Widget Field(
    double width,
    String textname_1,
    TextEditingController controller_1,
    bool isRequired_1,
    String textname_2,
    TextEditingController controller_2,
    bool isRequired_2) {
  return Container(
    width: width * 0.9,
    padding: EdgeInsets.only(left: width * 0.1),
    height: 50,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 260,
          child: TextField(
            onEditingComplete: () {
              controller_1.text.replaceAll(" ", "");
            },
            enabled: false,
            decoration: InputDecoration(
                label: RichText(
                    text: TextSpan(
                        text: textname_1,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        children: isRequired_1 == true
                            ? const [
                                TextSpan(text: " "),
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(color: Colors.red))
                              ]
                            : [])),
                border: InputBorder.none),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            width: 200,
            height: 50,
            alignment: Alignment.center,
            child: TextField(
              controller: controller_1,
            )),
        SizedBox(
          width: 20,
        ),
        textname_2 == ""
            ? Container()
            : Container(
                width: 260,
                child: TextField(
                  onEditingComplete: () {
                    controller_2.text.replaceAll(" ", "");
                  },
                  enabled: false,
                  decoration: InputDecoration(
                      label: RichText(
                          text: TextSpan(
                              text: textname_2,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                              children: isRequired_2 == true
                                  ? const [
                                      TextSpan(text: " "),
                                      TextSpan(
                                          text: "*",
                                          style: TextStyle(color: Colors.red))
                                    ]
                                  : [])),
                      border: InputBorder.none),
                ),
              ),
        const SizedBox(
          width: 20,
        ),
        textname_2 == ""
            ? Container()
            : Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                width: 200,
                height: 50,
                alignment: Alignment.center,
                child: TextField(
                  controller: controller_2,
                ))
      ],
    ),
  );
}
