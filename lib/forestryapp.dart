import 'package:flutter/material.dart';
import 'package:forestryapp/dependency_injection/inherited_preferences.dart';
import 'package:forestryapp/screens/landowner_index.dart';
import 'package:forestryapp/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForestryApp extends StatelessWidget {
  // Instance variables  ///////////////////////////////////////////////////////
  final SharedPreferences _sharedPreferences;

  // Constructor ///////////////////////////////////////////////////////////////
  const ForestryApp({
    required SharedPreferences sharedPreferences,
    super.key,
  }) : _sharedPreferences = sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return InheritedSharedPreferences(
      sharedPreferences: _sharedPreferences,
      child: MaterialApp(
        title: 'Forestry Wellness Checkup App',
        theme: Styles.makeTheme(),
        // Use Landowner Index for home page until settings is implemented.
        home: const LandownerIndex(),
      ),
    );
  }
}
