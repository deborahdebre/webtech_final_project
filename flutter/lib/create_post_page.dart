import 'package:flutter/material.dart';

class CreatePostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Text('This is the Create Post Page'),
      ),
    );
  }
}
