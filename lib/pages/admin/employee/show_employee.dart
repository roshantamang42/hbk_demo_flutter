import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hbk_demo/pages/admin/employee/employee_component.dart';
import 'package:http/http.dart' as http;

class ShowEmployee extends StatefulWidget {
  const ShowEmployee({super.key});

  @override
  State<ShowEmployee> createState() => _ShowEmployeeState();
}

class _ShowEmployeeState extends State<ShowEmployee> {
  final _employees = [];

  Future fetchProducts() async {
    var url = "http://10.0.2.2:90/employee/showall";
    var response = await http.get(Uri.parse(url));
    var employees = [];

    if (response.statusCode == 200) {
      employees = jsonDecode(response.body)["data"];
    }
    return employees;
  }

  @override
  void initState() {
    fetchProducts().then((value) {
      setState(() {
        _employees.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Title

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Employee",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              //employee id
              Text(
                "EmpID",
                style: (TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),

              Spacer(
                flex: 1,
              ),

              //Name
              Text(
                "Name",
                style: (TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),

              Spacer(flex: 3),

              //number
              Text(
                "Contact",
                style: (TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              Spacer(flex: 3),
              //icons
              FilledButton(onPressed: () {}, child: Text("Add"))
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: _employees.length,
                itemBuilder: (context, index) {
                  return EmployeeComponent(
                    empId: _employees[index]["id"],
                    empName: _employees[index]["full_name"],
                    mobile: _employees[index]["mobile"],
                  );
                }),
          ),
        )
      ],
    );
  }
}
