import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import 'package:provider/provider.dart';
import 'package:forestryapp/models/veg_conditions_data.dart';
import 'package:forestryapp/models/other_issues_data.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});
  static const _confirmationTitle = 'Confirmation';

  @override
  Widget build(BuildContext context) {
    final vegConData = Provider.of<VegConditionsDataModel>(context);
    final otherIssuesData = Provider.of<OtherIssuesDataModel>(context);

    return ForestryScaffold(
      title: _confirmationTitle,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Cover Type: ${vegConData.coverType.label}'),
              const SizedBox(height: 10),
              Text('Stand Structure: ${vegConData.standStructure.label}'),
              const SizedBox(height: 10),
              Text('Overstory Density: ${vegConData.overstoryDensity}'),
              const SizedBox(height: 10),
              Text('Overstory Slope: ${vegConData.overstorySlope}'),
              const SizedBox(height: 10),
              Text('Understory Density: ${vegConData.understoryDensity}'),
              const SizedBox(height: 10),
              Text('Understory Slope: ${vegConData.understorySlope}'),
              const SizedBox(height: 10),
              Text('Stand History: ${vegConData.standHistory}'),
              const SizedBox(height: 10),
              Text('OtherIssues: ${otherIssuesData.otherIssues}'),
            ],
          ),
        ),
      ),
    );
  }
}
