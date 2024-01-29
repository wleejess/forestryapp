import "package:flutter/material.dart";
import "package:forestryapp/components/forestry_scaffold.dart";
import "package:forestryapp/components/relative_sized_box.dart";
import "package:forestryapp/util/relative_size.dart";

class MistletoeForm extends StatelessWidget {
  // Static variables ///////////////////////////////////////////////////
  static const _title = "Mistletoe Infections";
  static const _buttonLabelPrev = "Previous";
  static const _buttonLabelNext = "Next";

  static const double _heightButton = 0.05;

  // Constructor //////////////////////////////////////////
  // Creates a screen with a form to enter data on mistletoe infections.
  const MistletoeForm({
    super.key,
  });

  // Methods ///////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ForestryScaffold(
      title: _title, 
      body: Column(
        children: <Widget>[
        ],
      ),
    );
  }


}