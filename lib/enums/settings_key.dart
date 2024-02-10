/// Enum to use for key-value pairs for settings stored in `SharedPreferences`.
///
/// As `SharedPreference` keys are always strings, each member will return a
/// `String`.
enum SettingsKey {
  // When adding more settings members, their string keys MUST be unique.
  _evaluatorName("Evaluator Name"),
  _evaluatorEmail("Evaluator Email"),
  _evaluatorAddress("Evaluator Address"),
  _evaluatorCity("Evaluator City"),
  _evaluatorZip("Evaluator Zip Code"),
  _fontSize("Font Size");

  const SettingsKey(this.key);

  final String key;

  static String get evaluatorName => SettingsKey._evaluatorName.key;
  static String get evaluatorEmail => SettingsKey._evaluatorEmail.key;
  static String get evaluatorAddress => SettingsKey._evaluatorAddress.key;
  static String get evaluatorCity => SettingsKey._evaluatorCity.key;
  static String get evaluatorZip => SettingsKey._evaluatorZip.key;
  static String get fontSize => SettingsKey._fontSize.key;
}
