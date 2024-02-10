import 'package:shared_preferences/shared_preferences.dart';

/// Class to interact with settings stored in SharedPreferences.
class Settings {

  // Instance Variables ////////////////////////////////////////////////////////
  // ignore: unused_field
  final SharedPreferences _sharedPreferences;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Create Settings object to read/write from [sharedPreferences].
  Settings(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;
}
