import 'package:flutter/material.dart';
import 'package:forestryapp/components/forestry_scaffold.dart';

class SettingsEdit extends StatefulWidget {
  const SettingsEdit({super.key});

  @override
  State<SettingsEdit> createState() => _SettingsEditState();
}

class _SettingsEditState extends State<SettingsEdit> {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Edit Settings";

  // Instance variables ////////////////////////////////////////////////////////
  final _formKey = GlobalKey<FormState>();

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: Form(
        key: _formKey,
        child: const Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
