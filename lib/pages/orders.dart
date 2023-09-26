import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  late String product_name;
  late String price;
  late String product_photo;

  Orders(
      {required this.product_name,
      required this.price,
      required this.product_photo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network("http://10.0.2.2:90/files/" + product_photo),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product_name,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Price: Rs. " + price,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        "Stock: 2 pkts",
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Icon(
              Icons.add,
              size: 30,
            ),
          ],
        ),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
    ;
  }
}
