import 'package:flutter/material.dart';
import 'package:hbk_demo/pages/admin/add_category.dart';
import 'package:hbk_demo/pages/admin/admin_category_list.dart';
import 'package:hbk_demo/pages/admin/edit_category.dart';
import 'package:hbk_demo/pages/admin/employee/employee_profile.dart';
import 'package:hbk_demo/pages/admin/products/add_product.dart';
import 'package:hbk_demo/pages/admin/products/show_all_products.dart';
import 'package:hbk_demo/pages/dashboard.dart';
import 'package:hbk_demo/pages/dashboard1.dart';
import 'package:hbk_demo/pages/drawer_menu.dart';
import 'package:hbk_demo/pages/login_page.dart';
import 'package:hbk_demo/pages/ordersList.dart';
import 'package:hbk_demo/pages/registration_page.dart';
import 'package:hbk_demo/pages/splash_screen.dart';
import 'package:hbk_demo/pages/test.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawerMenu(),
      // home: EditCategory(categoryId1: 21,categoryName1: "ppp",categoryPhoto1: "momo.jpeg",),
      theme: ThemeData(primarySwatch: Colors.purple),
      routes: {
        '/login': (context) => LoginPage(),
        //'/dashboard': (context) => Dashboard(),
        '/addCategory': (context) => AddCategory(),
        '/addProduct': (context) => AddProduct(),
        '/dashboard1': (context) => Dashboard1(),
        '/register': (context) => RegistrationPage(),
        //'/orders': (context) => OrdersList(orders: [],)
      },
    );
  }
}
