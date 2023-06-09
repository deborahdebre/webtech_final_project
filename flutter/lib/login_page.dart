import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'edit_profile_page.dart';
import 'logout_page.dart';
import 'create_post_page.dart';
import 'feed_page.dart';
import 'global_vars.dart';
import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding:  EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Kindly login into your account ',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 150,
                  width: 150,
                  child: Icon(
                    Icons.person,
                    color: Colors.blue[900],
                    size: 100,
                  ),
                ),
              ),

              // Added SizedBox for spacing
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.blue[900]),
                    icon: Icon(Icons.email, color: Colors.blue[900]),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[900]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[900]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[900]!),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.blue[900]),
                    icon: Icon(Icons.lock_outline, color: Colors.blue[900]),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[900]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[900]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[900]!),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                  onSaved: (value) => _password = value!,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Send login request to the server
                    final response = await http.post(
                      Uri.parse('https://webtech-final-project-10.wl.r.appspot.com/login'),
                      headers: {
                        "Access-Control-Allow-Origin": "",
                        'Content-Type': 'application/json',
                        'Accept': '/*'
                      },
                      body: jsonEncode({
                        'email': _email,
                        'password': _password,
                      }),
                    );
                    if (response.statusCode == 200) {
                      final Map<String, dynamic> userData = jsonDecode(response.body)['user_details'];
                      globalVars.setState(
                        loginStatus: true,
                        idNumber: userData['idNumber'],
                        name: userData['name'],
                        email: userData['email'],
                        dob: userData['dob'],
                        yearGroup: userData['yearGroup'],
                        major: userData['major'],
                        hasResidence: userData['hasResidence'],
                        bestFood: userData['bestFood'],
                        bestMovie: userData['bestMovie'],
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:(context)=>Dashboard(),
                        ),
                      );
                    }

                    else {
                      final jsonResponse = json.decode(
                          response.body)['message'];
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(jsonEncode(jsonResponse)),
                          backgroundColor: Colors.red[900],
                          duration: Duration(seconds: 10),
                        ));
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  minimumSize: Size(120, 50),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
