import 'package:flutter/material.dart';
import 'package:hbk_demo/components/category.dart';
import 'package:hbk_demo/pages/admin/admin_category_list.dart';
import 'package:hbk_demo/pages/admin/employee/show_employee.dart';
import 'package:hbk_demo/pages/admin/products/show_all_products.dart';
import 'package:hbk_demo/pages/dashboard.dart';
import 'package:hbk_demo/pages/dashboard1.dart';
import 'package:hbk_demo/pages/products.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Home",
          baseStyle: TextStyle(color: Colors.white, fontSize: 20),
          selectedStyle: TextStyle(),
        ),
        Dashboard1(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Categories",
          baseStyle: TextStyle(color: Colors.white, fontSize: 20),
          selectedStyle: TextStyle(),
        ),
        AdminCategoriesList(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Products",
          baseStyle: TextStyle(color: Colors.white, fontSize: 20),
          selectedStyle: TextStyle(),
        ),
        ShowAllProducts(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Employees",
          baseStyle: TextStyle(color: Colors.white, fontSize: 20),
          selectedStyle: TextStyle(),
        ),
        ShowEmployee(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Color.fromARGB(255, 123, 14, 142),
      screens: _pages,
      initPositionSelected: 0,
    );
  }
}
