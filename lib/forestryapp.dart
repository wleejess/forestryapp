import 'package:flutter/material.dart';
import 'package:forestryapp/models/basic_information.dart';
import 'package:forestryapp/models/insects.dart';
import 'package:forestryapp/models/invasive.dart';
import 'package:forestryapp/models/landowner.dart';
import 'package:forestryapp/models/landowner_collection.dart';
import 'package:forestryapp/models/mistletoe.dart';
import 'package:forestryapp/models/settings.dart';
import 'package:forestryapp/models/vegetative_conditions.dart';
import 'package:forestryapp/models/road_health.dart';
import 'package:forestryapp/models/water_issues.dart';
import 'package:forestryapp/models/fire_risk.dart';
import 'package:forestryapp/models/other_issues.dart';
import 'package:forestryapp/models/site_characteristics.dart';
import 'package:forestryapp/screens/landowner_index.dart';
import 'package:forestryapp/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class ForestryApp extends StatelessWidget {
  // Instance variables  ///////////////////////////////////////////////////////
  final SharedPreferences _sharedPreferences;
  final LandownerCollection _initialLandowners;

  const ForestryApp({
    required SharedPreferences sharedPreferences,
    required LandownerCollection initialLandowners,
    super.key,
  })  : _sharedPreferences = sharedPreferences,
        _initialLandowners = initialLandowners;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Landowner>(
          create: (_) => Landowner(),
        ),
        ChangeNotifierProvider<BasicInformation>(
          create: (_) => BasicInformation(),
        ),
        ChangeNotifierProvider<VegetativeConditions>(
          create: (_) => VegetativeConditions(),
        ),
        ChangeNotifierProvider<OtherIssues>(
          create: (_) => OtherIssues(),
        ),
        ChangeNotifierProvider<RoadHealth>(
          create: (_) => RoadHealth(),
        ),
        ChangeNotifierProvider<WaterIssues>(
          create: (_) => WaterIssues(),
        ),
        ChangeNotifierProvider<FireRisk>(
          create: (_) => FireRisk(),
        ),
        ChangeNotifierProvider<Mistletoe>(
          create: (_) => Mistletoe(),
        ),
        ChangeNotifierProvider<Invasive>(
          create: (_) => Invasive(),
        ),
        ChangeNotifierProvider<Insects>(
          create: (_) => Insects(),
        ),
        ChangeNotifierProvider<SiteCharacteristics>(
          create: (_) => SiteCharacteristics(),
        ),
        Provider<Settings>(
          create: (_) => Settings(_sharedPreferences),
        ),
        ChangeNotifierProvider<LandownerCollection>.value(
          value: _initialLandowners,
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
