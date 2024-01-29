import "package:flutter/material.dart";

/// Class to compute relative distances from device dimesnions.
class RelativeSize {
  /// Uses device orientation to compute height.
  ///
  /// Gives pixels for specified percentage of height of current orientation.
  static double computeHeight(BuildContext context, double percentage) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return MediaQuery.of(context).size.height * percentage;
    } else {
      return MediaQuery.of(context).size.width * percentage;
    }
  }
}
