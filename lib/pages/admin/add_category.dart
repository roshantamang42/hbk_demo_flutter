import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hbk_demo/config/config.dart';
import 'package:hbk_demo/config/image_upload_service.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  var categoryNameController = TextEditingController();
  late String categoryName;
  File? pickedFile;

  // ImageUploadService uploadService = ImageUploadService();

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

  Future<void> addCategory() async {
    categoryName = categoryNameController.text.toString();
    try {
      Dio dio = Dio();

      String fileName = pickedFile!.path.split('/').last;

      FormData formData = FormData.fromMap(
        {
          "category_name": categoryName,
          "image": await MultipartFile.fromFile(pickedFile!.path,
              filename: fileName, contentType: MediaType("image", "jpg")),
          "type": "image/jpg"
        },
      );
      Response response = await dio.post("http://10.0.2.2:90/category/add",
          data: formData,
          options: Options(headers: {
            "accept": "*/*",
            "Authorization": "",
            "Content-Type": "multipart/form-data"
          }));

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        print("Category added successfully!");
      } else {
        print("Failed to add category!");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Add New Category",
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
                      addCategory();
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
