import 'package:flutter/material.dart';
import 'package:forestryapp/models/area_collection.dart';
import 'package:forestryapp/models/landowner.dart';
import 'package:forestryapp/models/landowner_collection.dart';
import 'package:forestryapp/models/settings.dart';
import 'package:forestryapp/models/area.dart';

import 'package:forestryapp/screens/landowner_index.dart';
import 'package:forestryapp/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class ForestryApp extends StatelessWidget {
  // Instance variables  ///////////////////////////////////////////////////////
  final SharedPreferences _sharedPreferences;
  final LandownerCollection _initialLandowners;
  final AreaCollection _initialAreas;

  const ForestryApp(
    SharedPreferences sharedPreferences,
    LandownerCollection initialLandowners,
    AreaCollection initialAreas, {
    super.key,
  })  : _sharedPreferences = sharedPreferences,
        _initialLandowners = initialLandowners,
        _initialAreas = initialAreas;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Landowner>(
          create: (_) => Landowner(),
        ),
        ChangeNotifierProvider<Area>(
          create: (_) => Area(),
        ),
        Provider<Settings>(
          create: (_) => Settings(_sharedPreferences),
        ),
        ChangeNotifierProvider<LandownerCollection>.value(
          value: _initialLandowners,
        ),
        ChangeNotifierProvider<AreaCollection>.value(
          value: _initialAreas,
        ),
      ],
      child: MaterialApp(
        title: 'Forestry Wellness Checkup App',
        theme: Styles.makeTheme(),
        home: const LandownerIndex(),
      ),
    );
  }
}
