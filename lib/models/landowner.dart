import 'package:flutter/material.dart';
import "package:forestryapp/enums/us_state.dart";

class Landowner extends ChangeNotifier {
  Landowner({
    id = 0,
    name = '',
    email = '',
    address = '',
    city = '',
    state = USState.alabama,
    zip = '',
  }) : _id = id,
      _name = name,
      _email = email,
      _address = address,
      _city = city,
      _state = state,
      _zip = zip;

  int _id;
  String _name;
  String _email;
  String _address;
  String _city;
  USState _state;
  String _zip;

  int get id => _id;

  set id(int value) {
    _id = value;
    notifyListeners();
  }

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get address => _address;

  set address(String value) {
    _address = value;
    notifyListeners();
  }

  String get city => _city;

  set city(String value) {
    _city = value;
    notifyListeners();
  }

  USState get state => _state;

  set state(USState value) {
    _state = value;
    notifyListeners();
  }

  String get zip => _zip;

  set zip(String value) {
    _zip = value;
    notifyListeners();
  }
}
