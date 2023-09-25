import 'dart:math';

import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Color.fromARGB(255, 199, 199, 199),
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 199, 199, 199),
      drawer: Drawer(
        backgroundColor: Colors.purple,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 80, horizontal: 10),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text("H o m e"),
              ),
              ListTile(
                leading: Icon(Icons.chat_rounded),
                title: Text("C a t a g o r i e s"),
              ),
              ListTile(
                leading: Icon(Icons.card_giftcard),
                title: Text("U s e r s"),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("P r o f i l e"),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                height: 40,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none),
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Icon(
                            Icons.home,
                            size: 60,
                            color: Colors.black,
                          ),
                          Text("Tobaccoo", style: TextStyle(fontSize: 15))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.add_to_home_screen_sharp,
                            size: 60,
                            color: Colors.black,
                          ),
                          Text("Drinks", style: TextStyle(fontSize: 15))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.account_balance,
                            size: 60,
                            color: Colors.black,
                          ),
                          Text("Food", style: TextStyle(fontSize: 15))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.access_alarm_rounded,
                            size: 60,
                            color: Colors.black,
                          ),
                          Text("Snacks", style: TextStyle(fontSize: 15))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.home,
                              size: 70,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Pilot",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "Price: Rs. 10 / 2 pc",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              Text(
                                "Stock: 10pkts",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.home,
                              size: 70,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Pilot",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "Price: Rs. 10 / 2 pc",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              Text(
                                "Stock: 10pkts",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.home,
                              size: 70,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Pilot",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "Price: Rs. 10 / 2 pc",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              Text(
                                "Stock: 10pkts",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.home,
                              size: 70,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Pilot",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "Price: Rs. 10 / 2 pc",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              Text(
                                "Stock: 10pkts",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.home,
                              size: 70,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Pilot",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "Price: Rs. 10 / 2 pc",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              Text(
                                "Stock: 10pkts",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.home,
                              size: 70,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Pilot",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "Price: Rs. 10 / 2 pc",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              Text(
                                "Stock: 10pkts",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.home,
                              size: 70,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Pilot",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "Price: Rs. 10 / 2 pc",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              Text(
                                "Stock: 10pkts",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.home,
                              size: 70,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Pilot",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "Price: Rs. 10 / 2 pc",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              Text(
                                "Stock: 10pkts",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.home,
                              size: 70,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Pilot",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "Price: Rs. 10 / 2 pc",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              Text(
                                "Stock: 10pkts",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.home,
                              size: 70,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Pilot",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "Price: Rs. 10 / 2 pc",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              Text(
                                "Stock: 10pkts",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
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
