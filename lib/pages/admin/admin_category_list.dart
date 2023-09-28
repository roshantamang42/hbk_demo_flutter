import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hbk_demo/components/admin_category.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class AdminCategoriesList extends StatefulWidget {
  AdminCategoriesList({super.key});

  @override
  State<AdminCategoriesList> createState() => _AdminCategoriesListState();
}

class _AdminCategoriesListState extends State<AdminCategoriesList> {
  var filePath = "";
  var categoryNameController = TextEditingController();
  final _categories = [];
  String categoryName = "";

  File? _selectedImage;

  void addCategory() async {
    // setState(() {
    //   categoryName : categoryNameController
    // });

    print(categoryNameController.text.toString());

    //   try {
    //     var url = "http://10.0.2.2:90/category/add";
    //     var response = await http.post(Uri.parse(url),
    //         headers: {"content-type": "multipart/form-data"},
    //         body: ({
    //           "category_name": categoryNameController.text.toString(),
    //           "category_photo": filePath
    //         }));
    //     if (response.statusCode == 200) {
    //     } else {
    //       print("Something went wrong!");
    //     }
    //   } catch (e) {
    //     print(e);
    //   }

    var stream = new http.ByteStream(_selectedImage!.openRead());
    stream.cast();

    var length = await _selectedImage!.length();
    var uri = Uri.parse('http://10.0.2.2:90/category/add');

    var request = new http.MultipartRequest('POST', uri);

    request.fields['category_name'] = "Momo";
    var multipart = new http.MultipartFile('image', stream, length);
    request.files.add(multipart);

    var response = await request.send();
    if (response.statusCode == 200) {
      print("yaya");
    } else {
      print("error");
    }
  }

  Future fetchCategories() async {
    var url = "http://10.0.2.2:90/category/showall";
    var response = await http.get(Uri.parse(url));
    var categories = [];

    if (response.statusCode == 200) {
      categories = jsonDecode(response.body)["data"];
    }
    return categories;
  }

  Future addPhoto() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "Categories",
            style: TextStyle(fontSize: 40),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return AdminCategory(
                    categoryId: _categories[index]["category_id"],
                    categoryName: _categories[index]["category_name"],
                    categoryPhoto: _categories[index]["category_photo"],
                    image: _categories[index]["category_photo"],
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
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
                            "Add New Category",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
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
                                        color: Colors.black,
                                        style: BorderStyle.solid)),
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
                              child: _selectedImage != null
                                  ? Image.file(
                                      _selectedImage!,
                                      height: 20,
                                      width: 20,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              onPressed: addCategory,
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
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  this.categoryNameController.text = '';
                                  _selectedImage = null;
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
              });
            },
          );
        },
      ),
    );
  }
}
