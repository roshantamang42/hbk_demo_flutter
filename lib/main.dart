import 'package:flutter/material.dart';
import 'package:hbk_demo/pages/dashboard.dart';
import 'package:hbk_demo/pages/dashboard1.dart';
import 'package:hbk_demo/pages/login_page.dart';
import 'package:hbk_demo/pages/ordersList.dart';
import 'package:hbk_demo/pages/registration_page.dart';
import 'package:hbk_demo/pages/splash_screen.dart';
import 'package:hbk_demo/pages/test.dart';

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
      home: Dashboard1(),
      theme: ThemeData(primarySwatch: Colors.purple),
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => Dashboard(),
        '/dashboard1': (context) => Dashboard1(),
        '/register': (context) => RegistrationPage(),
        //'/orders': (context) => OrdersList(orders: [],)
      },
    );
  }
}
