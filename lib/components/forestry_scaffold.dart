import 'package:flutter/material.dart';
import 'package:forestryapp/screens/area_index.dart';
import 'package:forestryapp/screens/landowner_index.dart';
import 'package:forestryapp/screens/mistletoe_form.dart';

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
            MaterialPageRoute(builder: (context) => AreaIndex()),
          );
        },
      ),
      ListTile(
        title: const Text('Mistletoe'),
        leading: const Icon(Icons.spa),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MistletoeForm()),
          );
        }
      ),
    ];
  }
}
