import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hbk_demo/components/show_bottom.dart';
import 'package:hbk_demo/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AdminCategory extends StatelessWidget {
  late String categoryName;
  late String categoryPhoto;
  late int categoryId;
  late String image;
  var categoryNameController = TextEditingController();

  AdminCategory(
      {required this.categoryName,
      required this.categoryPhoto,
      required this.categoryId,
      required this.image});

  Future addPhoto() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    // setState(() {
    //   _selectedImage = File(returnedImage.path);
    // });
  }

  Future editCategory(categoryId) async {
    var url = "${baseUrl}category/update/$categoryId";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("nice");
    } else {
      print("no nice");
    }
  }

  Future deleteCategories(categoryId) async {
    try {
      var url = "http://10.0.2.2:90/category/delete/$categoryId";
      print(url);
      var response = await http.delete(Uri.parse(url));

      print(response.statusCode);

      if (response.statusCode == 200) {
        print("category delted");
      } else {
        print("cannot delete category");
      }
    } catch (e) {
      print(e.toString());
    }

    //print(categories[1]["category_name"].runtimeType);
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
                      Image.network("http://10.0.2.2:90/files/$categoryPhoto")),
            ),
            Text(
              categoryName,
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
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 500,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        "Edit Category",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: TextField(
                                        controller: categoryNameController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    style: BorderStyle.solid)),
                                            hintText: "Category Name"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: GestureDetector(
                                        onTap: addPhoto,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          height: 150,
                                          width: double.infinity,
                                          child: image != null
                                              ? Image.network(
                                                  baseUrl + "files/" + image,
                                                  height: 20,
                                                  width: 20,
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                      Icon(Icons
                                                          .cloud_upload_outlined),
                                                      Text(
                                                          "Click here to choose an image")
                                                    ]),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            // setState(() {
                                            //   categoryNameController.text = '';
                                            //   image = null;
                                            // });
                                          },
                                          child: Text(
                                            'Cancel',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
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
                                        deleteCategories(categoryId);
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
