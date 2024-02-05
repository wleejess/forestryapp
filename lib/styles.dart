import 'package:flutter/material.dart';

class Styles {
  static final _colorScheme = ColorScheme.fromSeed(seedColor: Colors.green);

  static final _appBarTheme = AppBarTheme(
    backgroundColor: _colorScheme.primaryContainer,
    foregroundColor: _colorScheme.onPrimaryContainer,
  );

  static ThemeData makeTheme() {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: _appBarTheme,
      colorScheme: _colorScheme,
    );
  }
}
