/// Enum representing different types of land cover.
/// Forestry professionals will know what this refers to.
enum CoverType {
  na("N/A"),
  forest("Forest"),
  meadow("Meadow"),
  wetland("Wetland"),
  rangeland("Rangeland"),
  juniperwoodlands("Juniper Woodlands");

  const CoverType(this.label);

  final String label;
}
