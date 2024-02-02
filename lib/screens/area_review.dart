import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";

class AreaReview extends StatelessWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _titlePrefix = "Area Review";

  // Instance variables ////////////////////////////////////////////////////////
  final String _area;

  // Constructor ///////////////////////////////////////////////////////////////
  const AreaReview({required String area, super.key}) : _area = area;

  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: "$_titlePrefix: $_area",
      body: Column(
        children: [
          _buildAreaNameHeading(context),
          Expanded(child: _buildAreaPropertiesListView(context)),
          _buildButtonRow(context),
        ],
      ),
    );
  }

  // Heading ///////////////////////////////////////////////////////////////////
  Widget _buildAreaNameHeading(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(_area, style: Theme.of(context).textTheme.headlineMedium),
    );
  }

  // Area Properties ///////////////////////////////////////////////////////////
  Widget _buildAreaPropertiesListView(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int i) {
        return _buildAreaPropertyListTile(context, "$i", "${i * 1000}");
      },
    );
  }

  Widget _buildAreaPropertyListTile(
    BuildContext context,
    String propertyLabel,
    String propertyToDisplay,
  ) {
    return ListTile(
      title: Wrap(
        alignment: WrapAlignment.start,
        children: [Text("$propertyLabel: "), Text(propertyToDisplay)],
      ),
    );
  }

  // Buttons ///////////////////////////////////////////////////////////////////
  _buildButtonRow(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(onPressed: () {}, child: const Text("Generate PDF")),
        OutlinedButton(onPressed: () {}, child: const Text("Send Email")),
        Expanded(child: Container()),
        OutlinedButton(onPressed: () {}, child: const Text("Edit")),
        OutlinedButton(onPressed: () {}, child: const Text("Delete")),
      ],
    );
  }
}
