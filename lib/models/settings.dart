import 'package:forestryapp/enums/settings_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Class to interact with settings stored in SharedPreferences.
class Settings {
  // Static Variables //////////////////////////////////////////////////////////
  static const double defaultFontSize = 100;
  static const double minFontSize = 0;
  static const double maxFontSize = 400;

  // Instance Variables ////////////////////////////////////////////////////////
  final SharedPreferences _sharedPreferences;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Create Settings object to read/write from [sharedPreferences].
  Settings(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  // Getters ///////////////////////////////////////////////////////////////////
  double get fontSize {
    return _sharedPreferences.getDouble(SettingsKey.fontSize) ??
        Settings.defaultFontSize;
  }

  // Setters ///////////////////////////////////////////////////////////////////
  set fontSize(double newFontSize) {
    _sharedPreferences.setDouble(SettingsKey.fontSize, newFontSize);
  }
}
