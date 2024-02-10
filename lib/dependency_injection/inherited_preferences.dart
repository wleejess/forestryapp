import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class InheritedSharedPreferences extends InheritedWidget {
  final SharedPreferences _sharedPreferences;

  const InheritedSharedPreferences({
    required SharedPreferences sharedPreferences,
    required super.child,
    super.key,
  }) : _sharedPreferences = sharedPreferences;

  static InheritedSharedPreferences of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedSharedPreferences>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedSharedPreferences oldWidget) {
    return _sharedPreferences != oldWidget._sharedPreferences;
  }
}
