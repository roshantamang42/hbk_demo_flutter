import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hbk_demo/config/config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditCategory extends StatefulWidget {
  late String categoryName1;
  late String categoryPhoto1;
  late int categoryId1;

  EditCategory(
      {super.key,
      required this.categoryId1,
      required this.categoryName1,
      required this.categoryPhoto1});

  @override
  State<EditCategory> createState() => _EditCategoryState(
      categoryId: categoryId1,
      categoryName: categoryName1,
      categoryPhoto: categoryPhoto1);
}

class _EditCategoryState extends State<EditCategory> {
  late String categoryName;
  late String categoryPhoto;
  late int categoryId;
  var categoryNameController = TextEditingController();
  File? pickedFile;

  //open gallery and save new state of name and image
  Future _openGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        pickedFile = File(image.path);
        categoryName = categoryNameController.text.toString();
      });
    } else {
      print("No image selected");
    }
  }

  Future<void> editCategory(categoryId) async {
    Dio dio = Dio();
    try {
      //if both file and name are present
      if (pickedFile != null) {
        String fileName = pickedFile!.path.split('/').last;
        FormData formData = FormData.fromMap(
          {
            "category_name": categoryName,
            "image": await MultipartFile.fromFile(pickedFile!.path,
                filename: fileName, contentType: MediaType("image", "jpg")),
            "type": "image/jpg"
          },
        );

        Response response = await dio.put(
            "http://10.0.2.2:90/category/update/$categoryId",
            data: formData,
            options: Options(headers: {
              "accept": "*/*",
              "Authorization": "",
              "Content-Type": "multipart/form-data"
            }));

        if (response.statusCode == 200) {
          print("Category updated successfully!");
          Navigator.of(context).pop();
        } else {
          print("Failed to update category Name!");
        }

        // if file is not selected
      } else {
        setState(() {
          categoryName = categoryNameController.text.toString();
        });

        var category = jsonEncode({"category_name": categoryName});

        var response = await http.put(
            Uri.parse("http://10.0.2.2:90/category/update1/$categoryId"),
            headers: {"Content-Type": "application/json"},
            body: category);

        if (response.statusCode == 200) {
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
    categoryNameController.text = categoryName;
    super.initState();
  }

  _EditCategoryState(
      {required this.categoryId,
      required this.categoryName,
      required this.categoryPhoto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Edit Category",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: categoryNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.black, style: BorderStyle.solid)),
                      hintText: "Category Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
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
                              baseUrl + "files/" + categoryPhoto,
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
                      editCategory(categoryId);
                    },
                    child: Text('Done'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        categoryNameController.text = '';
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
    );
  }
}
