import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  late int employeeId1;
  late String firstName1;
  late String lastName1;
  late String email;
  late String address1;
  late String mobile1;
  late String password1;

  String? _mySelection;
  File? pickedFile;

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();

  Future _openGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      print(image.path);
      setState(() {
        pickedFile = File(image.path);
      });
    } else {
      print("No image selected");
    }
  }

  Future addEmployee() async {
    try {
      //Dio dio = Dio();

      // String fileName = pickedFile!.path.split('/').last;

      // FormData formData = FormData.fromMap(
      //   {
      //     "full_name": firstNameController.text,
      //     "email": emailController.text,
      //     "address": addressController.text,
      //     "mobile": mobileController.text,
      //     "password": passwordController.text,
      //     "image": await MultipartFile.fromFile(pickedFile!.path,
      //         filename: fileName, contentType: MediaType("image", "jpg")),
      //     "type": "image/jpg"
      //   },
      // );
      // Response response = await dio.post("http://10.0.2.2:90/employee/add",
      //     data: formData,
      //     options: Options(headers: {
      //       "accept": "*/*",
      //       "Authorization": "",
      //       "Content-Type": "multipart/form-data"
      //     }));

      var employee = jsonEncode({
        "full_name": firstNameController.text,
        "email": emailController.text,
        "address": addressController.text,
        "mobile": mobileController.text,
        //"password": passwordController.text
      });

      var response = await http.put(
          Uri.parse("http://10.0.2.2:90/employee/add"),
          headers: {"Content-Type": "application/json"},
          body: employee);

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        print("Employee added successfully!");
      } else {
        print("Failed to add employee!");
      }
    } catch (e) {
      print(e);

      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 38.0, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: Text("Add Employee",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 120,
                        backgroundImage: AssetImage("assets/noimg.jpg"),
                        //child: Image.asset("assets/momo.jpeg")),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 25,
                          child: GestureDetector(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                            ),
                            onTap: () {
                              _openGallery();
                            },
                          ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 190,
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                            constraints: BoxConstraints(),
                            hintText: "First Name"),
                      ),
                    ),
                    SizedBox(
                      width: 190,
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(hintText: "Last Name"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(hintText: "Address"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(hintText: "Mobile"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(hintText: "Password"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Joined Date :",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              "2012-12-12",
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.calendar_month_outlined,
                                  size: 20,
                                ),
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2020, 1, 1),
                                      firstDate: DateTime(1999, 12, 30),
                                      lastDate: DateTime(2099, 12, 30));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "End Date :",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 46.0),
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              "2012-12-12",
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: GestureDetector(
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.calendar_month_outlined,
                                    size: 20,
                                  ),
                                ),
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2020, 1, 1),
                                      firstDate: DateTime(1999, 12, 30),
                                      lastDate: DateTime(2099, 12, 30));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      addEmployee();
                    },
                    child: Text("Save")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Go Back")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
