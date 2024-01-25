import 'package:flutter/material.dart';

/// A component to ensure common high level layout across screens of the app.
///
/// This scaffold can be used to ensure each screen has the same drawer
/// navigation as well as common layout choices like padding.
class ForestryScaffold extends StatelessWidget {
  // Instance variables ////////////////////////////////////////////////////////
  final String _title;
  final Widget _body;

  // Constructor ///////////////////////////////////////////////////////////////
  const ForestryScaffold({required title, required body, super.key})
      : _title = title,
        _body = body;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: _body,
      ),
      // For now use `Drawer` to keep it simple as we haven't implemented routes
      // yet. May want to switch to `NavigationDrawer` in the future.
      drawer: Drawer(
        child: ListView(
          children: const [
            ListTile(title: Text('Landowners'), leading: Icon(Icons.person)),
            ListTile(title: Text('Checklists'), leading: Icon(Icons.list_alt)),
            ListTile(title: Text('Settings'), leading: Icon(Icons.settings))
          ],
        ),
      ),
    );
  }
}
