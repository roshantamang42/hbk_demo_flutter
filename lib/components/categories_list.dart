// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hbk_demo/models/categories_model.dart';
import 'package:http/http.dart' as http;

class CategoriesList extends StatelessWidget {
  late String category_name;
  final String category_photo;

  CategoriesList({required this.category_name, required this.category_photo});

  //List<CategoriesModel> _categories = <CategoriesModel>[];

  // void getCategories() async {
//   try {
//     Response response = await get(
//       Uri.parse("http://10.0.2.2:90/category/showall"),
//     );
//     print("hello");

//     if (response.statusCode == 200) {
//       var parsed = jsonDecode(response.body);
//       print(jsonDecode(response.body)["data"][0]);
//     } else {
//       print("login failed");
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }

//class _CategoriesListState extends State<CategoriesList> {
  //List<CategoriesModel> _categories = <CategoriesModel>[];

  // Future fetchCategories() async {
  //   var url = "http://10.0.2.2:90/category/showall";
  //   var response = await http.get(Uri.parse(url));

  //   //var categories = List<CategoriesModel>.empty();

  //   //var _categories = <CategoriesModel>[];

  //   var categories = [];

  //   if (response.statusCode == 200) {
  //     //print(jsonDecode(response.body)["data"].runtimeType);
  //     categories = jsonDecode(response.body)["data"];
  //     //_categories = jsonDecode(response.body)["data"];
  //     //print(categories);
  //     print(categories[1]["category_name"]);

  //     // for (var category in categories) {
  //     //   _categories.add(category);
  //     //   //print(category);
  //     // }
  //     // print(_categories);
  //   }

  //   return categories;
  // }

  // @override
  // void initState() {
  //   fetchCategories();
  //   super.initState();
  // }

  // @override
  // void initState() {
  //   getCategories();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 114,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    "http://10.0.2.2:90/files/" + category_photo),
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
