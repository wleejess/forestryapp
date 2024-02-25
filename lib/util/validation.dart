class Validation {
  static String? isNotEmpty(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a response.';
    }
    return null;
  }

  static String? isValidPercentage(value) {
    if (value != null && value.isNotEmpty) {
      int? number = int.tryParse(value);

      if (number != null && number >= 0 && number <= 100) {
        return null;
      }
    }
    return 'Please enter a valid percentage.';
  }

  static String? isValidElevation(value) {
    if (value != null && value.isNotEmpty) {
      int? number = int.tryParse(value);

      if (number != null && number >= -5000 && number <= 50000) {
        return null;
      }
    }
    return 'Please enter an elevation from -5000 to 50000.';
  }
}