import 'package:flutter/material.dart';
import 'package:forestryapp/models/settings.dart';
import 'package:forestryapp/screens/area_index.dart';
import 'package:forestryapp/screens/basic_information_form.dart';
import 'package:forestryapp/screens/form_review.dart';
import 'package:forestryapp/screens/invasive_form.dart';
import 'package:forestryapp/screens/landowner_index.dart';
import 'package:forestryapp/screens/mistletoe_form.dart';
import 'package:forestryapp/screens/insects_form.dart';
import 'package:forestryapp/screens/settings_review.dart';
import 'package:forestryapp/screens/site_characteristics_form.dart';
import 'package:forestryapp/screens/vegetative_conditions_form.dart';
import 'package:forestryapp/screens/road_health_form.dart';
import 'package:forestryapp/screens/water_issues_form.dart';
import 'package:forestryapp/screens/fire_risk_form.dart';
import 'package:forestryapp/screens/other_issues_form.dart';
import 'package:provider/provider.dart';

/// A component to ensure common high level layout across screens of the app.
///
/// This scaffold can be used to ensure each screen has the same drawer
/// navigation as well as common layout choices like padding.
class ForestryScaffold extends StatelessWidget {
  // Instance variables ////////////////////////////////////////////////////////
  final String _title;
  final Widget _body;
  final Widget? _fab;
  final bool _showFormLinks;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates Material design scaffold with provided [title] and [body].
  ///
  /// Can optionally provide a Floating Action Button to shower in lower right
  /// corner. If not specified, no FAB will be shown.
  const ForestryScaffold({
    required String title,
    required Widget body,
    Widget? fab,
    bool showFormLinks = false,
    super.key,
  })  : _title = title,
        _body = body,
        _fab = fab,
        _showFormLinks = showFormLinks;

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
    List<Widget> mainLinks = [
      ListTile(
        title: const Text('Settings'),
        leading: const Icon(Icons.settings),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsReview(
                settings: Provider.of<Settings>(context),
              ),
            ),
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
        title: const Text('Areas'),
        leading: const Icon(Icons.forest),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AreaIndex()),
          );
        },
      ),
    ];
    // Links to the Area form input screens
    List<Widget> areaFormLinks = [
      const Divider(),
      ListTile(
        title: const Text('Basic Information'),
        leading: const Icon(Icons.badge),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BasicInformationForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Site Characteristics'),
        leading: const Icon(Icons.place),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SiteCharacteristicsForm()),
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
                builder: (context) => VegetativeConditionsForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Insects & Diseases'),
        leading: const Icon(Icons.pest_control),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InsectsForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Invasive & Wildlife'),
        leading: const Icon(Icons.pest_control_rodent),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const InvasiveForm()));
        },
      ),
      ListTile(
        title: const Text('Mistletoe'),
        leading: const Icon(Icons.spa),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MistletoeForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Road Health'),
        leading: const Icon(Icons.edit_road),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RoadHealthForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Water Issues'),
        leading: const Icon(Icons.water_drop),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WaterIssuesForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Fire Risk'),
        leading: const Icon(Icons.local_fire_department),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FireRiskForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Other Issues'),
        leading: const Icon(Icons.report),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OtherIssuesForm()),
          );
        },
      ),
      ListTile(
        title: const Text('Summary'),
        leading: const Icon(Icons.fact_check),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormReview()),
          );
        },
      ),
    ];
    // Form links only appear when you are editing or creating an Area
    if (_showFormLinks) {
      mainLinks.addAll(areaFormLinks);
    }
    
    return mainLinks;
  }
}
