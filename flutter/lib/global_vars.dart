import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GlobalVars{
  int _idNumber = 0;
  bool _loginStatus = false;
  String? _name;
  String? _email;
  String? _dob;
  int? _yearGroup;
  String? _major;
  bool? _hasResidence = false;
  String? _bestFood;
  String? _bestMovie;

  int get idNumber => _idNumber;
  bool get loginStatus => _loginStatus;
  String? get name => _name;
  String? get email => _email;
  String? get dob => _dob;
  int? get yearGroup => _yearGroup;
  String? get major => _major;
  bool? get hasResidence => _hasResidence;
  String? get bestFood => _bestFood;
  String? get bestMovie => _bestMovie;


  void setState({
    bool loginStatus = false,
    int idNumber = 0,
    String? name,
    String? email,
    String? dob,
    int? yearGroup,
    String? major,
    bool? hasResidence = false,
    String? bestFood,
    String? bestMovie,
  }) {
    if (loginStatus != null) _loginStatus = loginStatus;
    if (idNumber != null) _idNumber = idNumber;
    if (name != null) _name = name;
    if (email != null) _email = email;
    if (dob != null) _dob = dob;
    if (yearGroup != null) _yearGroup = yearGroup;
    if (major != null) _major = major;
    if (hasResidence != null) _hasResidence = hasResidence;
    if (bestFood != null) _bestFood = bestFood;
    if (bestMovie != null) _bestMovie = bestMovie;
  }
}

  final globalVars = GlobalVars();
