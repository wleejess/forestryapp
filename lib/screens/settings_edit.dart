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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Wrap(
                children: [
                  // TODO: Name and Email
                  FractionallySizedBox(widthFactor: 0.5, child: Placeholder()),
                  // TODO: Address, City, State, Zip
                  FractionallySizedBox(widthFactor: 0.5, child: Placeholder()),
                ],
              ),
              const Placeholder(), // TODO: Font Size Slider
              Align(
                alignment: Alignment.bottomRight,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
