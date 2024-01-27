import 'package:flutter/material.dart';
import 'package:forestryapp/screens/landowner_index.dart';

class ForestryApp extends StatelessWidget {
  const ForestryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Forestry Wellness Checkup App',
      // Use Landowner Index for home page until settings is implemented.
      home: LandownerIndex(),
    );
  }
}
