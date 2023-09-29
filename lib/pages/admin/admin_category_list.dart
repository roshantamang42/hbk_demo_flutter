import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hbk_demo/components/admin_category.dart';
import 'package:hbk_demo/config/image_upload_service.dart';
import 'package:hbk_demo/pages/admin/add_category.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class AdminCategoriesList extends StatefulWidget {
  AdminCategoriesList({super.key});

  @override
  State<AdminCategoriesList> createState() => _AdminCategoriesListState();
}

class _AdminCategoriesListState extends State<AdminCategoriesList> {
  final _categories = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Text(
          //   "Categories",
          //   style: TextStyle(fontSize: 40),
          // ),
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
          Navigator.pushNamed(context, '/addCategory');
          // showModalBottomSheet(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return StatefulBuilder(
          //         builder: (BuildContext context, StateSetter setState) {
          //       return Text("data");
          //     });
          //   },
          // );
        },
      ),
    );
  }
}
