import 'package:flutter/material.dart';
import 'package:hbk_demo/pages/admin/employee/edit_employee.dart';
import 'package:http/http.dart' as http;

class EmployeeComponent extends StatelessWidget {
  late int empId;
  late String empName;
  late String mobile;
  late String email;
  late String password;
  late String address;

  EmployeeComponent(
      {super.key,
      required this.empId,
      required this.empName,
      required this.mobile,
      required this.address,
      required this.email,
      required this.password});

  void deleteEmployee(int empId) async {
    try {
      var url = "http://10.0.2.2:90/employee/delete/$empId";

      var response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        print("Employee deleted");
      } else {
        print("cannot delete employee");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //employee id
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: 70,
                child: Text(
                  empId.toString(),
                  style: (TextStyle(fontSize: 15)),
                ),
              ),
            ),

            //Name
            Container(
              width: 90,
              child: Text(
                empName,
                style: (TextStyle(fontSize: 15)),
              ),
            ),

            //number
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: 100,
                child: Text(
                  mobile,
                  style: (TextStyle(fontSize: 15)),
                ),
              ),
            ),

            //icons
            Container(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditEmployee(
                            employeeId: empId,
                            firstName: empName,
                            lastName: "last static",
                            email: email,
                            address: address,
                            mobile: mobile,
                            password: password,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(Icons.edit),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Delete"),
                                  content:
                                      Text("Are you sure you want to delete?"),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            deleteEmployee(empId);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("OK"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel"),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              });
                        },
                        child: Icon(Icons.delete_outlined)),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.black,
          thickness: 1,
        )
      ],
    );
  }
}
