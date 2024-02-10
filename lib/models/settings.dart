import 'package:forestryapp/enums/settings_key.dart';
import 'package:forestryapp/enums/us_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Class to interact with settings stored in SharedPreferences.
class Settings {
  // Static Variables //////////////////////////////////////////////////////////
  static const double defaultFontSize = 100;
  static const double minFontSize = 0;
  static const double maxFontSize = 400;

  static const String _defaultStringFallback = "";

  // Instance Variables ////////////////////////////////////////////////////////
  final SharedPreferences _sharedPreferences;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Create Settings object to read/write from [sharedPreferences].
  Settings(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  // Getters ///////////////////////////////////////////////////////////////////
  String get evaluatorName => readSetting(SettingsKey.evaluatorName);
  String get evaluatorEmail => readSetting(SettingsKey.evaluatorEmail);
  String get evaluatorAddress => readSetting(SettingsKey.evaluatorAddress);
  String get evaluatorCity => readSetting(SettingsKey.evaluatorCity);
  String get evaluatorZip => readSetting(SettingsKey.evaluatorZip);

  /// Either an `enum` of USState or `null`, corresponding to case where
  /// evaluator has not yet picked a dropdown selection (i.e. fresh install).
  USState? get evaluatorUSState {
    final String storedUSState = readSetting(SettingsKey.evaluatorUSState);

    for (var usState in USState.values) {
      if (usState.label == storedUSState) return usState;
    }

    return null;
  }

  String get evaluatorUSStateString {
    USState? usState = evaluatorUSState;
    return usState == null
        ? _defaultStringFallback
        : usState.label.toUpperCase();
  }

  String get combinedAddress {
    return "$evaluatorAddress $evaluatorCity, $evaluatorUSStateString $evaluatorZip";
  }

  double get fontSize {
    return _sharedPreferences.getDouble(SettingsKey.fontSize) ??
        Settings.defaultFontSize;
  }

  // Setters ///////////////////////////////////////////////////////////////////
  set evaluatorName(String name) =>
      _sharedPreferences.setString(SettingsKey.evaluatorName, name);

  set evaluatorEmail(String email) =>
      _sharedPreferences.setString(SettingsKey.evaluatorEmail, email);

  set evaluatorAddress(String address) =>
      _sharedPreferences.setString(SettingsKey.evaluatorAddress, address);

  set evaluatorCity(String city) =>
      _sharedPreferences.setString(SettingsKey.evaluatorCity, city);

  set evaluatorZip(String zip) =>
      _sharedPreferences.setString(SettingsKey.evaluatorZip, zip);

  set evaluatorUSState(USState? usState) {
    String label =
        (usState != null) ? usState.label : Settings._defaultStringFallback;
    _sharedPreferences.setString(SettingsKey.evaluatorUSState, label);
  }

  set fontSize(double newFontSize) {
    _sharedPreferences.setDouble(SettingsKey.fontSize, newFontSize);
  }

  // Reading From Storage //////////////////////////////////////////////////////
  String readSetting(String settingsKey,
          {String fallback = Settings._defaultStringFallback}) =>
      _sharedPreferences.getString(settingsKey) ?? fallback;
}
