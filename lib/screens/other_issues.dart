import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/free_text.dart";

class OtherIssues extends StatelessWidget {
  // Instance Variables
  final TextEditingController _textController = TextEditingController();
  final _title = "Forest Wellness Checkup";

  OtherIssues({super.key});

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
              labelText: "Other Issues:",
              controller: _textController,
              helperText:
                  'Describe any other health related issues you observed.',
              onChanged: (text) {},
            ),
          ],
        ),
      ),
    );
  }
}
