import 'package:flutter/material.dart';
import 'package:forestryapp/screens/other_issues.dart';

class ForestryApp extends StatelessWidget {
  const ForestryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forestry Wellness Checkup App',
      home: OtherIssues(),
    );
  }
}
