import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Text('This is the Logout Page'),
      ),
    );
  }
}
