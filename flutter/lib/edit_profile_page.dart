import 'package:final_proj_14/view_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'global_vars.dart';

class EditProfilePage extends StatefulWidget {
  final String idNumber;
  final String name;
  final String email;
  final String dob;
  final int? yearGroup;
  final String major;
  final bool? hasResidence;
  final String bestFood;
  final String bestMovie;

  EditProfilePage({
    required this.idNumber,
    required this.name,
    required this.email,
    required this.dob,
    required this.yearGroup,
    required this.major,
    required this.hasResidence,
    required this.bestFood,
    required this.bestMovie,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String _dob;
  late int _yearGroup;
  late String _major;
  late bool? _hasResidence;
  late String _bestFood;
  late String _bestMovie;
  late String _password = '';
  late String confirmPassword = '';
  final passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  final TextEditingController dateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool passwordChanged = false;

  @override
  void initState() {
    _dob = widget.dob;
    _yearGroup = widget.yearGroup!;
    _major = widget.major;
    _hasResidence = widget.hasResidence;
    _bestFood = widget.bestFood;
    _bestMovie = widget.bestMovie;
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      dateController.text = _dob;
      passwordController.text = _password;
      confirmPasswordController.text = confirmPassword;
    });
  }

  Future<void> _submitForm() async {

    if (passwordController.text != _password && passwordChanged) {
      _password = passwordController.text;
    }
    if (_formKey.currentState!.validate()) {
      final response = await http.put(
        Uri.parse('https://webtech-final-project-10.wl.r.appspot.com/users/${widget.idNumber}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'dob': _dob,
          'yearGroup': _yearGroup,
          'major': _major,
          'hasResidence': _hasResidence,
          'bestFood': _bestFood,
          'bestMovie': _bestMovie,
          'password': _password,
          'idNumber': widget.idNumber,
        }),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')));
        globalVars.setState(
          loginStatus: true,
          idNumber: int.parse(widget.idNumber),
          name: widget.name,
          email: widget.email,
          dob: _dob,
          yearGroup: _yearGroup,
          major: _major,
          hasResidence: _hasResidence,
          bestFood: _bestFood,
          bestMovie: widget.bestMovie,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewProfilePage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID Number: ${widget.idNumber}',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Name: ${widget.name}',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Email: ${widget.email}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  hintText: 'YYYY-MM-DD',
                ),
                onChanged: (value) {
                  _dob = value;
                },
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    dateController.text = date.toString().substring(0, 10);
                    _dob = date.toString().substring(0, 10);
                  }
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _yearGroup.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Year Group',
                  hintText: 'Enter your year group',
                ),
                onChanged: (value) {
                  _yearGroup = int.parse(value);
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _major,
                decoration: InputDecoration(
                  labelText: 'Major',
                  hintText: 'Enter your major',
                ),
                onChanged: (value) {
                  _major = value;
                },
              ),
              SizedBox(height: 16.0),
              CheckboxListTile(
                title: Text('Do you have on-campus residence?'),
                value: _hasResidence,
                onChanged: (value) {
                  setState(() {
                    _hasResidence = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _bestFood,
                decoration: InputDecoration(
                  labelText: 'Best Food',
                  hintText: 'Enter your favorite food',
                ),
                onChanged: (value) {
                  _bestFood = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _bestMovie,
                decoration: InputDecoration(
                  labelText: 'Best Movie',
                  hintText: 'Enter your favorite movie',
                ),
                onChanged: (value) {
                  _bestMovie = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons
                          .visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value?.isNotEmpty == true && !passwordRegex.hasMatch(value!)) {
                    return 'Password must be at least 8 characters long and contain at least 1 uppercase letter, 1 lowercase letter, 1 number and 1 special character';
                  }
                },
                obscureText: _obscurePassword,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons
                          .visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value?.isNotEmpty == true && value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  passwordChanged = true;
                },
                obscureText: _obscureConfirmPassword,
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                  ),
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitForm();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
