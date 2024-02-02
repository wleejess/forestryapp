import "package:flutter/material.dart";

class ContactInfo extends StatelessWidget {
  // Instance Variables ////////////////////////////////////////////////////////
  final String _name;
  final String _email;
  final String _combinedAddress;

  // Constructor ///////////////////////////////////////////////////////////////
  const ContactInfo({
    required String name,
    required String email,
    required String combinedAddress,
    super.key,
  })  : _name = name,
        _email = email,
        _combinedAddress = combinedAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            _name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          _buildContactInfoTable()
        ],
      ),
    );
  }

  Table _buildContactInfoTable() {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        TableRow(children: _buildTableRow("Email", _email)),
        TableRow(children: _buildTableRow("Address", _combinedAddress)),
      ],
    );
  }

  List<Widget> _buildTableRow(String label, String info) {
    return [
      Container(
          alignment: Alignment.centerRight,
          child: Text("$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold))),
      SelectableText(info),
    ];
  }
}
