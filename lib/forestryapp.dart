import 'package:flutter/material.dart';
import 'package:forestryapp/models/basic_information.dart';
import 'package:forestryapp/models/insects.dart';
import 'package:forestryapp/models/invasive.dart';
import 'package:forestryapp/models/landowner.dart';
import 'package:forestryapp/models/landowner_collection.dart';
import 'package:forestryapp/models/mistletoe.dart';
import 'package:forestryapp/models/settings.dart';
import 'package:forestryapp/models/veg_conditions_data.dart';
import 'package:forestryapp/models/road_health_data.dart';
import 'package:forestryapp/models/water_issues_data.dart';
import 'package:forestryapp/models/fire_risk_data.dart';
import 'package:forestryapp/models/other_issues_data.dart';
import 'package:forestryapp/screens/landowner_index.dart';
import 'package:forestryapp/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class ForestryApp extends StatelessWidget {
  // Instance variables  ///////////////////////////////////////////////////////
  final SharedPreferences _sharedPreferences;
  final LandownerCollection _initialLandowners;

  // Constructor ///////////////////////////////////////////////////////////////
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
        ChangeNotifierProvider<VegConditionsDataModel>(
          create: (_) => VegConditionsDataModel(),
        ),
        ChangeNotifierProvider<OtherIssuesDataModel>(
          create: (_) => OtherIssuesDataModel(),
        ),
        ChangeNotifierProvider<RoadHealthDataModel>(
          create: (_) => RoadHealthDataModel(),
        ),
        ChangeNotifierProvider<WaterIssuesDataModel>(
          create: (_) => WaterIssuesDataModel(),
        ),
        ChangeNotifierProvider<FireRiskDataModel>(
          create: (_) => FireRiskDataModel(),
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
        // Use Landowner Index for home page until settings is implemented.
        home: const LandownerIndex(),
      ),
    );
  }
}
