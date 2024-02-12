import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "forestryapp.dart";

void main() async {
  // Need `ensureInitialized()` when main is `async` because the we are waiting
  // for shared preferences to be initialized before calling `runApp()`.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ForestryApp(sharedPreferences: await SharedPreferences.getInstance()),
  );
}
