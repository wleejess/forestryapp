import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class InheritedSharedPreferences extends InheritedWidget {
  // Make this public or else it will be useless because callers won't be able
  // to even access it.
  final SharedPreferences sharedPreferences;

  const InheritedSharedPreferences({
    required this.sharedPreferences,
    required super.child,
    super.key,
  });

  static InheritedSharedPreferences of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedSharedPreferences>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedSharedPreferences oldWidget) {
    return sharedPreferences != oldWidget.sharedPreferences;
  }
}
