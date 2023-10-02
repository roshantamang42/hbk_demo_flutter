import 'package:flutter/material.dart';

class EditEmployee extends StatefulWidget {
  const EditEmployee({super.key});

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 10),
              child: Text("Edit Employee",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 120, backgroundImage: AssetImage("assets/momo.jpeg"),
                //child: Image.asset("assets/momo.jpeg")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {}, child: Text("Save")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {}, child: Text("Go Back")),
            )
          ],
        ),
      ),
    );
    ;
  }
}
