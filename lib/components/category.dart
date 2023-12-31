// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hbk_demo/models/categories_model.dart';
import 'package:http/http.dart' as http;

class Category extends StatelessWidget {
  late String category_name;
  final String category_photo;

  Category({required this.category_name, required this.category_photo});

  Future fetchCategories() async {
    var url = "http://10.0.2.2:90/category/showall";
    var response = await http.get(Uri.parse(url));
    var categories = [];

    if (response.statusCode == 200) {
      categories = jsonDecode(response.body)["data"];
    }

    //print(categories[1]["category_name"].runtimeType);
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.,
          children: [
            Padding(
              padding: const EdgeInsets.all(3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    Image.network("http://10.0.2.2:90/files/" + category_photo),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(
                category_name,
                //style: TextStyle(fontSize: 18),
              ),
            ),
            // GestureDetector(
            //   child: Text("get data"),
            //   onTap: () => {fetchCategories()},
            // )
          ],
        ),
      ),
    );
  }
}
