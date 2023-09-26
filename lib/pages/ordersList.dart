// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'orders.dart';

class OrdersList extends StatelessWidget {
  var orders = [];

  OrdersList({required this.orders});
  //OrderList({required this.orders});
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 300,
    //   width: 300,
    //   color: Colors.white,
    //   child: Text(orders[0]["product_name"]),
    // );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Orders(
              product_name: orders[index]["product_name"],
              price: orders[index]["price"],
              product_photo: orders[index]["photo"],
            );
          }),
    );
  }
}
