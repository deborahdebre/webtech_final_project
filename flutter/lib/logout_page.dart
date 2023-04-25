import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'global_vars.dart';
import 'startup_page.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globalVars.setState(
      loginStatus: false,
      idNumber: 0,
      name: null,
      email: null,
      dob: null,
      yearGroup: null,
      major: null,
      hasResidence: false,
      bestFood: null,
      bestMovie: null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Text('You have been logged out.',
        style: TextStyle(
          fontSize: 30,
          color: Colors.blue[900],
          fontWeight: FontWeight.bold,
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StartupPage()),
          );
        },
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.arrow_back),
      ),

    );
  }
}
