import "package:flutter/material.dart";

/// Widget for creating radio options, can be reused in different pages.

class RadioOptions extends StatefulWidget {
  final String header;
  final List<String> options;
  final void Function(int) onSelected;

  RadioOptions(
      {required this.header, required this.options, required this.onSelected});

  @override
  _RadioOptionsState createState() => _RadioOptionsState();
}

class _RadioOptionsState extends State<RadioOptions> {
  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            widget.header,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...List.generate(
          widget.options.length,
          (index) => ListTile(
            title: Text(widget.options[index]),
            leading: Radio<int>(
              value: index,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                  widget.onSelected(selectedOption);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}