import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hbk_demo/config/config.dart';
import 'package:hbk_demo/config/image_upload_service.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddproductsState();
}

class _AddproductsState extends State<AddProduct> {
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  var productNameController = TextEditingController();
  var supplierInfoController = TextEditingController();
  var priceController = TextEditingController();

  late String productName;
  File? pickedFile;
  List _categories = [];
  String? _mySelection; // null check otherwise error for null
  late String supplierInfo = "";
  late String price = "";

  Future fetchCategories() async {
    var url = "http://10.0.2.2:90/category/showall";
    var response = await http.get(Uri.parse(url));
    var categories = [];

    if (response.statusCode == 200) {
      categories = jsonDecode(response.body)["data"];
    }
    return categories;
  }

  @override
  void initState() {
    fetchCategories().then((value) {
      setState(() {
        _categories.addAll(value);
      });
    });
    super.initState();
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

  Future<void> addproducts() async {
    productName = productNameController.text.toString();
    supplierInfo = supplierInfoController.text.toString();

    price = priceController.text.toString();

    try {
      Dio dio = Dio();

      String fileName = pickedFile!.path.split('/').last;

      FormData formData = FormData.fromMap(
        {
          "product_name": productName,
          "description": supplierInfo,
          "category_id": int.parse(_mySelection.toString()),
          "price": price,
          "image": await MultipartFile.fromFile(pickedFile!.path,
              filename: fileName, contentType: MediaType("image", "jpg")),
          "type": "image/jpg"
        },
      );
      Response response = await dio.post("http://10.0.2.2:90/product/add",
          data: formData,
          options: Options(headers: {
            "accept": "*/*",
            "Authorization": "",
            "Content-Type": "multipart/form-data"
          }));

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        print("product added successfully!");
      } else {
        print("Failed to add product!");
      }
    } catch (e) {
      print(e.toString());
    }
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
                "Add New Product",
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            iconSize: 40,
                            value: _mySelection,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
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
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Icon(Icons.cloud_upload_outlined),
                                      Text("Click here to choose an image")
                                    ]),
                        ),
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
                            addproducts();
                          },
                          child: Text('Add'),
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
                              backgroundColor: Colors.red[400]),
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              productNameController.text = '';
                              pickedFile = null;
                            });
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
