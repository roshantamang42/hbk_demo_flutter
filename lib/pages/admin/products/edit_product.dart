import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hbk_demo/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  late int productId;
  late String productName;
  late int categoryId;
  late String price;
  late String supplierInfo;
  late String productPhoto;

  EditProduct({
    required this.productId,
    required this.productName,
    required this.categoryId,
    required this.price,
    required this.supplierInfo,
    required this.productPhoto,
  });

  @override
  State<EditProduct> createState() => _EditProductState(
        productId1: productId,
        productName1: productName,
        categoryId1: categoryId,
        price1: price,
        supplierInfo1: supplierInfo,
        productPhoto1: productPhoto,
      );
}

class _EditProductState extends State<EditProduct> {
  late int productId1;
  late String productName1;
  late int categoryId1;
  late String price1;
  late String supplierInfo1;
  late String productPhoto1;
  List _categories = [];
  String? _mySelection;
  File? pickedFile;

  var productNameController = TextEditingController();
  var priceController = TextEditingController();
  var supplierInfoController = TextEditingController();

  _EditProductState({
    required this.productId1,
    required this.productName1,
    required this.categoryId1,
    required this.price1,
    required this.supplierInfo1,
    required this.productPhoto1,
  });

  Future fetchCategories() async {
    var url = "http://10.0.2.2:90/category/showall";
    var response = await http.get(Uri.parse(url));
    var categories = [];

    if (response.statusCode == 200) {
      categories = jsonDecode(response.body)["data"];
    }
    return categories;
  }

  Future _openGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        pickedFile = File(image.path);
      });
    } else {
      print("No image selected");
    }
  }

  Future fetchOneCategory(int categoryId) async {
    var url = "http://10.0.2.2:90/category/show/$categoryId";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _mySelection = jsonDecode(response.body)["data"][0]["category_name"];
      });
    }
  }

  editProduct() async {
    Dio dio = Dio();
    try {
      //if both file and name are present
      if (pickedFile != null) {
        String fileName = pickedFile!.path.split('/').last;
        FormData formData = FormData.fromMap(
          {
            "product_name": productNameController.text,
            "description": supplierInfoController.text,
            "category_id": int.parse(_mySelection.toString()),
            "price": priceController.text,
            "image": await MultipartFile.fromFile(pickedFile!.path,
                filename: fileName, contentType: MediaType("image", "jpg")),
            "type": "image/jpg"
          },
        );

        Response response = await dio.put(
            "http://10.0.2.2:90/product/update/$productId1",
            data: formData,
            options: Options(headers: {
              "accept": "*/*",
              "Authorization": "",
              "Content-Type": "multipart/form-data"
            }));

        if (response.statusCode == 200) {
          print("Product updated successfully with photo!");
          Navigator.of(context).pop();
        } else {
          print("Failed to update product!");
        }

        // if file is not selected
      } else {
        // setState(() {
        //   productName1 = productNameController.text.toString();

        // });

        var product = jsonEncode({
          "product_name": productNameController.text,
          "description": supplierInfoController.text,
          "category_id": int.parse(_mySelection.toString()),
          "price": priceController.text.toString(),
        });

        var response = await http.put(
            Uri.parse("http://10.0.2.2:90/product/update1/$productId1"),
            headers: {"Content-Type": "application/json"},
            body: product);

        if (response.statusCode == 200) {
          print("updated without photo");
          Navigator.of(context).pop();
        } else {
          print("Unable to Update");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    productNameController.text = productName1;
    priceController.text = price1;
    supplierInfoController.text = supplierInfo1;
    supplierInfoController = supplierInfoController;

    //fetchOneCategory(categoryId1);

    fetchCategories().then((value) {
      setState(() {
        _categories.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 5),
              child: Text(
                "Edit Product",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        controller: productNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    style: BorderStyle.solid)),
                            hintText: "Product Name"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black)),
                        child: DropdownButton<String>(
                          //value: _mySelection != null ? _mySelection : null,
                          value: _mySelection != null ? _mySelection : null,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          hint: Text('Select a Category...'),
                          onChanged: (String? newValue) {
                            setState(() {
                              _mySelection = newValue!;
                            });
                          },
                          items: _categories.map((item) {
                            return DropdownMenuItem(
                              value: item['category_id'].toString(),
                              child: Text(item["category_name"]),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        "Price",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                        prefixText: "Rs.",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors.black, style: BorderStyle.solid)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Suppliers Info",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        controller: supplierInfoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        onTap: _openGallery,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8)),
                            height: 150,
                            width: double.infinity,
                            child: pickedFile != null
                                ? Image.file(
                                    File(pickedFile!.path),
                                    height: 20,
                                    width: 20,
                                  )
                                : Image.network(
                                    baseUrl + "files/" + productPhoto1,
                                    height: 20,
                                    width: 20,
                                  )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(),
                          onPressed: () {
                            editProduct();
                          },
                          child: Text('Edit'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
