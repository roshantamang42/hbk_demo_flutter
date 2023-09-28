import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ShowBottom extends StatefulWidget {
  ShowBottom({super.key});

  @override
  State<ShowBottom> createState() => _ShowBottomState();
}

class _ShowBottomState extends State<ShowBottom> {
  final categoryNameController = TextEditingController();

  late int categoryId;
  late String categoryName;
  late File? image;

  Future addPhoto() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    // setState(() {
    //   _selectedImage = File(returnedImage.path);
    // });
  }

  Future editCategory(categoryId) async {
    var url = "http://10.0.2.2:90/category/update/$categoryId";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("nice");
    } else {
      print("no nice");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                onTap: addPhoto,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)),
                  height: 150,
                  width: double.infinity,
                  child: image != null
                      ? Image.file(
                          image!,
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
                      image = null;
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
    );
  }
}
