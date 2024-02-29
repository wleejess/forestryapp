import "package:flutter/material.dart";
import "package:forestryapp/components/area_properties.dart";
import "package:forestryapp/components/bottom_button_builder.dart";
import "package:forestryapp/components/db_listenable_builder.dart";
import "package:forestryapp/components/error_scaffold.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/models/area.dart";
import "package:forestryapp/models/area_collection.dart";
import "package:provider/provider.dart";

class AreaReview extends StatefulWidget {
  // Static variables //////////////////////////////////////////////////////////
  static const _titlePrefix = "Area Review";
  static const _notFoundTitle = "Area not found!";
  static const _notFoundBodyText = "Could not find that Area!";
  static const _placeholderForOmitted = "N/A";

  // Instance variables ////////////////////////////////////////////////////////
  final int _areaID;

  // Constructor ///////////////////////////////////////////////////////////////
  const AreaReview(int areaID, {super.key}) : _areaID = areaID;

  @override
  State<AreaReview> createState() => _AreaReviewState();
}

class _AreaReviewState extends State<AreaReview> {
  // Methods ///////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final Area? area =
        Provider.of<AreaCollection>(context).getByID(widget._areaID);

    // [DBListenableBuilder] necessary for redirecting to error page in event
    // that user was reviewing an area then went to delete its landowner.
    return DBListenableBuilder(
      builder: (_, __) {
        if (area == null) return _buildErrorPage();
        return buildForestryScaffold(area);
      },
    );
  }

  ErrorScaffold _buildErrorPage() {
    return const ErrorScaffold(
      title: AreaReview._notFoundTitle,
      bodyText: AreaReview._notFoundBodyText,
    );
  }

  ForestryScaffold buildForestryScaffold(Area area) {
    return ForestryScaffold(
      title: _titleText(area),
      body: Column(
        children: [
          Expanded(child: AreaProperties(area)),
          LayoutBuilder(
            builder: (context, constraints) {
              return BottomButtonBuilder().builder(context, constraints, area);
            },
          ),
        ],
      ),
    );
  }

  // Heading ///////////////////////////////////////////////////////////////////
  String _titleText(Area area) {
    final areaName = area.name ?? AreaReview._placeholderForOmitted;
    return "${AreaReview._titlePrefix}: $areaName";
  }
}
