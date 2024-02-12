import 'package:flutter/material.dart';

class Styles {
  static final _colorScheme = ColorScheme.fromSeed(seedColor: Colors.green);

  static final _appBarTheme = AppBarTheme(
    backgroundColor: _colorScheme.primaryContainer,
    foregroundColor: _colorScheme.onPrimaryContainer,
  );

  static const _inputDecorationTheme = InputDecorationTheme(
      labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      helperStyle: TextStyle(fontSize: 14.0),
      helperMaxLines: 5);

  static final _snackbarTheme = SnackBarThemeData(
    backgroundColor: _colorScheme.secondaryContainer,
    contentTextStyle:
        TextStyle(fontSize: 32, color: _colorScheme.onSecondaryContainer),
  );

  static ThemeData makeTheme() {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: _appBarTheme,
      colorScheme: _colorScheme,
      inputDecorationTheme: _inputDecorationTheme,
      snackBarTheme: _snackbarTheme,
    );
  }
}
