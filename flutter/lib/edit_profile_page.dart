import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Text('This is the Edit Profile page'),
      ),
    );
  }
}
