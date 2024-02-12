import "package:flutter/material.dart";
import "package:forestryapp/models/settings.dart";

class InheritedSettings extends InheritedWidget {
  // Make this public or else it will be useless because callers won't be able
  // to even access it.
  final Settings settings;

  const InheritedSettings({
    required this.settings,
    required super.child,
    super.key,
  });

  static InheritedSettings of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedSettings>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedSettings oldWidget) {
    return settings != oldWidget.settings;
  }
}
