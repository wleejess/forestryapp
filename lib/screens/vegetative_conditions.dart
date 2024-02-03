import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/free_text.dart";
import "package:forestryapp/components/radio_options.dart";

class VegetativeConditions extends StatelessWidget {
  // Instance Variables
  final TextEditingController _coverType = TextEditingController();
  final _title = "Vegetative Conditions";

  VegetativeConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Cover Type (Free text for now, maybe dropdown?)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FreeTextBox(
                    labelText: 'Cover Type',
                    controller: _coverType,
                    onChanged: (text) {
                      // Handle elevation text changes
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Slope Position
              RadioOptions(
                labelText: 'Stand Structure:',
                options: const ['Even-aged', 'Two-aged', 'Multi-aged'],
                onSelected: (selectedOption) {
                  // Handle slope position selection
                },
              ),

              const SizedBox(height: 16.0),

              RadioOptions(
                labelText: 'Overstory Stand Density:',
                options: const ['Low', 'Medium', 'High'],
                onSelected: (selectedOption) {
                  // Handle slope position selection
                },
              ),

              const SizedBox(height: 16.0),

              RadioOptions(
                labelText: 'Understory Stand Density:',
                options: const ['Low', 'Medium', 'High'],
                onSelected: (selectedOption) {
                  // Handle slope position selection
                },
              ),

              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
