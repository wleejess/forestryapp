import 'package:flutter/material.dart';
import 'package:forestryapp/screens/area_index.dart';
import 'package:forestryapp/screens/invasive_screen.dart';
import 'package:forestryapp/screens/landowner_index.dart';
import 'package:forestryapp/screens/mistletoe_screen.dart';
import 'package:forestryapp/screens/pests_screen.dart';
import 'package:forestryapp/screens/settings_review.dart';
import 'package:forestryapp/screens/site_characteristics.dart';
import 'package:forestryapp/screens/vegetative_conditions.dart';
import 'package:forestryapp/screens/road_health.dart';
import 'package:forestryapp/screens/water_issues.dart';
import 'package:forestryapp/screens/fire_risk.dart';
import 'package:forestryapp/screens/other_issues.dart';

/// A component to ensure common high level layout across screens of the app.
///
/// This scaffold can be used to ensure each screen has the same drawer
/// navigation as well as common layout choices like padding.
class ForestryScaffold extends StatelessWidget {
  // Instance variables ////////////////////////////////////////////////////////
  final String _title;
  final Widget _body;
  final Widget? _fab;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates Material design scaffold with provided [title] and [body].
  ///
  /// Can optionally provide a Floating Action Button to shower in lower right
  /// corner. If not specified, no FAB will be shown.
  const ForestryScaffold({
    required String title,
    required Widget body,
    Widget? fab,
    super.key,
  })  : _title = title,
        _body = body,
        _fab = fab;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title), centerTitle: true),
      body: Padding(padding: const EdgeInsets.all(30), child: _body),
      drawer: Drawer(child: ListView(children: _buildDrawerItems(context))),
      floatingActionButton: _fab ?? Container(),
    );
  }

  List<Widget> _buildDrawerItems(BuildContext context) {
    return [
      ListTile(
        title: const Text('Settings'),
        leading: const Icon(Icons.settings),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsReview()),
          );
        },
      ),
      ListTile(
        title: const Text('Landowners'),
        leading: const Icon(Icons.person),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LandownerIndex()),
          );
        },
      ),
      ListTile(
        title: const Text('Site Characteristics'),
        leading: const Icon(Icons.place),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SiteCharacteristics()),
          );
        },
      ),
      ListTile(
        title: const Text('Vegetative Conditions'),
        leading: const Icon(Icons.grass),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const VegetativeConditions()),
          );
        },
      ),
      ListTile(
        title: const Text('Areas'),
        leading: const Icon(Icons.forest),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AreaIndex()),
          );
        },
      ),
      ListTile(
        title: const Text('Pests & Damage A'),
        leading: const Icon(Icons.looks_5),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PestsScreen()),
          );
        },
      ),
      ListTile(
        title: const Text('Pests & Damage B'),
        leading: const Icon(Icons.looks_6),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InvasiveScreen()));
        },
      ),
      ListTile(
        title: const Text('Mistletoe'),
        leading: const Icon(Icons.spa),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MistletoeScreen()),
          );
        },
      ),
      ListTile(
        title: const Text('Road Health'),
        leading: const Icon(Icons.edit_road),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoadHealth()),
          );
        },
      ),
      ListTile(
        title: const Text('Water Issues'),
        leading: const Icon(Icons.water_drop),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WaterIssues()),
          );
        },
      ),
      ListTile(
        title: const Text('Fire Risk'),
        leading: const Icon(Icons.local_fire_department),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FireRisk()),
          );
        },
      ),
      ListTile(
        title: const Text('Other Issues'),
        leading: const Icon(Icons.report),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OtherIssues()),
          );
        },
      ),
    ];
  }
}
