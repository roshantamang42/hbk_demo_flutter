import 'package:flutter/material.dart';

class EmployeeProfile extends StatelessWidget {
  const EmployeeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset("assets/momo.jpeg"),
            TextFormField(),
            TextField(),
            TextField(),
            TextField(),
            ElevatedButton(onPressed: () {}, child: Text("Save")),
            ElevatedButton(onPressed: () {}, child: Text("Go Back"))
          ],
        ),
      ),
    );
  }
}
