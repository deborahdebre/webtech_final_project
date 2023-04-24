import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Text('This is the Feed Page'),
      ),
    );
  }
}
