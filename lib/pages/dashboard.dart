import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      backgroundColor: Colors.amber,
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
    );
  }
}
