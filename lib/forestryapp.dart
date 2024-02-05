import 'package:flutter/material.dart';
import 'package:forestryapp/screens/landowner_index.dart';

class ForestryApp extends StatelessWidget {
  const ForestryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forestry Wellness Checkup App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        )
      ),
      // Use Landowner Index for home page until settings is implemented.
      home: const LandownerIndex(),
    );
  }
}
