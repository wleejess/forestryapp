import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/form_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/screens/insects_form.dart";
import "package:forestryapp/screens/mistletoe_form.dart";
import 'package:forestryapp/components/unsaved_changes.dart';

import "package:provider/provider.dart";

class InvasiveForm extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _title = "Invasives & Wildlife Damages";
  static const _invasiveHeading = "Invasive plants & animals";
  static const _invasiveDescription =
      "List any invasive plants or animals observed.";
  static const _wildlifeHeading = "Wildlife damage/issues";
  static const _wildlifeDescription =
      "Describe wildlife damage to tree seedlings, "
      "saplings or mature trees.\nIf regeneration is damaged, estimate the percentage "
      "of seedlings/saplings affected.";

  // Constructor ///////////////////////////////////////////////////////////////
  /// Creates a screen to enter information on invasive plants and animals,
  /// and wildlife damage present in the area.
  const InvasiveForm({super.key});

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
        showFormLinks: true,
        title: InvasiveForm._title,
        body: FormScaffold(
            prevPage: const InsectsForm(),
            nextPage: const MistletoeForm(),
            child: Column(
              children: <Widget>[
                _buildInvasiveInput(context),
                _buildWildlifeInput(context),
              ],
            )));
  }

  /// Builds a text input field about invasive plants and animals in the area.
  Widget _buildInvasiveInput(BuildContext context) {
    final invasiveData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return FreeTextBox(
        labelText: InvasiveForm._invasiveHeading,
        helperText: InvasiveForm._invasiveDescription,
        initialValue: invasiveData.invasives,
        onChanged: (text) {
          invasiveData.invasives = text;
          unsavedChangesNotifier.setUnsavedChanges(true);
        });
  }

  /// Builds a text input field about wildlife damage in the area.
  Widget _buildWildlifeInput(BuildContext context) {
    final invasiveData = Provider.of<Area>(context);
    final unsavedChangesNotifier = Provider.of<UnsavedChangesNotifier>(context);

    return FreeTextBox(
        labelText: InvasiveForm._wildlifeHeading,
        helperText: InvasiveForm._wildlifeDescription,
        initialValue: invasiveData.wildlifeDamage,
        onChanged: (text) {
          invasiveData.wildlifeDamage = text;
          unsavedChangesNotifier.setUnsavedChanges(true);
        });
  }
}
