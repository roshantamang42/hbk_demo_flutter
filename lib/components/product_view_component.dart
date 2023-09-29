import 'package:flutter/material.dart';
import 'package:hbk_demo/pages/admin/products/edit_product.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ProductViewComponent extends StatelessWidget {
  late int productId;
  late String productName;
  late int categoryId;
  late String price;
  late String supplierInfo;
  late String productPhoto;
  //final String image;

  ProductViewComponent(
      {super.key,
      required this.productId,
      required this.productName,
      required this.categoryId,
      required this.price,
      required this.supplierInfo,
      required this.productPhoto});

  Future deleteproducts(productId) async {
    try {
      var url = "http://10.0.2.2:90/product/delete/$productId";

      var response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        print("product deleted");
      } else {
        print("cannot delete product");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 400,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 80,
                  width: 100,
                  child:
                      Image.network("http://10.0.2.2:90/files/$productPhoto")),
            ),
            Text(
              productName,
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EditProduct(
                      //       productId: productId,
                      //       productName: productName,
                      //       categoryId: categoryId,
                      //       price: price,
                      //       supplierInfo: supplierInfo,
                      //       productPhoto: productPhoto,
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Delete"),
                              content: Text("Are you sure you want to delete?"),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        deleteproducts(productId);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    )
                                  ],
                                )
                              ],
                            );
                          });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
