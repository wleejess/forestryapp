import 'package:flutter/material.dart';
import 'package:forestryapp/database/dao_landowner.dart';
import "package:forestryapp/enums/us_state.dart";

/// Model class to represent landowners.
///
/// The main purpose of this class is to hold data from the the SQLite database
/// records for the landowners table.
class Landowner extends ChangeNotifier {
  /// Create a model of an landowner.
  ///
  /// When [id] is left null, it is assumed the the model represents an
  /// landowner that is not yet stored in the database.
  Landowner({
    int id = 0,
    String name = '',
    String email = '',
    String address = '',
    String city = '',
    USState? state,
    String zip = '',
  })  : _id = id,
        _name = name,
        _email = email,
        _address = address,
        _city = city,
        _state = state,
        _zip = zip;

  /// Named constructor to convert a database record (which is in the form of a
  /// [Map]) to an instance of of the model class.
  Landowner.fromMap(Map dbRecord)
      : this(
          id: dbRecord[DAOLandowner.colID],
          name: dbRecord[DAOLandowner.colName],
          email: dbRecord[DAOLandowner.colEmail],
          address: dbRecord[DAOLandowner.colAddress],
          city: dbRecord[DAOLandowner.colCity],
          state: USState.fromString(dbRecord[DAOLandowner.colUSState]),
          zip: dbRecord[DAOLandowner.colZip],
        );

  int _id;
  String _name;
  String _email;
  String _address;
  String _city;
  USState? _state;
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

  USState? get state => _state;

  set state(USState? value) {
    _state = value;
    notifyListeners();
  }

  String get zip => _zip;

  set zip(String value) {
    _zip = value;
    notifyListeners();
  }
}
