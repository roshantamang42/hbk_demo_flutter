import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:http/http.dart' as http;

class EditEmployee extends StatefulWidget {
  late int employeeId;
  late String firstName;
  late String lastName;
  late String email;
  late String address;
  late String mobile;
  late String password;

  EditEmployee(
      {super.key,
      required this.employeeId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.address,
      required this.mobile,
      required this.password});

  @override
  State<EditEmployee> createState() => _EditEmployeeState(
      employeeId1: employeeId,
      firstName1: firstName,
      lastName1: lastName,
      email: email,
      address1: address,
      password1: password,
      mobile1: mobile);
}

class _EditEmployeeState extends State<EditEmployee> {
  late int employeeId1;
  late String firstName1;
  late String lastName1;
  late String email;
  late String address1;
  late String mobile1;
  late String password1;

  _EditEmployeeState({
    required this.employeeId1,
    required this.firstName1,
    required this.lastName1,
    required this.email,
    required this.address1,
    required this.password1,
    required this.mobile1,
  });

  List _employee = [];
  String? _mySelection;
  File? pickedFile;

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();

  getCurrentDate() {
    //return DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future _openGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        pickedFile = File(image.path);
      });
    } else {
      print("No image selected");
    }
  }

  Future editEmployee() async {
    Dio dio = Dio();
    try {
      //if both file and name are present
      if (pickedFile != null) {
        String fileName = pickedFile!.path.split('/').last;
        FormData formData = FormData.fromMap(
          {
            "full_name": firstNameController.text,
            "email": emailController.text,
            "address": addressController.text,
            "mobile": mobileController.text,
            "password": passwordController.text,
            "image": await MultipartFile.fromFile(pickedFile!.path,
                filename: fileName, contentType: MediaType("image", "jpg")),
            "type": "image/jpg"
          },
        );

        Response response = await dio.put(
            "http://10.0.2.2:90/employee/update/$employeeId1",
            data: formData,
            options: Options(headers: {
              "accept": "*/*",
              "Authorization": "",
              "Content-Type": "multipart/form-data"
            }));

        if (response.statusCode == 200) {
          print("Employee updated successfully with photo!");
          Navigator.of(context).pop();
        } else {
          print("Failed to update employee!");
        }

        // if file is not selected
      } else {
        // setState(() {
        //   productName1 = productNameController.text.toString();

        // });

        var employee = jsonEncode({
          "full_name": firstNameController.text,
          "email": emailController.text,
          "address": addressController.text,
          "mobile": mobileController.text,
          "password": passwordController.text
        });

        var response = await http.put(
            Uri.parse("http://10.0.2.2:90/employee/update1/$employeeId1"),
            headers: {"Content-Type": "application/json"},
            body: employee);

        if (response.statusCode == 200) {
          print("updated without photo");
          Navigator.of(context).pop();
        } else {
          print("Unable to Update");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Future fetchEmployee() async {
  //   var url = "http://10.0.2.2:90/employee/show/$employeeId";
  //   var response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _mySelection = jsonDecode(response.body)["data"][0]["category_name"];
  //     });
  //   }
  // }

  @override
  void initState() {
    //fetchEmployee();
    firstNameController.text = firstName1;
    lastNameController.text = lastName1;
    emailController.text = email;
    addressController.text = address1;
    mobileController.text = mobile1;
    passwordController.text = password1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 38.0, bottom: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text("Edit Employee",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: GestureDetector(
                          onTap: _openGallery,
                          child: Stack(
                            children: [
                              Container(
                                child: pickedFile != null
                                    ? Image.file(
                                        File(pickedFile!.path),
                                      )
                                    : Image.asset(
                                        "assets/noimg.jpg",
                                      ),

                                height: 250,
                                width: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(125),
                                  //shape: BoxShape.circle,
                                ),

                                //child: Image.asset("assets/momo.jpeg")),
                              ),
                              // CircleAvatar(
                              //   radius: 120,
                              //   backgroundImage: AssetImage("assets/noimg.jpg"),
                              //   //child: Image.asset("assets/momo.jpeg")),
                              // ),
                              Positioned(
                                  bottom: 5,
                                  right: 25,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 40,
                                  ))
                            ],
                          ),
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
                              decoration:
                                  InputDecoration(hintText: "Last Name"),
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
                                        // showModalBottomSheet(
                                        //     context: context,
                                        //     builder: (context) {
                                        //       return SizedBox(
                                        //           height: 400,
                                        //           child: CupertinoDatePicker(
                                        //               mode: CupertinoDatePickerMode
                                        //                   .date,
                                        //               initialDateTime:
                                        //                   DateTime(1969, 1, 1),
                                        //               onDateTimeChanged:
                                        //                   (DateTime newDateTime) {
                                        //                 print(newDateTime);
                                        //               }));
                                        //     });

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
                            editEmployee();
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
          ],
        ),
      ),
    );
  }
}
