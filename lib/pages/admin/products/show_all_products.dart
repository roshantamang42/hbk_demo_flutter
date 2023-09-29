import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hbk_demo/components/product_view_component.dart';
import 'package:http/http.dart' as http;

class ShowAllProducts extends StatefulWidget {
  ShowAllProducts({super.key});

  @override
  State<ShowAllProducts> createState() => _ShowAllProductsState();
}

class _ShowAllProductsState extends State<ShowAllProducts> {
  final _products = [];

  Future fetchProducts() async {
    var url = "http://10.0.2.2:90/product/showall";
    var response = await http.get(Uri.parse(url));
    var products = [];

    if (response.statusCode == 200) {
      products = jsonDecode(response.body)["data"];
    }
    return products;
  }

  @override
  void initState() {
    fetchProducts().then((value) {
      setState(() {
        _products.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 40, bottom: 5),
            //   child: Text(
            //     "Products",
            //     style: TextStyle(fontSize: 40),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    return ProductViewComponent(
                      productId: _products[index]["product_id"],
                      productName: _products[index]["product_name"],
                      categoryId: _products[index]["category_id"],
                      price: _products[index]["price"],
                      supplierInfo: _products[index]["description"],
                      productPhoto: _products[index]["photo"],
                      // image: _products[index]["photo"],
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addProduct');
        },
      ),
    );
  }
}
