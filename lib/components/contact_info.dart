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
          _buildContactInfoTable(context)
        ],
      ),
    );
  }

  Table _buildContactInfoTable(BuildContext context) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        TableRow(children: _buildTableRow(context, "Email", _email)),
        TableRow(
            children: _buildTableRow(context, "Address", _combinedAddress)),
      ],
    );
  }

  List<Widget> _buildTableRow(BuildContext context, String label, String info) {
    final TextStyle? styleValue = Theme.of(context).textTheme.headlineSmall;
    final TextStyle styleLabel =
        styleValue!.copyWith(fontWeight: FontWeight.bold);

    return [
      Container(
        alignment: Alignment.centerRight,
        child: Text("$label: ", style: styleLabel),
      ),
      SelectableText(info, style: styleValue),
    ];
  }
}
