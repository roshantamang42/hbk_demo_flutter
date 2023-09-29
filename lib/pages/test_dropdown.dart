import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  List _categories = [
    {
      "product_id": 2,
      "product_name": "momo",
      "description": "111",
      "price": "123",
      "category_id": 22,
      "photo": "momo.jpeg"
    },
    {
      "product_id": 3,
      "product_name": "momo",
      "description": "momomomomomomo",
      "price": "200",
      "category_id": 22,
      "photo": "zoro.jpeg"
    },
    {
      "product_id": 5,
      "product_name": "cok1",
      "description": "123",
      "price": "333",
      "category_id": 21,
      "photo": "coffee.jpeg"
    }
  ];
  late String _mySelection;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        value: _mySelection,
        iconSize: 30,
        icon: (null),
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
        hint: Text('Select State'),
        onChanged: (String? value) {
          setState(() {
            _mySelection = value!;
          });
        },
        items: _categories.map((item) {
          return new DropdownMenuItem(
            child: new Text(item['name']),
            value: item['id'].toString(),
          );
        }).toList(),
      ),
    );
  }
}
