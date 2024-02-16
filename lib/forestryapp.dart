import 'package:flutter/material.dart';
import 'package:forestryapp/dependency_injection/inherited_settings.dart';
import 'package:forestryapp/models/basic_info_data.dart';
import 'package:forestryapp/models/landowner.dart';
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

  // Constructor ///////////////////////////////////////////////////////////////
  const ForestryApp({
    required SharedPreferences sharedPreferences,
    super.key,
  }) : _sharedPreferences = sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Landowner>(
          create: (_) => Landowner(),
        ),
        ChangeNotifierProvider<BasicInfoDataModel>(
          create:(_) => BasicInfoDataModel(),
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
        )
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
