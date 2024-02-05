import 'package:flutter/material.dart';

class Styles {
  static final _colorScheme = ColorScheme.fromSeed(seedColor: Colors.green);

  static ThemeData makeTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
    );
  }
}
