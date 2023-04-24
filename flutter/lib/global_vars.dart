import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GlobalVars extends ChangeNotifier {
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


  Future<void> _fetchUserData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .where('idNumber', isEqualTo: _idNumber)
          .get();
      if (snapshot.size > 0) {
        final data = snapshot.docs[0].data();
        _name = data['name'];
        _email = data['email'];
        _dob = data['dob'];
        _yearGroup = data['yearGroup'];
        _major = data['major'];
        _hasResidence = data['hasResidence'];
        _bestFood = data['bestFood'];
        _bestMovie = data['bestMovie'];
        print('Data fetch complete');
      } else {
        print('User data not found for idNumber $_idNumber');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  void _clearUserData() {
    _name = null;
    _email = null;
    _dob = null;
    _yearGroup = null;
    _major = null;
    _hasResidence = null;
    _bestFood = null;
    _bestMovie = null;
  }

  void setState({bool loginStatus = false, int idNumber = 0}) {
    _loginStatus = loginStatus;
    _idNumber = idNumber;
    if (loginStatus) {
      if (loginStatus) {
        print('Fetching user data for ID $_idNumber...');
        _fetchUserData();
      } else {
        _clearUserData();
      }
      notifyListeners();
    }

}
}

final globalVars = GlobalVars();
