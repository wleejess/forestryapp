/// Callback functions to provide form validation error messages.
class Validation {
  /// Returns an error message if no value was entered.
  static String? isNotEmpty(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a response.';
    }
    return null;
  }

  /// Returns an error message if the value is not a percentage (0-100 integer).
  /// Accepts empty values.
  static String? isValidPercentage(value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    int? number = int.tryParse(value);

    if (number != null && number >= 0 && number <= 100) {
      return null;
    }
    return 'Please enter a valid percentage.';
  }

  /// Returns an error message if the value is not an integer -5000 to 50000.
  /// Accepts empty values.
  static String? isValidElevation(value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    int? number = int.tryParse(value);

    if (number != null && number >= -5000 && number <= 50000) {
      return null;
    }
    return 'Please enter an elevation from -5000 to 50000.';
  }
}