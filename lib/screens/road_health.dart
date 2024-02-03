import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/free_text.dart";

class RoadHealth extends StatelessWidget {
  // Instance Variables
  final TextEditingController _textController = TextEditingController();
  final _title = "Forest Wellness Checkup";

  RoadHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FreeTextBox(
              labelText: "Road Health/Conditions:",
              controller: _textController,
              helperText:
                  'Make note of any road related problems for the stand or area. This could include erosion, slumps, sediment delivery into streams or other waterways, culvert & ditch problems, etc.',
              onChanged: (text) {},
            ),
          ],
        ),
      ),
    );
  }
}
