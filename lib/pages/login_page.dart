import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email_controller = TextEditingController();
  var password_controller = TextEditingController();

  //final url = 'http://10.0.2.2:90/login/admin';

  String email = "";
  String password = "";

  void login() async {
    setState(() {
      email = email_controller.text;
      password = password_controller.text;
    });

    var user = jsonEncode({"email": email, "password": password});

    try {
      Response response = await post(
          Uri.parse("http://10.0.2.2:90/login/admin"),
          headers: {"Content-Type": "application/json"},
          body: user);

      if (response.statusCode == 200) {
        var parsed = jsonDecode(response.body);
        print(parsed["token"]);
        Navigator.pushNamed(context, "/dashboard1");
      } else {
        print("login failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Text("Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: email_controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: password_controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Password",
              ),
            ),
          ),

          // login button
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  login();
                },
                child: Text("Log In"),
              ),
            ),
          ),

          // Center(
          //     child: Padding(
          //   padding: EdgeInsets.all(10),
          //   child: Text(
          //     "Don't have an account? Register now!",
          //     style: TextStyle(color: Colors.black),
          //   ),
          // )),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Powered by Going Genius Group Of Companies",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "www.goinggenius.com.np",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
