import 'package:flutter/material.dart';
import 'package:hbk_demo/components/categories_list.dart';
import 'package:hbk_demo/components/product_list.dart';
import 'package:hbk_demo/models/categories_model.dart';
import 'package:hbk_demo/pages/ordersList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard1 extends StatefulWidget {
  @override
  State<Dashboard1> createState() => _Dashboard1State();
}

class _Dashboard1State extends State<Dashboard1> {
  var _categories = [];
  var _products = [];
  int total_price = 0;
  int category_id = 0;

  var _cart = [];

  //final List category = ["pilot", "surya"];

  // List<CategoriesModel> _categories = <CategoriesModel>[];

  // Future<List<CategoriesModel>> fetchCategories() async {
  //   var url = "http://10.0.2.2:90/category/showall";
  //   var response = await http.get(Uri.parse(url));

  //   //var categories = List<CategoriesModel>.empty();
  //   var categories = <CategoriesModel>[];

  //   if (response.statusCode == 200) {
  //     print(http.get(Uri.parse(url)));
  //     var categories = jsonDecode(response.body);
  //     for (var category in categories) {
  //       categories.add[CategoriesModel.fromJson(category)];
  //     }
  //   }

  //   return categories;
  // }

  // @override
  // void initState() {
  //   fetchCategories().then((value) {
  //     setState(() {
  //       _categories.addAll(value);
  //     });
  //   });
  //   super.initState();

  // }

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

  // Future fetchProducts() async {
  //   var url = "http://10.0.2.2:90/product/showall";
  //   var response = await http.get(Uri.parse(url));
  //   var products = [];

  //   if (response.statusCode == 200) {
  //     products = jsonDecode(response.body)["data"];
  //   }

  //   //print(products);
  //   return products;
  // }

  //initial function to fetch products
  Future fetchProducts(int categoryId) async {
    var url = "http://10.0.2.2:90/product/$categoryId";
    var response = await http.get(Uri.parse(url));
    var products = [];

    if (response.statusCode == 200) {
      products = jsonDecode(response.body)["data"];
    }

    //print(products);
    return products;
  }

  // fetch products by categories by clicking on categories
  fetchProducts1(int categoryId) async {
    var url = "http://10.0.2.2:90/product/$categoryId";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _products = jsonDecode(response.body)["data"];
      });

      if (_products == null) {
        print("products not found!");
      }
    }
  }

  @override
  void initState() {
    fetchCategories().then((value) {
      setState(() {
        _categories.addAll(value);
      });

      category_id = _categories[0]["category_id"];

      fetchProducts(category_id).then((value) {
        setState(() {
          _products.addAll(value);
        });
      });
    });

    super.initState();
  }

  addItem(int index) {
    setState(() {
      _cart.add(_products[index]);
      print(_cart);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      backgroundColor: Colors.grey[400],
      body: Column(children: [
        //search bar
        Padding(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            height: 40,
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none),
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.grey),
            ),
          ),
        ),

        //categories title
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),

        // categories list
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 150,
          child: _categories.isNotEmpty
              ? ListView.builder(
                  itemCount: _categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // Categories category =
                    //     Categories(imagePath: "assets/download.jpeg", title: "Pilot");
                    return GestureDetector(
                      onTap: () {
                        fetchProducts1(_categories[index]["category_id"]);
                      },
                      child: CategoriesList(
                          category_photo: _categories[index]["category_photo"],
                          category_name: _categories[index]["category_name"]),
                    );
                  },
                )
              : Center(
                  child: Text(
                    "Categories not found!",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
        ),

        // product list
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _products.isNotEmpty
                ? ListView.builder(
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: ProductList(
                          product_name: _products[index]["product_name"],
                          price: _products[index]["price"],
                          product_photo: _products[index]["photo"],
                        ),
                        onTap: () {
                          addItem(index);
                          int totalPrice = total_price +=
                              int.parse(_products[index]["price"]);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.purple,
                              content: GestureDetector(
                                child: Text(
                                  totalPrice.toString(),
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrdersList(orders: _cart),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return SizedBox(
                          //       height: 400,
                          //       child: Text("hello"),
                          //     );
                          //   },
                          // );

                          // Future openDialog() => showDialog(
                          //       context: context,
                          //       builder: (context) => AboutDialog(title),
                          //     );
                        },
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "Products not found!",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
          ),
        ),
      ]),
    );
  }
}
