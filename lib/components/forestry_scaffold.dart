import 'package:flutter/material.dart';

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
      floatingActionButton: _fab ?? Container(),
    );
  }
}
