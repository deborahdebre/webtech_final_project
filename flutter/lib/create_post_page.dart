import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'global_vars.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _postController = TextEditingController();
  String? _userEmail = globalVars.email;
  String? _userName = globalVars.name;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  Future<void> _savePost() async {
    final userId = globalVars.idNumber;
    final collection = FirebaseFirestore.instance.collection('posts');
    await collection.add({
      'userId': userId,
      'email': _userEmail,
      'name': _userName,
      'post': _postController.text,
      'timestamp': Timestamp.now(),
    }).then((_) async {
      final apiEndpoint = Uri.parse('https://webtech-final-project-10.wl.r.appspot.com/posts');
      final response = await http.post(apiEndpoint, headers: {
        "Access-Control-Allow-Origin": "",
        'Content-Type': 'application/json',
        'Accept': '/*'
      }, body: jsonEncode({
        'name': _userName!,
      }));
      if (response.statusCode == 200) {
        final snackBar = SnackBar(
          content: Text('Email notification sent successfully'),
          duration: Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('Failed to send email notification'),
          duration: Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      Navigator.pop(context);
    }).catchError((error) {
      final snackBar = SnackBar(
        content: Text('Failed to save post to database: $error'),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '$_userEmail',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _postController,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: 'What is on your mind?😀',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _savePost,
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blue[900]!),
                foregroundColor:
                MaterialStateProperty.all<Color>(Colors.grey[100]!),
              ),
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
