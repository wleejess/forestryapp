import 'package:flutter/material.dart';
import "package:forestryapp/enums/slope_position.dart";
import "package:forestryapp/enums/direction.dart";

class SiteCharDataModel extends ChangeNotifier {
  String _elevation = '';
  SlopePosition _slopePosition = SlopePosition.lower;
  Direction _aspect = Direction.north;
  String _percentSlope = '';
  String _soilInfo = '';

  SlopePosition get slopePosition => _slopePosition;

  set slopePosition(SlopePosition value) {
    _slopePosition = value;
    notifyListeners();
  }

  String get elevation => _elevation;

  set elevation(String value) {
    _elevation = value;
    notifyListeners();
  }

  Direction get aspect => _aspect;

  set aspect(Direction value) {
    _aspect = value;
    notifyListeners();
  }

  String get percentSlope => _percentSlope;

  set percentSlope(String value) {
    _percentSlope = value;
    notifyListeners();
  }

  String get soilInfo => _soilInfo;

  set soilInfo(String value) {
    _soilInfo = value;
    notifyListeners();
  }
}
