import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'edit_profile_page.dart';
import 'logout_page.dart';
import 'create_post_page.dart';
import 'feed_page.dart';
import 'global_vars.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  int? idNumber;
  String? name;
  String? email;
  DateTime? dob;
  int? yearGroup;
  String? major;
  bool? hasResidence = false;
  String? bestFood;
  String? bestMovie;
  String? password;
  String? finalpassword;
  bool _obscureTextp = true;
  bool _obscureTextc = true;
  final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  final TextEditingController dateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
          title: Text('Deb Social Media App'),
          backgroundColor: Colors.blue[900],
      ),
         body: SingleChildScrollView(
           padding: EdgeInsets.only(
             top: 80.0,
             bottom: 20.0,
             left: 250.0,
             right: 250.0,
           ),
          child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Container(
          margin: EdgeInsets.only(bottom: 8.0),
            child : TextFormField(
                decoration: InputDecoration(
                  labelText: 'Student ID Number',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  icon: Icon(Icons.account_circle_outlined, color: Colors.blue[900]),
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
                    return 'Please enter your student ID number';
                  } else {
                    int? parsedValue = int.tryParse(value);
                    if (parsedValue == null) {
                      return 'Please enter a valid integer value for your student ID';
                    }
                  }
                  return null;
                },
                onSaved: (value) => idNumber = int.tryParse(value!),
              ),
          ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
              child : TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  icon: Icon(Icons.person_outline, color: Colors.blue[900]),
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
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => name = value,
              ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          child : TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  icon: Icon(Icons.email_outlined, color: Colors.blue[900]),
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
                onSaved: (value) => email = value,
              ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          child :TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  icon: Icon(Icons.calendar_today_outlined, color: Colors.blue[900]),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]!),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today_outlined),
                    onPressed: () async {
                      DateTime? date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());
                      date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      dateController.text = date.toString();
                    },
                  ),
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your date of birth';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    dob = DateTime.parse(value);
                  }
                },
              ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          child : TextFormField(
                decoration: InputDecoration(
                  labelText: 'Year Group',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  icon: Icon(Icons.school_outlined, color: Colors.blue[900]),
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
                return 'Please enter your year group';
              } else {
                int? parsedValue = int.tryParse(value);
                if (parsedValue == null) {
                  return 'Please enter a valid integer value for your year group';
                }
              }
              return null;
            },
            onSaved: (value) => yearGroup = int.tryParse(value!),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          child : TextFormField(
                decoration: InputDecoration(
                  labelText: 'Major',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  icon: Icon(Icons.book_outlined, color: Colors.blue[900]),
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
                    return 'Please enter your major';
                  }
                  return null;
                },
                onSaved: (value) => major = value,
              ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          child : CheckboxListTile(
                title: Text('Do you have campus residence?',style: TextStyle(color: Colors.blue[900]),
                ),
            value: hasResidence,
                onChanged: (value) {
                  setState(() {
                    hasResidence = value;
                  });
                },
            checkColor: Colors.blue[900],
              ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          child : TextFormField(
                decoration: InputDecoration(
                  labelText: 'Best Food',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  icon: Icon(Icons.set_meal, color: Colors.blue[900]),
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
                    return 'Please enter your best food';
                  }
                  return null;
                },
                onSaved: (value) => bestFood = value,
              ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15.0),
          child : TextFormField(
                decoration: InputDecoration(
                  labelText: 'Best Movie',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  icon: Icon(Icons.movie_filter_outlined, color: Colors.blue[900]),
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
                    return 'Please enter your best movie';
                  }
                  return null;
                },
                onSaved: (value) => bestMovie = value,
              ),
        ),
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: passwordController,
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
                        _obscureTextp ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureTextp = !_obscureTextp;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (!passwordRegex.hasMatch(value)) {
                      return 'Password must have at least 8 characters containing at least 1 uppercase letter, 1 lowercase letter, 1 number and 1 special character';
                    }
                    return null;
                  },
                  obscureText: _obscureTextp,
                  onSaved: (value) => password = value!,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
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
                        _obscureTextc ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureTextc = !_obscureTextc;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    } else {
                      return null;
                    }
                  },
                  obscureText: _obscureTextc,
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() == true) {
                      formKey.currentState!.save();
                      final confirmPassword = confirmPasswordController.text;
                      final response = await http.post(
                        Uri.parse('http://127.0.0.1:5000/users'),
                        headers: {
                          "Access-Control-Allow-Origin": "",
                          'Content-Type': 'application/json',
                          'Accept': '/*'
                        },
                        body: jsonEncode({
                          'idNumber': idNumber,
                          'name': name,
                          'email': email,
                          'dob': dob?.toIso8601String(),
                          'yearGroup': yearGroup,
                          'major': major,
                          'hasResidence': hasResidence,
                          'bestFood': bestFood,
                          'bestMovie': bestMovie,
                          'password' :confirmPassword,
                        }),
                      );
                      final jsonResponse = json.decode(response.body)['message'];
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(jsonEncode(jsonResponse)),
                          duration: Duration(seconds: 10),
                        ));
                      });
                      if (response.statusCode == 200){
                        globalVars.setState(loginStatus: true, idNumber: jsonDecode(response.body)['idNumber']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:(context)=>Dashboard(),
                    ),
                          );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                  ),
                  child: Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}