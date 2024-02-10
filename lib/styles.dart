import 'package:flutter/material.dart';

class Styles {
  static final _colorScheme = ColorScheme.fromSeed(seedColor: Colors.green);

  static final _appBarTheme = AppBarTheme(
    backgroundColor: _colorScheme.primaryContainer,
    foregroundColor: _colorScheme.onPrimaryContainer,
  );

  static const _inputDecorationTheme = InputDecorationTheme(
    labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    helperStyle: TextStyle(fontSize: 14.0)
  );

  static ThemeData makeTheme() {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: _appBarTheme,
      colorScheme: _colorScheme,
      inputDecorationTheme: _inputDecorationTheme,
    );
  }
}
