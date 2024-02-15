import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import 'package:provider/provider.dart';
import 'package:forestryapp/models/veg_conditions_data.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});
  static const _confirmationTitle = 'Confirmation';

  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<VegConditionsDataModel>(context);

    return ForestryScaffold(
      title: _confirmationTitle,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Cover Type: ${formData.coverType.label}'),
              const SizedBox(height: 10),
              Text('Stand Structure: ${formData.standStructure.label}'),
              const SizedBox(height: 10),
              // Text('Overstory Density: ${formData.overstoryDensity}'),
              const SizedBox(height: 10),
              Text('Overstory Slope: ${formData.overstorySlope}'),
              const SizedBox(height: 10),
              // Text('Understory Density: ${formData.understoryDensity}'),
              const SizedBox(height: 10),
              Text('Understory Slope: ${formData.understorySlope}'),
              const SizedBox(height: 10),
              Text('Stand History: ${formData.standHistory}'),
            ],
          ),
        ),
      ),
    );
  }
}
